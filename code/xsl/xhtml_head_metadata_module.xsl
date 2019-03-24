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
            <title><xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[1]"/></title>
            <link rel="stylesheet" type="text/css" href="css/wea.css"/>
            <link rel="icon" type="image/png" href="graphics/icon.png"/>
            <script src="js/wea.js"/>
            <script src="js/porterStemmer.js"/>
            <script src="js/search.js"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
        </head>
    </xsl:template>
    
</xsl:stylesheet>