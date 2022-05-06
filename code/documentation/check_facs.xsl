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
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:output method="text"/>
    
    <xsl:mode name="ids" on-no-match="shallow-skip"/>
    
    <xsl:variable name="dataDocs" select="collection('../../data/?select=*.xml;recurse=yes')"/>
    
    <xsl:variable name="idMap" as="map(*)">
        <xsl:map>
            <xsl:apply-templates select="$dataDocs[//@xml:id]" mode="ids"/>
            <xsl:for-each select="uri-collection('../../data/?select=*;recurse=yes')[not(ends-with(.,'.xml'))]">
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
    

    <xsl:template name="check">
        <xsl:call-template name="checkPointers"/>
    </xsl:template>
    
    <xsl:template name="checkPointers">
        <xsl:variable name="els"
            select="$dataDocs//*[not(self::graphic[ancestor::TEI[@xml:id='media']])][@*[matches(.,$prefixRex)]]"
            as="element()+"/>
        <xsl:variable name="atts" select="$els/@*[matches(.,$prefixRex)]" 
            as="attribute()+"/>
        <xsl:message>
            <xsl:for-each-group 
                select="$atts"
                group-by="wea:getPointers(.)">
                <xsl:call-template name="resolvePointers"/>
            </xsl:for-each-group>
            <xsl:on-non-empty>
                <xsl:message terminate="no"/>
            </xsl:on-non-empty>
        </xsl:message>
    </xsl:template>
    
    <xsl:template name="resolvePointers">
        <xsl:variable name="attGroup" select="current-group()" as="attribute()*"/>
        <xsl:variable name="ptr" select="current-grouping-key()" as="xs:string"/>
        <xsl:variable name="resolved" select="wea:resolvePointer($ptr)" as="xs:string"/>
        <xsl:variable name="error" select="not(map:contains($idMap, $resolved))" as="xs:boolean"/>
        <xsl:if test="$error">
           <!-- <xsl:value-of select="current-grouping-key()"/>-->
            <xsl:message>
                <xsl:value-of select="'WARNING: Bad pointer: ' || $ptr || ' found in the following documents: '"/>
                <xsl:value-of separator=", ">
                    <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                        <xsl:sequence select="string(current-grouping-key())"/>
                    </xsl:for-each-group>
                </xsl:value-of>
            </xsl:message>
        </xsl:if>
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
    
    <xsl:template match="listBibl/@xml:id" mode="ids">
        <xsl:map-entry key=". || '.xml'" select="true()"/>
    </xsl:template>
    
    <xsl:template match="text()" mode="ids"/>
    
    <xsl:template match="listPrefixDef" mode="prefixes">
        <xsl:map>
            <xsl:apply-templates select="*" mode="#current"/>
        </xsl:map>
    </xsl:template>
    
    <xsl:template match="prefixDef" mode="prefixes">
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
    </xsl:template>
    
    
    <xsl:function name="wea:getPointers" as="xs:string*" new-each-time="no">
        <xsl:param name="att" as="attribute()"/>
        <xsl:variable name="tokens" select="tokenize($att)" as="xs:string+"/>
        <xsl:variable name="ptrs" select="$tokens[matches(.,$prefixRex)]" as="xs:string*"/>
        <xsl:sequence 
            select="
            if ($att/parent::link and $att/ancestor::TEI/@xml:id='redirects') 
            then $ptrs[2] else $ptrs"/>
    </xsl:function>
    
    <xsl:function name="wea:resolvePointer" as="xs:string" new-each-time="no">
        <xsl:param name="ptr" as="xs:string"/>
        <xsl:variable name="bits" select="tokenize($ptr,':')" as="xs:string+"/>
        <xsl:variable name="ident" select="$bits[1]" as="xs:string"/>
        <xsl:variable name="val" select="$bits[2]" as="xs:string"/>
        <xsl:variable name="map" select="$prefixMap($ident)"/>
        <xsl:sequence select="replace($val, $map?matchPattern, $map?replacementPattern)"/>
    </xsl:function>
    
    
    
</xsl:stylesheet>