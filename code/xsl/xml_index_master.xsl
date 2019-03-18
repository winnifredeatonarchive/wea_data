<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet creates the index page(s) for the WEA project.</xd:p>
        </xd:desc>
    </xd:doc>
    
  <xsl:include href="globals.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="createIndexPage"/>
    </xsl:template>
    
   <xsl:template name="createIndexPage">
       <xsl:call-template name="generateTeiPage">
           <xsl:with-param name="thisId" select="'index'"/>
           <xsl:with-param name="outDoc" select="concat($outDir,'xml/original/index.xml')"/>
           <xsl:with-param name="title">Index</xsl:with-param>
           <xsl:with-param name="categories" select="'wdt:docBornDigital'"/>
           <xsl:with-param name="content">
               <body>
                   <head>Index</head>
                   <div>
                       <table>
                           <row role="label">
                               <cell>Title</cell>
                               <cell>ID</cell>
                           </row>
                           <row>
                               <cell><ref target="documentation.html">Documentation</ref></cell>
                               <cell>documentation</cell>
                           </row>
                           <xsl:for-each select="$originalXml">
                               <row>
                                   <cell><ref target="{//TEI/@xml:id}.html"><xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[1]"/></ref></cell>
                                   <cell><xsl:value-of select="//TEI/@xml:id"/></cell>
                               </row>
                           </xsl:for-each>
                       </table>
                   </div>
               </body>
           </xsl:with-param>
       </xsl:call-template>
   </xsl:template>
   
</xsl:stylesheet>