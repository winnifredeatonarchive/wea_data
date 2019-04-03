<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
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
    <xsl:include href="globals.xsl"/>
    <xsl:include href="xml_original_templates_module.xsl"/>
    <xsl:include href="xml_standalone_templates_module.xsl"/>
    <xsl:include href="xhtml_modules_module.xsl"/>
    
    <xsl:template match="/">
        <xsl:for-each select="$documentationDocs">
            <xsl:variable name="thisId" select="//TEI/@xml:id"/>
            <xsl:variable name="original">
                <xsl:apply-templates select="." mode="original"/>
            </xsl:variable>
            <xsl:variable name="standalone">
                <xsl:for-each select="$original">
                    <xsl:call-template name="createStandalone"/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="xhtml">
                <xsl:apply-templates select="$standalone" mode="tei"/>
            </xsl:variable>
            <xsl:message>Creating results in <xsl:value-of select="resolve-uri($documentationOutDir)"/>for <xsl:value-of select="$thisId"/></xsl:message>
            <xsl:result-document href="{$documentationOutDir}/xml/original/{//TEI/@xml:id}.xml">
                <xsl:sequence select="$original"/>
            </xsl:result-document>
            <xsl:result-document href="{$documentationOutDir}/xml/standalone/{//TEI/@xml:id}.xml">
                <xsl:sequence select="$standalone"/>
            </xsl:result-document>
            <xsl:result-document href="{$documentationOutDir}/{//TEI/@xml:id}.html">
                <xsl:sequence select="$xhtml"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    
</xsl:stylesheet>