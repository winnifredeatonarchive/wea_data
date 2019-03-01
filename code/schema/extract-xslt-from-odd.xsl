<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:axsl="nonce"
    version="3.0">
    
    <xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
    <!--This stylesheet creates the XSLT quick-fixes from the ODD-->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <axsl:stylesheet>
            <xsl:attribute name="version" select="'2.0'"/>
            <xsl:for-each select="//xsl:template[@name] | //xsl:variable[not(ancestor::xsl:template)]">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </axsl:stylesheet>
    </xsl:template>
    
</xsl:stylesheet>