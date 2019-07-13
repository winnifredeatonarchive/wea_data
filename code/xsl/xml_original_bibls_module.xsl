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
            <xd:p>Created on: July 13, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet creates the various bibliographies for the cite. It does so
            by harvesting materials from the global bibliography and injecting them into the
            designated pages.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:variable name="biblDoc" select="$sourceXml/TEI[@xml:id='bibliography']" as="element(TEI)"/>
    
    <xsl:variable name="weChronoBiblId" select="'we_bibliography_chrono'"/>
    <xsl:variable name="weWorkBiblId" select="'we_bibliography_work'"/>
    
    <xsl:template name="createWEBibl">
        <xsl:call-template name="createChronoBibl"/>
        <xsl:call-template name="createWorkBibl"/>
    </xsl:template>
    
    
    <xsl:template name="createChronoBibl">
        <div xml:id="{$weChronoBiblId}" type="biblio_list">
            <head>Chronological Bibliography</head>
            <xsl:for-each-group select="$biblDoc//div[@xml:id='bibliography_we']/descendant::bibl" group-by="wea:returnDate(.)">
                <xsl:sort select="current-grouping-key() castable as xs:integer" order="descending"/>
                <xsl:sort select="current-grouping-key()" order="ascending"/>
                <div xml:id="{$weChronoBiblId}_{current-grouping-key()}">

                    <listBibl>
                        <head><xsl:value-of select="current-grouping-key()"/></head>
                        <xsl:apply-templates select="current-group()" mode="original">
                            <xsl:sort select="date"/>
                        </xsl:apply-templates>
                    </listBibl>
        
                </div>
            </xsl:for-each-group>
        </div>
    </xsl:template>
    
    <xsl:template name="createWorkBibl">
        <div xml:id="{$weWorkBiblId}" type="biblio_list">
            <head>Bibliography by Work<note type="editorial">By work, we refer here to groupings of texts based off of their relationship to one another. Reprints, serialized versions of novels, and other texts that are related in some capacity are grouped here as a single <q>work</q>.</note></head>
            
            <xsl:for-each select="$biblDoc//div[@xml:id='bibliography_we']/listBibl/listBibl">
                <div xml:id="{$weWorkBiblId}_{@xml:id}">
                    <xsl:apply-templates select="." mode="original"/>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    
    
    
    
    <xsl:template name="createResourcesBibl">
        <div type="biblio_list">
             <xsl:apply-templates select="$biblDoc//div[@xml:id='bibliography_resources']/listBibl" mode="original"/>
         </div>
    </xsl:template>
    
    <xsl:function name="wea:returnDate">
        <xsl:param name="bibl"/>
        <xsl:variable name="date" select="$bibl/date/(@when|@notBefore)[1]"/>
        <xsl:choose>
            <xsl:when test="not(empty($date))">
                <xsl:value-of select="tokenize($date,'-')[1]"/>
            </xsl:when>
            <xsl:otherwise>Undated</xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    

    
</xsl:stylesheet>