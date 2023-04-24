<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://winnifredeatonarchive.org/ns"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 23, 2023</xd:p>
            <xd:p><xd:b>Author:</xd:b> takeda</xd:p>
            <xd:p>A trivial utility stylesheet to create better formatted comments.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xml" suppress-indentation="text bibl p ref title q desc"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="/">
        <xsl:message select="'Processing ' || base-uri()"/>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="processing-instruction('xml-model')">
        <xsl:if test="not(preceding-sibling::processing-instruction())">
            <xsl:sequence select="codepoints-to-string(10)"/>
        </xsl:if>
        <xsl:sequence select="."/>
        <xsl:sequence select="codepoints-to-string(10)"/>
    </xsl:template>
    
    <xsl:template match="comment">
        <xsl:text disable-output-escaping="yes">&lt;!--</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text disable-output-escaping="yes">--&gt;</xsl:text>
    </xsl:template>

</xsl:stylesheet>