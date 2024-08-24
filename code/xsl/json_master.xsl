<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jul 25, 2024</xd:p>
            <xd:p><xd:b>Author:</xd:b> takeda</xd:p>
            <xd:p>Stylesheet to process texts into JSON for data analysis.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:include href="globals.xsl"/>
    
    <xsl:mode on-no-match="shallow-skip"/>
    
    <xsl:variable name="NEWLINE" select="codepoints-to-string(10)" as="xs:string"/>
    <xsl:variable name="DOUBLEQUOTE" as="xs:string">"</xsl:variable>

    <xsl:template name="go">
        <xsl:call-template name="texts"/>
        <xsl:call-template name="orgs"/>
        <xsl:call-template name="taxonomies"/>
    </xsl:template>
    
    <!--This could be done more elegantly using templates, but it's 
        simple enough to iterate through all-->
    <xsl:template name="taxonomies">
        <xsl:variable name="taxData" as="map(*)">
            <xsl:map>
                <xsl:for-each select="$taxonomies//category[@xml:id]">
                    <xsl:map-entry key="string(@xml:id)">
                        <xsl:map>
                            <xsl:map-entry key="'id'" select="string(@xml:id)"/>
                            <xsl:map-entry key="'name'" select="normalize-space(catDesc/term)"/>
                            <xsl:if test="parent::category[@xml:id]">
                                <xsl:map-entry key="'parent'" select="string(parent::category[@xml:id]/@xml:id)"/>
                            </xsl:if>
                            <xsl:if test="child::category[@xml:id]">
                                <xsl:map-entry key="'children'"
                                    select="array{child::category[@xml:id]/@xml:id/string(.)}"/>
                            </xsl:if>
                            <xsl:map-entry key="'taxonomy'" select="string(ancestor::taxonomy[@xml:id][last()]/@xml:id)"/> 
                        </xsl:map>
                    </xsl:map-entry>
                </xsl:for-each> 
            </xsl:map>
        </xsl:variable>
        
        <xsl:result-document href="{$outDir}json/taxonomies.json" method="json" indent="yes">
            <xsl:message select="'Creating ' || current-output-uri()"/>
           <xsl:sequence select="$taxData"/>
        </xsl:result-document>
        
        <xsl:result-document href="{$outDir}json/taxonomies.csv" method="text">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:sequence select="wea:csvFromMap($taxData)"/>
        </xsl:result-document>
        
    </xsl:template>
    
    <!--Very basic template for organizations-->
    <xsl:template name="orgs">
        <xsl:variable name="orgData" as="map(*)">
            <xsl:map>
                <xsl:for-each select="$standaloneXml[//TEI[@xml:id='organizations']]//listOrg/org[@xml:id]">
                    <xsl:map-entry key="string(@xml:id)">
                        <xsl:map>
                            <xsl:map-entry key="'id'" select="string(@xml:id)"/>
                            <xsl:map-entry key="'name'" select="string(orgName[1])"/>
                        </xsl:map>
                    </xsl:map-entry>
                </xsl:for-each>
            </xsl:map>
        </xsl:variable>
        
        <xsl:result-document href="{$outDir}json/orgs.json" method="json" indent="yes">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:sequence select="$orgData"/>
        </xsl:result-document>
        
        <xsl:result-document href="{$outDir}json/orgs.csv" method="text">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:sequence select="wea:csvFromMap($orgData)"/>
        </xsl:result-document>
    </xsl:template>
    

    <!--Process the texts into a single document-->
    <xsl:template name="texts">
        
        <xsl:variable name="textData" as="map(*)">
            <xsl:map>
                <xsl:apply-templates select="$standaloneXml[//sourceDesc/msDesc]"/>
            </xsl:map>
        </xsl:variable>
        
        <xsl:result-document href="{$outDir}json/texts.json" method="json" indent="yes">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:sequence select="$textData"/>
        </xsl:result-document>
        
        <xsl:result-document href="{$outDir}json/texts.csv" method="text">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:sequence select="wea:csvFromMap($textData)"/>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="TEI">
        <xsl:map-entry key="@xml:id">
            <xsl:map>
                <xsl:map-entry key="'id'" select="string(@xml:id)"/>
                <xsl:apply-templates select="teiHeader/fileDesc/titleStmt/title[1]"/>
                <xsl:apply-templates select="teiHeader/revisionDesc"/>
                <xsl:apply-templates select="teiHeader/fileDesc/sourceDesc/msDesc"/>
                <xsl:apply-templates select="teiHeader/profileDesc/textClass"/>
                <xsl:apply-templates select="text[not(@type='standoff')]"/>
            </xsl:map>
        </xsl:map-entry>        
    </xsl:template>
    
    
    <xsl:template match="revisionDesc">
        <xsl:map-entry key="'status'" select="string(@status)"/>
    </xsl:template>
    
    
    
    <xsl:template match="teiHeader/fileDesc/titleStmt/title">
        <xsl:map-entry key="'title'" select="string-join(descendant::text()) => normalize-space()"/>
    </xsl:template>
    
    <!--Process the textClass to create genres-->
    <xsl:template match="textClass">
        <xsl:for-each-group select="catRef" group-by="@scheme">
            <xsl:map-entry key="substring-after(current-grouping-key(),'#')" select="array{current-group() ! substring-after(@target,'#')}"/>
        </xsl:for-each-group>
    </xsl:template>
    
    <!--Quick processing for the bibls-->
    <xsl:template match="bibl">
        <xsl:for-each-group select="*[not(self::title)]" group-by="local-name()">
            <xsl:variable name="content" as="item()*">
                <xsl:apply-templates select="current-group()"/>
            </xsl:variable>
            <xsl:if test="not(empty($content))">
                <xsl:map-entry key="current-grouping-key()" select="array{$content}"/>
            </xsl:if>
            <xsl:if test="current-grouping-key() = 'date'">
                <xsl:map-entry key="'pubDate'" 
                    select="if ($content[1] ne '' and count($content) = 1) then wea:expandDate($content[1]) else ''"/>
            </xsl:if>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="bibl/date" priority="2">
        <xsl:choose>
            <xsl:when test="not(@*)"/>
            <xsl:when test="@when"><xsl:sequence select="string(@when)"/></xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="string((@from, @notBefore, '')[1])"/>
                <xsl:sequence select="string((@to, @notAfter, '')[1])"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="bibl/title" priority="2"/>
    
    <xsl:template match="bibl/publisher | bibl/distributor" priority="2">
        <xsl:choose>
            <xsl:when test="@ref"><xsl:sequence select="substring-after(@ref,'#')"/></xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="string-join(descendant::text(),'') =>
                    normalize-space()"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="bibl/biblScope" priority="2"/>
    
    <xsl:template match="bibl/idno" priority="2">
        <xsl:sequence select="string(.)"/>
    </xsl:template>
    
    
    <!--Basic info about each bibl-->
