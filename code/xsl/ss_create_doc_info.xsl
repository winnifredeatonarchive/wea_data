<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
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
    
    
    <xsl:variable name="dateMap" as="map(xs:string,xs:integer)">
        <xsl:map>
            <xsl:for-each select="$xhtmlDocs">
                <xsl:sort select="wea:returnDate(.)"/>
                <xsl:map-entry key="//html/@id/string(.)" select="position()"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <xsl:variable name="titleMap" as="map(xs:string,xs:integer)">
        <xsl:map>
            <xsl:for-each select="$xhtmlDocs">
                <xsl:sort select="wea:makeTitleSortKey(//head/title[1])"/>
                <xsl:map-entry key="//html/@id/string(.)" select="position()"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    
    <xsl:template match="/">
        <xsl:message>Creating document ajax frags...</xsl:message>
        <xsl:for-each select="$xhtmlDocs">
            <xsl:variable name="thisId" select="//html/@id"/>
            <xsl:result-document href="{$outDir || '/ajax/' || $thisId || '.html'}">
                <details open="open">
                    <xsl:attribute name="data-dateOrder" select="$dateMap($thisId)"/>
                    <xsl:attribute name="data-titleOrder" select="$titleMap($thisId)"/>
                    <summary>More Info</summary>
                    <div>
                        <xsl:for-each-group select="//meta[matches(@class,'staticSearch\.(desc|date|bool)')]" group-by="@name">
                            <div>
                                <div class="metadataLabel"><xsl:value-of select="current-grouping-key()"/></div>
                                <div>
                                    <xsl:for-each select="current-group()">
                                        <div data-filter="{@name}">
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
    
    <xsl:function name="wea:returnDate">
        <xsl:param name="doc"/>
        <xsl:variable name="dateMeta" select="$doc//meta[matches(@class,'staticSearch.date')][@name='Publication Date'][1]" as="element(meta)?"/>
        <xsl:choose>
            <xsl:when test="$dateMeta">
                <xsl:choose>
                    <xsl:when test="$dateMeta/@content castable as xs:date">
                        <xsl:sequence select="xs:date($dateMeta/@content)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="thisDocId" select="$doc//html/@id"/>
                        <xsl:variable name="thisTeiDoc" select="$standaloneXml//tei:TEI[@xml:id=$thisDocId]"/>
                        <xsl:variable name="thisPubDate" select="$thisTeiDoc//tei:sourceDesc/tei:bibl/tei:date/(@notBefore|@from|@when)[1]"/>
                        <xsl:variable name="expandedDate" select="if ($thisPubDate) then wea:expandDate($thisPubDate) else xs:date('2020-01-01')"/>
                        <xsl:sequence select="$expandedDate"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>