<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 15, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> joeytakeda</xd:p>
            <xd:p>This template creates a small document information XHTML details element for each document, for use within the static search and other things.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:include href="globals.xsl"/>
    
    
    <xsl:template match="/">
        <xsl:message>Creating document ajax frags...</xsl:message>
        <xsl:for-each select="$xhtmlDocs">
            <xsl:result-document href="{$outDir || '/ajax/' || //html/@id || '.html'}">
                <details open="open">
                    <summary>More Info</summary>
                    <div>
                        <xsl:for-each-group select="//meta[matches(@class,'staticSearch\.(desc|date|bool)')]" group-by="@name">
                            <div>
                                <div class="metadataLabel"><xsl:value-of select="current-grouping-key()"/></div>
                                <div>
                                    <xsl:for-each select="current-group()">
                                        <div>
                                            <xsl:choose>
                                                <xsl:when test="@data-link">
                                                    <a href="{@data-link}"><xsl:value-of select="@content"/></a>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="@content"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </xsl:for-each-group>
                    </div>
                </details>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    
</xsl:stylesheet>