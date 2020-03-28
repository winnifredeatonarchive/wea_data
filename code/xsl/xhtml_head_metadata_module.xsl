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
            <xsl:call-template name="createStaticSearchMetadata"/>
            <link rel="stylesheet" type="text/css" href="css/wea.css"/>
            <link rel="stylesheet" type="text/css" href="css/media.css"/>
            <link rel="stylesheet" type="text/css" media="print" href="css/print.css"/>
            <xsl:if test="@xml:id='index'">
                <link rel="stylesheet" type="text/css" href="css/index.css"/>
            </xsl:if>
            <link rel="icon" type="image/png" href="images/icon.png"/>
            <script src="js/lazyload.min.js"/>
            <script src="js/wea.js"/>
            <xsl:if test="//graphic[contains(@url,'media/')]">
                <script src="js/facsimile_view.js"/>
            </xsl:if>
 
            <xsl:if test="@xml:id='search'">
                <script src="js/porterStemmer.js"/>
                <script src="js/search.js"/>
            </xsl:if>
            <xsl:if test="@xml:id='index'">
                <script src="js/index.js"/>
            </xsl:if>

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
        <xsl:for-each select="//sourceDesc/bibl/author/name">
            <meta property="dc.creator" content="{.}"/>
        </xsl:for-each>
        <xsl:for-each select="//sourceDesc/bibl/date">
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
        <meta property="dc.identifier" content="https://winnifredeatonarchive.com/{@xml:id}.html" />
    </xsl:template>
    
    <xsl:template name="createStaticSearchMetadata">
        <xsl:variable name="taxo" select="$standaloneXml//TEI[@xml:id='taxonomies']" as="element(TEI)"/>
        <xsl:for-each select="descendant::catRef">
            <xsl:variable name="schemeId" select="substring-after(@scheme,'#')" as="xs:string"/>
            <xsl:variable name="refId" select="substring-after(@target,'#')" as="xs:string"/>
            <xsl:variable name="thisTax" select="$taxo/descendant::taxonomy[@xml:id=$schemeId]" as="element(taxonomy)"/>
            <xsl:variable name="thisCat" select="$thisTax/descendant::category[@xml:id=$refId]" as="element(category)"/>
            <!--Exclude primary source from being its own category in the SS search-->
            <xsl:if test="not($refId = 'docPrimarySource')">
                <meta name="{$thisTax/bibl}" class="staticSearch.filter" content="{$thisCat/catDesc/term}"/>
                <meta name="{$thisTax/bibl}" class="staticSearch.desc" content="{$thisCat/catDesc/term}"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:if test="wea:isObject(.)">
            <xsl:for-each-group select="//text/descendant::name[@ref='#WE1'][not(ancestor::note[@type='editorial'])]" group-by="lower-case(normalize-space(string-join(descendant::text(),'')))">
                <meta name="Pseudonym" class="staticSearch.filter" content="{wea:namecase(current-grouping-key())}"/>
                <meta name="Pseudonym" class="staticSearch.desc" content="{wea:namecase(current-grouping-key())}"/>
            </xsl:for-each-group>
           <meta name="Contains Foreign phrases?" class="staticSearch.bool" content="{xs:boolean(exists(//text/descendant::foreign))}"/>
            <xsl:variable name="date" select="descendant::teiHeader/fileDesc/sourceDesc/bibl[1]/date" as="element(tei:date)?"/>
            <xsl:variable name="isRange" select="exists($date[@notAfter or @from])" as="xs:boolean"/>
            <xsl:variable name="dateString" select="if ($isRange) then concat($date/(@notBefore|@from)[1],'/', $date/(@notAfter|@to)[1]) else $date/@when" as="xs:string?"/>
            <xsl:if test="not(empty($date))">
                <meta name="Publication Date" class="staticSearch.date" content="{$dateString}"/>
            </xsl:if>

        </xsl:if>
       
    </xsl:template>

    <xsl:template name="addNamespaces">
        <xsl:attribute name="prefix" select="'og: http://ogp.me/ns# wea: http://winnifredeatonarchive.com/taxonomies.html# dcterms: http://purl.org/dc/terms/ dc: http://purl.org/dc/elements/1.1/'"/>   
    </xsl:template>
    
    <xsl:template name="createOpenGraph">
        <meta property="og:title" content="{//teiHeader/fileDesc/titleStmt/title[1]}" />
        <xsl:call-template name="getOGTypes"/>
        <meta property="og:url" content="http://winnifredeatonarchive.com/{@xml:id}.html" />
        <meta property="og:image" content="{if (//text/@facs) then concat('http://winnifredeatonarchive.github.io/wea/',replace(//text/@facs,'.pdf','.png')) else 
            'http://winnifredeatonarchive.github.io/wea/images/icon.png'}" />
    </xsl:template>
    
    <xsl:template name="getOGTypes">
        <xsl:for-each select="//catRef">
            <meta property="og:type" content="wea:{substring-after(@target,'#')}"/>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>