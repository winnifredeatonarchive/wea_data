<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:functx="http://www.functx.com"
    version="3.0">
    
    <xsl:include href="globals.xsl"/>
    
    <xsl:template name="go">
        <xsl:result-document href="{$outDir}/sitemap.xml">
            <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"> 
                <xsl:for-each select="$xhtmlDocs">
                    <url>
                        <loc><xsl:value-of select="$siteUrl || tokenize(document-uri(),'/')[last()]"/></loc>
                        <lastmod><xsl:value-of select="$today"/></lastmod>
                    </url>
                </xsl:for-each>
            </urlset>
        </xsl:result-document>
    </xsl:template>

    
</xsl:stylesheet>