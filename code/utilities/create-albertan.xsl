<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 19, 2024</xd:p>
            <xd:p><xd:b>Author:</xd:b> takeda</xd:p>
            <xd:p>Short utility to create the Albertan documents.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:variable name="sourceDoc" select="document('../../data/texts/BooksLiteraryNotesCarman1.xml')"/>
    
    <xsl:variable name="bibls" select="document('MorningAlberta-NewTexts-2024-08-10.xml')"/>
    
    <xsl:template name="go">
        <xsl:for-each select="$bibls//bibl">
            <xsl:apply-templates select="$sourceDoc">
                <xsl:with-param name="bibl" select="." tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:result-document suppress-indentation="bibl" href="../../data/tmp/{$bibl/@xml:id}.xml" method="xml" indent="yes">
            <xsl:message select="current-output-uri()"/>
            <xsl:apply-templates/>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="titleStmt/title">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="$bibl/title[@level='a']/node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="respStmt"/>
    
    <xsl:template match="availability/p">
        <p>Facsimile retrieved from Newspapers.com</p>
    </xsl:template>
    
    <xsl:template match="text/@facs">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:attribute name="facs" select="'facs:' || $bibl/@xml:id"/>
    </xsl:template>
    
    <xsl:template match="TEI/@xml:id">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:attribute name="xml:id" select="$bibl/@xml:id"/>
    </xsl:template>
    
    <xsl:template match="revisionDesc">
        <revisionDesc status="empty">
            <change who="pers:JT1" 
                when="{current-date() => format-date('[Y0001]-[M01]-[D01]')}"
                status="empty">Created document.</change>
        </revisionDesc>
    </xsl:template>
    
    <xsl:template match="catRef[@scheme='wdt:genre']">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test="$bibl/@ana = 'BLURB'">
                <catRef scheme="wdt:genre" target="wdt:genreNFMiscellanyBlurb"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="msItem">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="$bibl"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="bibl/@xml:id | bibl/@ana"/>
    
    <xsl:template match="bibl/note">
        <xsl:comment>
            <xsl:value-of select="serialize(.)"/>
        </xsl:comment>
    </xsl:template>
    
    <xsl:template match="body">
        <body>
            <div>
                <gap reason="noTranscriptionAvailable"/>
            </div>
        </body>
    </xsl:template>
    
    
    
</xsl:stylesheet>