<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: March 7, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet module creates the category pages for the WEA project.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:template name="createPeoplePages">
        <xsl:for-each select="$sourceXml[//TEI/@xml:id='people']//person[@xml:id]">
            <xsl:call-template name="generateTeiPage">
                <xsl:with-param name="outDoc" select="concat($outDir,'xml/original/person_',@xml:id,'.xml')"/>
                <xsl:with-param name="thisId" select="concat('person_',@xml:id)"/>
                <xsl:with-param name="categories" select="'wdt:docBornDigital'"/>
                <xsl:with-param name="title"><xsl:value-of select="persName/reg"/></xsl:with-param>
                <xsl:with-param name="content">
                    
                    <xsl:apply-templates select="." mode="people"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
  
  
  
    <xsl:template match="person" mode="people">
        <body>
            <head><xsl:value-of select="persName/reg"/></head>
            <div>
                <head>Biography</head>
                <xsl:apply-templates select="note" mode="#current"/>
                <!--GENERATED STUFF HERE, I SUPPOSE-->
            </div>
        </body>
     
    </xsl:template>
    
    <!--Delete short bio-->
    <xsl:template match="person/note[@type='bio'][@subtype='short']" mode="people"/>
    
    <xsl:template match="person/note[@type='bio'][@subtype='long']" mode="people">
            <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
</xsl:stylesheet>