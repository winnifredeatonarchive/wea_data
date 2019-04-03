<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet is the master stylesheet for the WEA project's conversion
            from TEI P5 to XHTML5. It loads in a number of additional modules; the most significant is the "templates" module, which contains all of the basic transformation templates for the site.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:include href="globals.xsl"/>
    <xsl:include href="xhtml_templates_module.xsl"/>
    <xsl:include href="xhtml_appendix_module.xsl"/>
    <xsl:include href="xhtml_functions_module.xsl"/>
    <xsl:include href="xhtml_eg_module.xsl"/>
    <xsl:include href="xhtml_metadata_module.xsl"/>
    <xsl:include href="xhtml_nav_module.xsl"/>
    <xsl:include href="xhtml_footer_module.xsl"/>
    <xsl:include href="xhtml_head_metadata_module.xsl"/>


    
    <xsl:template match="/">
        <xsl:for-each select="$standaloneXml//TEI">
            <xsl:apply-templates select="." mode="tei"/>
        </xsl:for-each>
    </xsl:template>
    
    
    

    
</xsl:stylesheet>