<!--    <xsl:template match="bibl/*" priority="1">
        <xsl:map>
            <xsl:for-each select="@*">
                <xsl:map-entry key="local-name()" select="string(.)"/>
            </xsl:for-each>
            <xsl:if test="not(@ref) and child::*[@ref]">
                <xsl:map-entry key="'ref'" select="string(child::*[@ref][1]/@ref)"/>
            </xsl:if>
            <xsl:map-entry key="'_'" select="string-join(descendant::text()) => normalize-space()"/>
        </xsl:map>    
    </xsl:template>-->
    
    <!--Basic stats about the text-->
    <xsl:template match="TEI/text">
        <xsl:variable name="pseudonyms" as="xs:string*">
            <xsl:for-each-group select="//name[@ref='#WE1'][not(ancestor::note[@type='editorial'])]" group-by="wea:makePseudo(wea:createSplitNameEl(.))">
                <xsl:sequence select="current-grouping-key()"/>
            </xsl:for-each-group>
        </xsl:variable>
        <xsl:map-entry key="'pseudonyms'" select="array{$pseudonyms}"/>
        <xsl:map-entry key="'wc'" select="wea:getWordCount(.)"/>    
    </xsl:template>
    
    
    
    <xsl:function name="wea:csvFromMap" as="xs:string">
        <xsl:param name="_map" as="map(*)"/>
        <xsl:variable name="rowIds" select="map:keys($_map)" as="xs:string+"/>
        <xsl:variable name="header" 
            select="distinct-values($rowIds ! map:keys($_map(.))) 
            => sort((),function($headerVal){
                if ($headerVal = 'id') then 0 else 1
                })" 
            as="xs:string+"/>
        <xsl:variable name="headerRow" select="wea:row($header)"/>
        <xsl:variable name="dataRows" as="xs:string+">
            <xsl:for-each select="$rowIds">
                <xsl:variable name="entry" select="$_map(.)" as="map(*)"/>
                <xsl:variable name="values" as="xs:string+" select="$header ! wea:valueFromMap($entry(.))"/>
                <xsl:sequence select="wea:row($values)"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="string-join(($headerRow, $dataRows),$NEWLINE)"/>
    </xsl:function>
    
    <xsl:function name="wea:row" as="xs:string">
        <xsl:param name="values" as="xs:string+"/>
   
        <xsl:iterate select="$values">
            <xsl:param name="acc" as="xs:string*"/>
            <xsl:on-completion>
                <xsl:sequence select="string-join($acc, ',')"/>
            </xsl:on-completion>
            <xsl:variable name="quotedVal" 
                select="$DOUBLEQUOTE || replace(., $DOUBLEQUOTE, ($DOUBLEQUOTE || $DOUBLEQUOTE)) || $DOUBLEQUOTE"/>
            <xsl:next-iteration>
                <xsl:with-param name="acc" select="($acc, $quotedVal)"/>
            </xsl:next-iteration>
        </xsl:iterate>        
    </xsl:function>
    
    <xsl:function name="wea:valueFromMap" as="xs:string">
        <xsl:param name="value" as="item()?"/>
        <xsl:choose>
            <xsl:when test="empty($value)">
                <xsl:sequence select="''"/>
            </xsl:when>
            <xsl:when test="$value instance of map(*) and map:contains($value,'_')">
                <xsl:sequence select="xs:string($value('_'))"/>
            </xsl:when>
            <xsl:when test="$value instance of array(*)">
                <xsl:sequence select="string-join(array:flatten($value)[not(.='')],';')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="xs:string($value)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
</xsl:stylesheet>