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
    
    
    <xsl:variable name="weChronoBiblId" select="'we_bibliography_chrono'"/>
    <xsl:variable name="weWorkBiblId" select="'we_bibliography_work'"/>
    
    <xsl:template name="createWEBibl">
        <xsl:call-template name="createChronoBibl"/>
        <xsl:call-template name="createWorkBibl"/>
    </xsl:template>
    
    
    <xsl:template name="createChronoBibl">
        <div xml:id="{$weChronoBiblId}" type="biblio_list">
            <head>Chronological Bibliography</head>
            <xsl:for-each-group select="$sourceXml//sourceDesc/msDesc/msContents/msItem/bibl"
                group-by="wea:returnDate(.)">
                <xsl:sort select="current-grouping-key() castable as xs:integer" order="descending"/>
                <xsl:sort select="current-grouping-key()" order="ascending"/>
                <div xml:id="{$weChronoBiblId}_{current-grouping-key()}">
                    <head><xsl:value-of select="current-grouping-key()"/></head>
                    <listBibl>
                        <xsl:apply-templates select="current-group()" mode="removeId">
                            <xsl:sort select="date"/>
                        </xsl:apply-templates>
                    </listBibl>
        
                </div>
            </xsl:for-each-group>
        </div>
    </xsl:template>
    
    <xsl:template name="createWorkBibl">
        <div xml:id="{$weWorkBiblId}" type="biblio_list">
            <head>Bibliography by Work<!--<note type="editorial">By work, we refer here to groupings of texts based off of their relationship to one another. Reprints, serialized versions of novels, and other texts that are related in some capacity are grouped here as a single <q>work</q>.</note>--></head>
            <xsl:for-each select="$sourceXml//linkGrp[@type='work']">
                <xsl:sort select="wea:simpleTitleSortKey(string(desc))"/>
                <div xml:id="{$weWorkBiblId}_{@xml:id}">
                    <head><xsl:value-of select="desc"/></head>
                    <xsl:for-each select="ptr">
                        <xsl:variable name="docId" select="substring-after(@target,'doc:')"/>
                        <xsl:variable name="doc" select="$sourceXml//TEI[@xml:id = $docId]"/>
                        <xsl:variable name="bibl" select="$doc//sourceDesc/msDesc/msContents/msItem/bibl"/>
                        <xsl:apply-templates select="$bibl" mode="removeId"/>
                    </xsl:for-each>

                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    
    
    
    
    <xsl:template name="createResourcesBibl">
        <div type="biblio_list">
             <xsl:apply-templates
                 select="$sourceXml//TEI[@xml:id='bibliography']/descendant::div[@xml:id='bibliography_resources']/listBibl"
                 mode="removeId"/>
         </div>
    </xsl:template>
    
    
    
    
    <xsl:template match="div[@xml:id='bibliography_resources']/listBibl" mode="removeId">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="bibl" mode="#current">
                <xsl:sort>
                    <xsl:value-of>
                        <xsl:apply-templates mode="sort"/>
                    </xsl:value-of>
                </xsl:sort>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    
    <!--Special set of templates to create a sort key-->
    <xsl:template match="*" priority="1" mode="sort">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="title/text()" mode="sort">
        <xsl:value-of select="wea:simpleTitleSortKey(.)"/>
    </xsl:template>
    
    <xsl:function name="wea:simpleTitleSortKey">
        <xsl:param name="str"/>
        <xsl:value-of select="normalize-space($str) => replace('^(The|Le|La|An?)\s','') => replace('‘|’','')"/>
    </xsl:function>
    
    <xsl:template match="bibl[ancestor::msDesc]/title[1]" mode="removeId">
        <ref target="doc:{ancestor::TEI/@xml:id}">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()" mode="#current"/>
            </xsl:copy>
        </ref>
    </xsl:template>
    
    <xsl:template match="bibl/@xml:id" mode="removeId"/>
    
    
    <xsl:template match="@*|node()" priority="-1" mode="removeId">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
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