<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
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
    
    <xsl:template name="go">
        <xsl:result-document href="{$outDir}/json/texts.json" method="json" indent="yes">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:map>
                <xsl:apply-templates select="$standaloneXml[//sourceDesc/msDesc]"/>
            </xsl:map>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="TEI">
        <xsl:map-entry key="@xml:id">
            <xsl:map>
                <xsl:apply-templates select="teiHeader/fileDesc/sourceDesc/msDesc"/>
                <xsl:apply-templates select="teiHeader/profileDesc/textClass"/>
                <xsl:apply-templates select="text[not(@type='standoff')]"/>
            </xsl:map>
        </xsl:map-entry>        
    </xsl:template>
    
    <!--Process the textClass to create genres-->
    <xsl:template match="textClass">
        <xsl:for-each-group select="catRef" group-by="@scheme">
            <xsl:map-entry key="substring-after(current-grouping-key(),'#')" select="array{current-group() ! substring-after(@target,'#')}"/>
        </xsl:for-each-group>
    </xsl:template>
    
    <!--Quick processing for the bibls-->
    <xsl:template match="bibl">
        <xsl:for-each-group select="*" group-by="local-name()">
            <xsl:variable name="content" as="map(*)*">
                <xsl:apply-templates select="current-group()"/>
            </xsl:variable>
            <xsl:map-entry key="current-grouping-key()" select="array{$content}"/>
        </xsl:for-each-group>
    </xsl:template>
    
    <!--Basic info about each bibl-->
    <xsl:template match="bibl/*" priority="1">
        <xsl:map>
            <xsl:for-each select="@*">
                <xsl:map-entry key="local-name()" select="string(.)"/>
            </xsl:for-each>
            <xsl:if test="not(@ref) and child::*[@ref]">
                <xsl:map-entry key="'ref'" select="string(child::*[@ref][1]/@ref)"/>
            </xsl:if>
            <xsl:map-entry key="'_'" select="string-join(descendant::text()) => normalize-space()"/>
        </xsl:map>    
    </xsl:template>
    
    <!--Basic stats about the text-->
    <xsl:template match="TEI/text">
        <xsl:variable name="pseudonyms" as="xs:string*">
            <xsl:for-each-group select="descendant::name[@ref='#WE1'][not(ancestor::note[@type='editorial'])]" group-by="wea:makePseudo(.)">
                <xsl:sequence select="current-grouping-key()"/>
            </xsl:for-each-group>
        </xsl:variable>
        <xsl:map-entry key="'pseudonyms'" select="array{$pseudonyms}"/>
        <xsl:map-entry key="'wc'" select="wea:getWordCount(.)"/>    
    </xsl:template>
    
    
</xsl:stylesheet>