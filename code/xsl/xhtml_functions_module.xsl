<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet contains the main functions for use across the XHTML5 stylesheet modules.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:variable name="svgs" select="doc('../../site/fonts/material-icons.svg')"/>
    <!--FUNCTIONS-->
    
    <xsl:function name="wea:getNoteId" new-each-time="no">
        <xsl:param name="note"/>
        <xsl:value-of select="concat('note_',count($note/preceding::note[@type='editorial'])+1)"/>
    </xsl:function>
    
    <xsl:function name="wea:resolveTarget" new-each-time="no">
        <xsl:param name="target"/>
        <xsl:choose>
            <xsl:when test="starts-with($target,'http')">
                <xsl:value-of select="$target"/>
            </xsl:when>
            <xsl:when test="contains($target,'.xml') and not(matches($target,'xml/(original|standalone)'))">
                <xsl:value-of select="replace($target,'\.xml','.html')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$target"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="wea:getTitle">
        <xsl:param name="docId"/>
        <xsl:sequence select="$standaloneXml[//TEI/@xml:id=$docId]//teiHeader/fileDesc/titleStmt/title[1]/node()"/>
    </xsl:function>
    
    <xsl:function name="wea:isObject" as="xs:boolean">
        <xsl:param name="doc"/>
        <xsl:sequence select="not(wea:bornDigital($doc))"/>
    </xsl:function>
    
    <xsl:function name="wea:isExhibit" as="xs:boolean">
        <xsl:param name="doc"/>
        <xsl:variable name="category" select="$standaloneXml//TEI[@xml:id='taxonomies']/descendant::taxonomy[@xml:id='exhibit']/category[@xml:id=$doc/@xml:id]"/>
        <xsl:sequence select="not(empty($category))"/>
    </xsl:function>
    

    <xsl:function name="wea:crumb">
        <xsl:param name="doc"/>
        <xsl:variable name="category" select="$doc//catRef[contains(@scheme,'#exhibit')]/@target"/>
        <xsl:variable name="thisCat" select="$standaloneXml//category[@xml:id=substring-after($category,'#')]"/>
        <div class="breadcrumb metadataLabel"><a href="{$thisCat/@xml:id}.html"><xsl:apply-templates select="$thisCat/catDesc/term/node()" mode="tei"/></a></div>
    </xsl:function>
    
    <xsl:function name="wea:getURL" as="xs:string">
        <xsl:param name="el"/>
        <xsl:variable name="root" select="$el/ancestor-or-self::TEI"/>
        <xsl:value-of select="concat($siteUrl, '/',$root/@xml:id,'.html')"/>
    </xsl:function>
    
    <xsl:function name="wea:getSvg">
        <xsl:param name="svgId"/>
        <xsl:variable name="id" select="normalize-space(if (starts-with($svgId,'ic_')) then $svgId else concat('ic_',$svgId))"/>
        <xsl:variable name="svg" select="$svgs//svg:symbol[@id=$id]"/>
        <xsl:choose>
            <xsl:when test="not(empty($svg))">
                <svg:svg>
                    <xsl:sequence select="$svg/@*[not(local-name()='id')] | $svg/*"/>
                </svg:svg>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">ERROR: Cannot find SVG: <xsl:value-of select="$svgId"/></xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
</xsl:stylesheet>