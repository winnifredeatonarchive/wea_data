<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="#all"
    xmlns:wea="https://winnifredeatonarchive.org/ns"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 10, 2023</xd:p>
            <xd:p><xd:b>Author:</xd:b> takeda</xd:p>
            <xd:p>Stylesheet to migrate document to use msDesc rather the source bibl.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:variable name="today" select="current-date() => format-date('[Y0001]-[M01]-[D01]')" as="xs:string"/>
    <xsl:variable name="dest" select="'out/'"/>

    <xsl:variable name="texts" select="collection('../../data/texts?select=*.xml')" as="document-node()+"/>
    <xsl:variable name="biblio" select="document('../../data/bibliography.xml')" as="document-node()"/>
    
    
    
    <!--
        map{
            'bibl1': <bibl xml:id="bibl1">...</bibl>
        
        } -->
    <xsl:variable name="biblMap" as="map(xs:string, element(bibl))">
        <xsl:map>
            <xsl:for-each select="$biblio//div[@xml:id='bibliography_we']/listBibl/bibl">
                <xsl:map-entry key="string(@xml:id)" select="."/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <!--map{
            'ChineseJapaneseCookbook': 'bibl1'
        } -->
    <xsl:variable name="textToBiblMap" as="map(xs:string, xs:string)">
        <xsl:map>
            <xsl:for-each select="$texts">
                <xsl:map-entry key="string(@xml:id)" 
                    select="replace(//sourceDesc/bibl[@copyOf]/@copyOf,':','')"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    
    
    <!--Inverted map from above:
        map{
            'bibl1': 'ChineseJapaneseCookbook'
        } -->
        
    <xsl:variable name="biblToTextMap"
        as="map(xs:string, xs:string)"
        select="map:merge(map:keys($textToBiblMap) ! map{$textToBiblMap(.): .})"/>
    
    <xsl:template name="go">
        <xsl:apply-templates select="$biblio"/>
        <xsl:apply-templates select="$texts"/>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:result-document href="{wea:getDestHref(.)}" method="xml" indent="no">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:apply-templates/>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match=""
    
    <xsl:template match="div[@xml:id = 'bibliography_we']">
        <xsl:call-template name="makeRelationship"/>        
    </xsl:template>
    
    <xsl:template match="listBibl[ancestor::div[@xml:id = 'bibliography_we']]">
        <relation name="work">
            <xsl:sequence select="@xml:id"/>
            <xsl:attribute name="mutual"
                select="child::bibl ! 'doc:' || $biblToTextMap(string(./@xml:id))"
                separator=" "/>
            <desc>
                <xsl:apply-templates select="head/node()"/>
            </desc>
        </relation>
    </xsl:template>

    
    <xsl:template match="div[ancestor::TEI/@xml:id ='bibliography'][not(@xml:id) = 'bibliography_we']">
        <xsl:sequence select="."/>
    </xsl:template>
    
    <xsl:template name="change">
        <xsl:param name="status" select="parent::revisionDesc/@status" as="xs:string?"/>
        <xsl:param name="message">Added citation from bibliography.xml to <gi>sourceDesc</gi> using utilities/msdesc.xsl.</xsl:param>
        <change who="pers:JT1" when="{$today}" status="{($status,'published')[1]}"><xsl:sequence select="$message"/></change>
    </xsl:template>
    
    <xsl:template name="makeRelationship">
        <xsl:result-document href="{$dest}/relationships.xml" method="xml" indent="yes">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:sequence select="root(.)/processing-instruction('xml-model')"/>
            <TEI xml:id="relationships.xml">
                <fileDesc>
                    <titleStmt>
                        <title>Bibliography</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Publication Information</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Born digital.</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <textClass>
                        <catRef target="wdt:docBornDigital" scheme="wdt:docType"/>
                    </textClass>
                </profileDesc>
                <revisionDesc status="published">
                    <xsl:call-template name="change">
                        <xsl:with-param name="message"
                            select="'Generated new file from bibliography.xml using utilities/msdesc.xsl.'"/>
                    </xsl:call-template>
                </revisionDesc>
                <text>
                    <body>
                        <listRelation>
                            <xsl:apply-templates/>
                        </listRelation>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>       
    </xsl:template>
    
    
    <xsl:function name="wea:getDestHref">
        <xsl:param name="el"/>
        
        <xsl:variable name="uri" select="base-uri(root($el))"/>
        <xsl:sequence select="replace($uri,'^.+/wea_data/data', $dest)"/>
        
    </xsl:function>
    
    
    
    
    
    
    
    
</xsl:stylesheet>