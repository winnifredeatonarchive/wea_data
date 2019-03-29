<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    
    
    <xsl:variable name="imageS"
    
    <xsl:template match="/">
        <xsl:message>
            <xsl:value-of select="$mediaList"/>
            <xsl:value-of select="$facsList"/>
        </xsl:message>
    </xsl:template>
    
    <!--This stylesheet creates a script for use by imagemagick to create multiple outputs from our files-->
</xsl:stylesheet>