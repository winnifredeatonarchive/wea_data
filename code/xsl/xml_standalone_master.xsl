<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0"

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
    <xsl:include href="xml_standalone_templates_module.xsl"/>
    

    
    <xsl:template match="/">
        <xsl:for-each select="wea:getWorkingDocs($originalXml)//TEI">
            <xsl:variable name="outDir"
                select="concat($outDir,'xml/standalone/',//TEI/@xml:id,'.xml')"/>
            <xsl:message>Creating <xsl:value-of select="$outDir"/></xsl:message>
            <xsl:result-document href="{$outDir}"  indent="no" method="xml">
                <xsl:call-template name="createStandalone"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>