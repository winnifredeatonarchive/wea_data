<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: March 24, 2019.</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet contains the templates for creating various metadata formats for the HTML head element. Metadata will include dubline core and like open-graph protocol metadata.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:template name="createHeadMetadata">
        <head>

            <title><xsl:value-of select="teiHeader/fileDesc/titleStmt/title[1]"/></title>
            <xsl:call-template name="createOpenGraph"/>
            <link rel="stylesheet" type="text/css" href="css/wea.css"/>
            <link rel="stylesheet" type="text/css" href="css/media.css"/>
            <link rel="stylesheet" type="text/css" media="print" href="css/print.css"/>
            <link rel="icon" type="image/png" href="images/icon.png"/>
            <script src="js/wea.js"/>
            <xsl:if test="@xml:id='search'">
                <script src="js/porterStemmer.js"/>
                <script src="js/search.js"/>
            </xsl:if>

            <meta name="viewport" content="width=device-width, initial-scale=1"/>
        </head>
    </xsl:template>
    

    <xsl:template name="addNamespaces">
        <xsl:attribute name="prefix" select="'og: http://ogp.me/ns# wea: http://winnifredeatonarchive.com/taxonomies.html#'"/>   
    </xsl:template>
    
    <xsl:template name="createOpenGraph">
        <meta property="og:title" content="{//teiHeader/fileDesc/titleStmt/title[1]}" />
        <xsl:call-template name="getOGTypes"/>
        <meta property="og:url" content="http://winnifredeatonarchive.com/{@xml:id}.html" />
        <meta property="og:image" content="{if (//text/@facs) then concat('http://winnifredeatonarchive.github.io/wea/',replace(//text/@facs,'.pdf','.png')) else 
            'http://winnifredeatonarchive.github.io/wea/images/icon.png'}" />
    </xsl:template>
    
    <xsl:template name="getOGTypes">
        <xsl:for-each select="//catRef">
            <meta property="og:type" content="wea:{substring-after(@target,'#')}"/>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>