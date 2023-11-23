<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
   <!-- A small utility transform to fix the Wooing of Wisteria documents-->    
    <xsl:mode on-no-match="shallow-copy"/>
   
    <xsl:variable name="replaceMap" as="map(xs:integer, xs:integer)">
        <xsl:map>
            <xsl:for-each select="1 to 12">
                <xsl:map-entry key="." select=". + 2"/>
            </xsl:for-each>
            <xsl:map-entry key="13" select="1"/>
            <xsl:map-entry key="14" select="2"/>
        </xsl:map>
    </xsl:variable>
    
    
    <xsl:variable name="docs" select="collection('../texts?match=Wooing.+\.xml')"/>
    <xsl:template name="go">
        <xsl:for-each select="$docs">
            <xsl:variable name="id" select="//TEI/@xml:id"/>
            <xsl:variable name="num" select="substring-after($id, 'WooingOfWistaria') => xs:integer()" as="xs:integer"/>
            <xsl:variable name="replacement" select="$replaceMap($num)"/>
            <xsl:result-document href="tmp/WooingOfWistaria{$replacement}.xml" method="xml" indent="yes" suppress-indentation="text p body div q">
                <xsl:apply-templates select=".">
                    <xsl:with-param name="num" select="$num" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:result-document>
        </xsl:for-each>
        <xsl:result-document href="renameWooingFacs.sh" method="text">
            #!/bin/bash
            <xsl:for-each select="$docs[//text/@facs]">
                <xsl:variable name="facs" select="//text/@facs"/>
                svn mv ../facsimiles/<xsl:value-of select="substring-after($facs,'facs:') || '.pdf'"/> ../facsimiles/tmp_WooingOfWistaria<xsl:value-of select="$replaceMap(replace(//TEI/@xml:id,'WooingOfWistaria','') => xs:integer())"/>.pdf;
                
            </xsl:for-each>
            
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="TEI/@xml:id">
        <xsl:param name="num" tunnel="yes"/>
        <xsl:attribute name="xml:id" select="'WooingofWistaria' || $replaceMap($num)"/>
    </xsl:template>
    
    <xsl:template match="revisionDesc">
        <xsl:param name="num" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <change who="pers:JT1" when="2020-06-14" status="{@status}">Changed id from <xsl:value-of select="ancestor::TEI/@xml:id"/> to <xsl:value-of select="'WooingOfWistaria' || $replaceMap($num)"/>.</change>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="teiHeader/fileDesc/titleStmt/title">
        <xsl:param name="num" tunnel="yes"/>

        <xsl:copy>
            
            <xsl:choose>
                <xsl:when test="$num = 12">
                    <xsl:text>The Wooing of Wistaria</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>The Wooing of Wistaria (Part </xsl:text><xsl:value-of select="$replaceMap($num)"/><xsl:text>)</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text/@next | text/@prev">
        
        <xsl:attribute name="{local-name()}">
           <xsl:variable name="ptr" select="substring-after(.,'doc:')"/>
            <xsl:variable name="num" select="substring-after($ptr,'WooingOfWistaria') => xs:integer()"/>
            <xsl:variable name="replacement" select="$replaceMap($num)"/>
            <xsl:value-of select="'doc:WooingOfWistaria' || $replacement"/>
        </xsl:attribute>
    </xsl:template>
  
  
  
    
</xsl:stylesheet>
