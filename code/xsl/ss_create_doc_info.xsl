<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
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
    
    <xsl:variable name="dummyDate" select="xs:date('2020-01-01')" as="xs:date"/>
    
    <xsl:variable name="dateMap" as="map(xs:string,xs:integer)">
        <xsl:map>
            <xsl:for-each select="$xhtmlDocs[descendant::meta[contains-token(@class,'staticSearch.date')]]">
                <xsl:sort select="map:get(wea:returnDate(//html/@id), 'sort')"/>
                <xsl:variable name="thisId" select="//html/@id" as="xs:string"/>
                <xsl:variable name="position" select="position()" as="xs:integer"/>
<!--                <xsl:message expand-text="yes">{$thisId}: {$position}: {map:get(wea:returnDate($thisId),'display')}</xsl:message>-->
                <xsl:map-entry key="$thisId" select="$position"/>
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
                                        <xsl:variable name="content" as="item()*">
                                            <xsl:choose>
                                                <xsl:when test="@data-link">
                                                    <a href="{@data-link}"><xsl:value-of select="@content"/></a>
                                                </xsl:when>
                                                <xsl:when test="contains-token(@class,'staticSearch.date')">
                                                    <xsl:value-of select="map:get(wea:returnDate($thisId),'display')"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="@content"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>
                                        <xsl:if test="not(string($content) = '')">
                                            <div data-filter="{@name}">
                                                <xsl:sequence select="$content"/>
                                            </div>
                                        </xsl:if>
            
                                    </xsl:for-each>
                                </div>
                            </div>
                        </xsl:for-each-group>
                    </div>
                </details>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:function name="wea:returnDate" new-each-time="no" as="map(xs:string, item())">
        <xsl:param name="docId" as="xs:string"/>
        <xsl:variable name="thisTeiDoc" select="$standaloneXml//tei:TEI[@xml:id=$docId]"/>
        <xsl:variable name="thisPubDate" select="$thisTeiDoc//tei:sourceDesc/tei:bibl[@copyOf]/tei:date[1]" as="element(tei:date)?"/>
        
        <xsl:variable name="dateToUse" as="element(tei:date)">
            <xsl:choose>
                <xsl:when test="$thisPubDate">
                    <xsl:sequence select="wea:formatDate($thisPubDate)"/>
                </xsl:when>
                <xsl:otherwise>
                    <tei:date when="2020-01-01"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:map>
          <xsl:map-entry key="'display'" select="string($dateToUse)"/>
          <xsl:map-entry key="'sort'" select="wea:getDateSortKey($dateToUse)"/>
        </xsl:map>
        
    </xsl:function>

</xsl:stylesheet>