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
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet is the master stylesheet for the WEA project's conversion
                from TEI P5 to XHTML5. It may load in other modules, if the complexity of the project
                necessitiates it.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:include href="globals.xsl"/>
    <xsl:include href="xml_original_category_module.xsl"/>
    <xsl:include href="xml_original_people_module.xsl"/>
    <xsl:include href="xml_original_organizations_module.xsl"/>
    <xsl:include href="xml_original_templates_module.xsl"/>
    <xsl:include href="xml_original_work_module.xsl"/>
    
    <xsl:template match="/">
        <xsl:for-each select="wea:getWorkingDocs($sourceXml)">
            <xsl:variable name="out" select="concat($outDir,'xml/original/',//TEI/@xml:id,'.xml')"/>
            <xsl:message>Processing <xsl:value-of select="document-uri(/)"/> to <xsl:value-of select="$out"/></xsl:message>
            <xsl:result-document href="{$out}" indent="no" method="xml">
                <xsl:apply-templates select="." mode="original"/>
            </xsl:result-document>
        </xsl:for-each>
            <xsl:call-template name="createCategoryPages"/>
            <xsl:call-template name="createWorkPages"/>
            <xsl:call-template name="createPeoplePages"/>
            <xsl:call-template name="createOrgPages"/>
        
    </xsl:template>
    

</xsl:stylesheet>