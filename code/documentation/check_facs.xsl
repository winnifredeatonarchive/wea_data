<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:param name="failOnError"
        static="yes" 
        select="true()" 
        as="xs:boolean"/>
    
    <xsl:output method="text"/>
    
    <xsl:mode name="ids" on-no-match="shallow-skip"/>
    <xsl:mode name="errors" on-no-match="shallow-skip"/>
    
    <xsl:variable name="data" 
        select="uri-collection('../../data?select=*;recurse=yes')"
        as="xs:anyURI+"/>
    
    <xsl:variable name="xml" 
        select="$data[ends-with(.,'.xml')]" 
        as="xs:anyURI+"/>
    
    <xsl:variable name="binaries"
        select="$data[not(. = $xml)]"
        as="xs:anyURI+"/>
    
    <xsl:variable name="dataDocs"
        select="$xml ! document(.)"
        as="document-node()+"/>
    
    
    <xsl:variable name="idMap" as="map(*)">
        <xsl:map>
            <xsl:apply-templates select="$dataDocs[//@xml:id]" mode="ids"/>
            <xsl:for-each select="$binaries">
                <xsl:map-entry key="substring-after(.,'/data/')" select="true()"/>
            </xsl:for-each>
            <xsl:map-entry key="'azindex.xml'" select="true()"/>
        </xsl:map>
    </xsl:variable>

    <xsl:variable name="prefixMap" as="map(*)">
        <xsl:apply-templates select="$dataDocs//listPrefixDef" mode="prefixes"/>
    </xsl:variable>
    
    <xsl:variable name="prefixes"
        select="map:keys($prefixMap)" 
        as="xs:string*"/>
    
    <xsl:variable name="prefixRex"
        select="'(^|\s+)(' || string-join($prefixes,'|') || '):'"
        as="xs:string"/>
    
    <xsl:variable name="els"
        select="$dataDocs//*[not(self::graphic[ancestor::TEI[@xml:id='media']])][@*[matches(.,$prefixRex)]]"
        as="element()+"/>
    <xsl:variable name="atts" select="$els/@*[matches(.,$prefixRex)]" 
        as="attribute()+"/>
    

    <xsl:template name="check">
        <xsl:call-template name="checkPointers"/>
        <xsl:message>Done!</xsl:message>
    </xsl:template>
    
    
    <xsl:template name="checkPointers">        
        <xsl:iterate select="$dataDocs">
            <xsl:param name="errors" as="map(*)*" select="()"/>
            <xsl:on-completion>
                <xsl:variable name="merged" select="map:merge($errors)" as="map(*)"/>
                <xsl:sequence select="map:keys($merged)"/>
                <xsl:on-non-empty>
                    <xsl:message _terminate="{xs:string($failOnError)}">
                        <xsl:for-each-group select="map:keys($merged)" group-by="$merged(.)">
                            <xsl:variable name="ptr" select="current-grouping-key()"/>
                            <xsl:message>
                                <xsl:value-of select="'ERROR: Bad pointer: ' || $ptr || ' found in the following documents: ' || string-join(current-group(), ', ')"/>
                            </xsl:message>
                        </xsl:for-each-group>
                    </xsl:message>
                </xsl:on-non-empty>
            </xsl:on-completion>
            <xsl:next-iteration>
                <xsl:with-param name="errors" as="map(*)*">
                    <xsl:sequence select="$errors"/>
                    <xsl:apply-templates select="//TEI" mode="errors"/>
                </xsl:with-param>
            </xsl:next-iteration>
        </xsl:iterate>
    </xsl:template>
    
    <xsl:template match="TEI" mode="errors" as="map(*)?">
        <xsl:variable name="errors" as="xs:string*">
            <xsl:apply-templates mode="#current"/>
        </xsl:variable>
        <xsl:if test="exists($errors)">
            <xsl:sequence select="map{string(@xml:id): $errors}"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="link[ancestor::TEI[@xml:id='redirects']]/@target" mode="errors">
        <xsl:variable name="tokens"
            select="tokenize(.)[position() gt 1][matches(.,$prefixRex)]"
            as="xs:string*"/>
        <xsl:sequence select="wea:checkPointers($tokens)"/>
    </xsl:template>
    
    <xsl:template match="figure/graphic[@mimeType]/@url[matches(.,$prefixRex)]" mode="errors">
        <xsl:variable name="ptr" 
            select=". || '.' || tokenize(parent::graphic/@mimeType,'/')[last()]" as="xs:string"/>
        <xsl:sequence select="wea:checkPointers($ptr)"/>
    </xsl:template>

    <xsl:template match="@*[matches(., $prefixRex)]" priority="0" mode="errors">
          <xsl:variable
              name="tokens" select="tokenize(.)[matches(.,$prefixRex)]" 
              as="xs:string*"/>
          <xsl:sequence select="wea:checkPointers($tokens)"/>
    </xsl:template>
    
    
    <xsl:template match="TEI[@xml:id]" mode="ids">
        <xsl:variable name="base" select="@xml:id || '.xml'" as="xs:string"/>
        <xsl:map-entry key="$base" select="true()"/>
        <xsl:apply-templates select="*" mode="ids">
            <xsl:with-param name="base" select="$base" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="@xml:id" priority="2" mode="ids">
        <xsl:param name="base" as="xs:string" tunnel="yes"/>
        <xsl:map-entry key="$base || '#' || ." select="true()"/>
        <xsl:next-match/>
    </xsl:template>
    
    <xsl:template match="category/@xml:id" mode="ids">
        <xsl:map-entry key=". || '.xml'" select="true()"/>
    </xsl:template>
    
    <xsl:template match="linkGrp/@xml:id" mode="ids">
        <xsl:map-entry key=". || '.xml'" select="true()"/>
    </xsl:template>
    
    <xsl:template match="listBibl/@xml:id" mode="ids">
        <xsl:map-entry key=". || '.xml'" select="true()"/>
    </xsl:template>
    

    
    <xsl:template match="listPrefixDef" mode="prefixes">
        <xsl:map>
            <xsl:for-each-group select="listPrefix" group-by="@ident">
                <xsl:map-entry key="string(@ident)" select="array{
                        current-group() ! map{'matchPattern': string(@matchPattern), 'replacementPattern': string(@replacementPattern)}
                    }"/>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:template>
    
    <!--<xsl:template match="prefixDef" mode="prefixes">
        <xsl:map-entry key="string(@ident)">
            <xsl:map>
                <xsl:apply-templates select="@*" mode="#current"/>
            </xsl:map>
        </xsl:map-entry>
    </xsl:template>
    
    <xsl:template match="prefixDef/@*" mode="prefixes">
        <xsl:if test="not(local-name() = 'ident')">
            <xsl:map-entry key="local-name()" select="string(.)"/>
        </xsl:if>
    </xsl:template>-->
        
    <xsl:template match="text()" mode="#all"/>
    
    
    <xsl:function name="wea:checkPointers" as="xs:string*" new-each-time="no">
        <xsl:param name="ptrs" as="xs:string*"/>
        <xsl:sequence select="$ptrs[not(map:contains($idMap, wea:resolvePointer(.)))]"/>
    </xsl:function>
    
    <xsl:function name="wea:resolvePointer" as="xs:string" new-each-time="no">
        <xsl:param name="ptr" as="xs:string"/>
        <xsl:variable name="bits" select="tokenize($ptr,':')" as="xs:string+"/>
        <xsl:variable name="ident" select="$bits[1]" as="xs:string"/>
        <xsl:variable name="val" select="$bits[2]" as="xs:string"/>
        <xsl:variable name="maps" select="$prefixMap($ident)" as="array(*)"/>
        <xsl:iterate select="array:flatten($maps)">
            <xsl:on-completion>
                <xsl:sequence select="''"/>
            </xsl:on-completion>
            <xsl:variable name="map" select="."/>
            <xsl:if test="matches($val, $map?matchPattern)">
                <xsl:break select="replace($val, $map?matchPattern, $map?replacementPattern)"/>
            </xsl:if>
        </xsl:iterate>
    </xsl:function>
    
    
    
</xsl:stylesheet>