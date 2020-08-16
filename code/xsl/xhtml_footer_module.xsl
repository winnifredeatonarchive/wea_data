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
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet is the master stylesheet for the WEA project's conversion
                from TEI P5 to XHTML5. It may load in other modules, if the complexity of the project
                necessitiates it.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template name="createFooter">
        <footer>
            <xsl:apply-templates select="$standaloneXml//TEI[@xml:id='footer']//div[@xml:id='footer_main']" mode="tei"/>
        </footer>
    </xsl:template>
    
    <!--A few templates to add here-->
    <xsl:template match="seg[@type='currentDate']" mode="tei">
        <span><xsl:value-of select="format-date(current-date(),'[D01] [MNn] [Y0001]')"/></span>
    </xsl:template>
    
    <xsl:template match="seg[@type='revision']" mode="tei">
        <!--$sha is declared in the globals-->
        <a href="https://github.com/winnifredeatonarchive/wea_data/tree/{$sha}"><xsl:value-of select="substring($sha,1,7)"/></a>
    </xsl:template>
    
    <xsl:template match="seg[@type='version']" mode="tei">
        <xsl:value-of select="$version"/>
    </xsl:template>
    
</xsl:stylesheet>