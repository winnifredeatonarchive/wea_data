<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: March 24, 2019.</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet contains the templates for creating various metadata formats for the HTML head element. Metadata will include dubline core and like open-graph protocol metadata.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:template name="createHeadMetadata">
        <head>

            <title><xsl:value-of select="teiHeader/fileDesc/titleStmt/title[1]"/></title>
            <xsl:call-template name="createOpenGraph"/>
            <xsl:call-template name="createDCMetadata"/>
            <xsl:choose>
                <xsl:when test="@xml:id = $workIds">
                    <meta name="Ignore" class="staticSearch_desc" content="true"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="createStaticSearchMetadata"/>
                </xsl:otherwise>
            </xsl:choose>
            <link rel="stylesheet" type="text/css" href="css/wea.css?v={normalize-space($version)}"/>
            <link rel="stylesheet" type="text/css" href="css/media.css?v={normalize-space($version)}"/>
            <link rel="stylesheet" type="text/css" media="print" href="css/print.css?v={normalize-space($version)}"/>
            <xsl:if test="@xml:id='index'">
                <!--Special meta to make the twitter widget work-->
                <meta name="twitter:widgets:csp" content="on"/>
                <link rel="stylesheet" type="text/css" href="css/index.css?v={normalize-space($version)}"/>
                <link rel="preload" as="image" href="images/WEA-hero-img.jpg"/>
            </xsl:if>
            <link rel="icon" type="image/png" href="images/icon.png"/>

            <meta name="viewport" content="width=device-width, initial-scale=1"/>
   
            <xsl:if test="@xml:id='index'">
                <!--We add a special style for the index, which is generated from the count of the XSLT:
                    template located in the index module.
                -->
                <xsl:call-template name="createIndexStyles"/>
            </xsl:if>
        </head>
    </xsl:template>
    
    <xsl:template name="createDCMetadata">
        <meta property="dc.title" content="{teiHeader/fileDesc/titleStmt/title[1]}"/>
        <xsl:for-each select="//sourceDesc/msDesc/msContents/msItem/bibl/author/name">
            <meta property="dc.creator" content="{.}"/>
        </xsl:for-each>
        <xsl:for-each select="//sourceDesc/msDesc/msContents/msItem/bibl/date">
            <xsl:for-each select="@when | @notBefore |@notAfter |@to | @from">
                <meta property="dc.date" content="{.}"/>
            </xsl:for-each>
        </xsl:for-each>
 
        <meta property="dc.contributor" content="Mary Chapman"/>
        <meta property="dc.contributor" content="Jean Lee Cole"/>
        <meta property="dc.date" content="{current-date()}" />
        <meta property="dc.publisher" content="The Winnifred Eaton Archive"/>
        <meta property="dc.source" content="The Winnifred Eaton Archive"/>
        <meta property="dc.type" content="Text"/>
        <meta property="dc.format" content="text/html"/>
        <meta property="dc.identifier" content="{$siteUrl}/{@xml:id}.html" />
    </xsl:template>
    
    <xsl:template name="createStaticSearchMetadata">
        <xsl:variable name="self" select="." as="element(TEI)"/>
        <xsl:variable name="taxo" select="$standaloneXml//TEI[@xml:id='taxonomies']" as="element(TEI)"/>

        <xsl:for-each select="descendant::catRef">
            <xsl:variable name="schemeId" select="substring-after(@scheme,'#')" as="xs:string"/>
            <xsl:variable name="refId" select="substring-after(@target,'#')" as="xs:string"/>
            <xsl:variable name="thisTax" select="$taxo/descendant::taxonomy[@xml:id=$schemeId]" as="element(taxonomy)"/>
            <xsl:variable name="thisCat" select="$thisTax/descendant::category[@xml:id=$refId]" as="element(category)"/>
            <!--Exclude primary source from being its own category in the SS search-->
            <xsl:if test="not($refId = 'docPrimarySource')">
                <meta name="{$thisTax/bibl}" class="staticSearch_desc" data-link="{$refId}.html" content="{$thisCat/catDesc/term}">
                    <xsl:if test="$thisCat/@n">
                        <xsl:attribute name="data-ssfiltersortkey" select="$thisCat/@n"/>
                    </xsl:if>
                </meta>
            </xsl:if>
        </xsl:for-each>
        
        <xsl:if test="wea:isObject(.)">
             
            
            <!--Start grouping by names-->
            <xsl:for-each select="distinct-values(//name/@key)">
                <meta name="Pseudonym" class="staticSearch_desc" content="{.}"/>
            </xsl:for-each>
            
            <xsl:for-each-group select="//msItem/bibl/publisher[@ref]" group-by="substring-after(@ref,'#')">
                <xsl:variable name="org"
                    select="//org[@xml:id = current-grouping-key()]"
                    as="element(org)"/>
                <xsl:variable name="orgName" select="normalize-space($org/orgName[1])" as="xs:string"/>

                <meta name="Publisher" class="staticSearch_desc" data-link="{current-grouping-key()}.html" content="{$orgName}"/>
            </xsl:for-each-group>
            
            <meta name="docImage" class="staticSearch_docImage">
                <xsl:attribute name="content">
                    <xsl:choose>
                        <xsl:when test="//text/@facs">
                            <xsl:value-of select="replace(//text/@facs,'\.pdf$','_tiny.jpg')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'images/cooking.jpg'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </meta>
            
           
  
            <!--Removing boolean filters-->
<!--            <meta name="Has facsimile?" class="staticSearch_bool" content="{xs:boolean(exists(//text/@facs))}"/>
            <meta name="Has transcription?" class="staticSearch_bool" content="{not(xs:boolean(exists(//gap[@reason='noTranscriptionAvailable'])))}"/>
           <meta name="Contains Foreign phrases?" class="staticSearch_bool" content="{xs:boolean(exists(//text/descendant::foreign))}"/>-->
            
            
            <xsl:variable name="date" select="descendant::teiHeader/fileDesc/sourceDesc/msDesc/msContents/msItem/bibl[1]/date" as="element(tei:date)?"/>
            <xsl:variable name="isRange" select="exists($date[@notAfter or @from])" as="xs:boolean"/>
            <xsl:variable name="dateString" select="if ($isRange) then concat($date/(@notBefore|@from)[1],'/', $date/(@notAfter|@to)[1]) else $date/@when" as="xs:string?"/>
            <xsl:if test="not(empty($date))">
                <meta name="Publication Date" class="staticSearch_date" content="{$dateString}"/>
            </xsl:if>

        </xsl:if>
       
    </xsl:template>

    <xsl:template name="addNamespaces">
        <xsl:attribute name="prefix" select="concat('og: http://ogp.me/ns# wea: ', $siteUrl, '/taxonomies.html# dcterms: http://purl.org/dc/terms/ dc: http://purl.org/dc/elements/1.1/')"/>   
    </xsl:template>
    
    <xsl:template name="createOpenGraph">
        <meta property="og:title" content="{//teiHeader/fileDesc/titleStmt/title[1]}" />
        <xsl:call-template name="getOGTypes"/>
        <meta property="og:url" content="{$siteUrl}/{@xml:id}.html" />
        <meta property="og:image"
            content="{if (//text/@facs) 
            then concat($siteUrl,'/', replace(//text/@facs,'.pdf','_tiny.jpg')) 
            else concat($siteUrl, '/images/WEA-hero-img.jpg')}" />
    </xsl:template>
    
    <xsl:template name="getOGTypes">
        <xsl:for-each select="//catRef">
            <meta property="og:type" content="wea:{substring-after(@target,'#')}"/>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>