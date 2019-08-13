<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
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
    <xsl:include href="xhtml_modules_module.xsl"/>
    <xsl:include href="xhtml_index_module.xsl"/>
   
    
    
    <xsl:variable name="menu" select="$standaloneXml//TEI[@xml:id='menu']"/>
    <xsl:variable name="footer" select="$standaloneXml//TEI[@xml:id='footer']"/>

    
    <xsl:template match="/">
        <xsl:for-each select="wea:getWorkingDocs($standaloneXml)">
            <!--EXCLUDE INDEX FOR NOW, BUT NOT FOR LONG-->
            <xsl:if test="not(//TEI/@xml:id=('menu','footer'))">
                <xsl:result-document href="{concat($outDir,'/',//TEI/@xml:id)}.html" method="xhtml" encoding="UTF-8" indent="no" normalization-form="NFC" exclude-result-prefixes="#all" omit-xml-declaration="yes" html-version="5.0">
                    <xsl:apply-templates select="." mode="tei"/>
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    
    

    
</xsl:stylesheet>