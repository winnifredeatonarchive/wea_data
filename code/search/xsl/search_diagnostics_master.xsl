<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:hcmc="http://hcmc.uvic.ca/ns" version="3.0"
    xmlns:wea="http://winnifredeatonarchive.github.io"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:jt="http://github.com/joeytakeda">
    
    <xsl:include href="search_globals_module.xsl"/>
    
    <!--This stylesheet creates a set of diagnostics to run in concert with the search engine-->
    
    <!--It's to be run *AFTER* the documents are tokenized-->
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Search Diagnostics</title>
            </head>
            <body>
                <h1>Diagnostics</h1>
            </body>
        </html>
        
    </xsl:template>
    
    
    <!--Create a list of foreign words-->
    <xsl:template name="createForeignWordList">
        <xsl:for-each-group select=""
    </xsl:template>
    
    <!--Create a list of words that are not in the stoplist that maybe ought to be-->
    
</xsl:stylesheet>