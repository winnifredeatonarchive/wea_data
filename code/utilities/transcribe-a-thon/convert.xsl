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
            <xd:p><xd:b>Created on:</xd:b> Jan 5, 2024</xd:p>
            <xd:p><xd:b>Author:</xd:b> takeda</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="data" as="xs:string" select="'{}'" static="yes"/>
    <xsl:variable name="map" select="parse-json($data)" static="yes"/>
    <xsl:variable name="isTemplate" select="$map?isTemplate" static="yes"/>
    <xsl:variable name="id" 
        select="$map?id" as="xs:string"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:output method="xml" indent="yes" suppress-indentation="bibl title text"/>



    <xsl:template match="TEI/@xml:id">
        <xsl:attribute name="xml:id" select="$id"/>
    </xsl:template>
    
    <xsl:template match="titleStmt">
        <xsl:copy>
            <xsl:apply-templates select="title"/>
            <xsl:for-each select="tokenize($map?Transcriber_IDs, '\s*,\s*')">
                <respStmt>
                    <resp>Transcriber</resp>
                    <name ref="pers:{.}"/>
                </respStmt>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="titleStmt/title">
        <title><xsl:value-of select="$map?Title"/></title>
    </xsl:template>
    
    <xsl:template match="msDesc">
        <xsl:copy>
            <xsl:if test="not(msIdentifier) and string-length($map?UofC_ID) gt 0">
                <msIdentifier>
                    <repository ref="org:WERFonds">Winnifred Eaton Reeve Fonds</repository>
                    <idno type="UofC"><xsl:value-of select="$map?UofC_ID"/></idno>
                </msIdentifier>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="availability">
        <xsl:copy>
            <p><xsl:value-of select="$map?Notes"/></p>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="msItem/bibl">
        <xsl:choose>
            <xsl:when test="matches(string(.),'\S')">
                <xsl:next-match/>
            </xsl:when>
            <xsl:otherwise>
                <bibl><title><xsl:value-of select="$map?Title"/></title></bibl>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="text">
        <xsl:copy>
            <xsl:attribute name="facs" select="'facs:' || $id"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="revisionDesc">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <change who="pers:JT1" when="{current-date() => format-date('[Y0001]-[M01]-[D01]')}" status="{@status}">Adding document from 2023 Calgary Transcribe-a-thon.</change>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
        
    </xsl:template>
    
    
    <xsl:template match="msIdentifier">
        <xsl:copy>
            <xsl:apply-templates/>
            <xsl:if test="string-length($map?UofC_ID) gt 0">
                <idno type="UofC"><xsl:value-of select="$map?UofC_ID"/></idno>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
  
    <xsl:template match="textClass">
        <xsl:copy>
            <catRef scheme="wdt:genre" target="wdt:{$map?Genre}"/>
            <catRef scheme="wdt:exhibit" target="wdt:{$map?Exhibit}"/>
            <catRef scheme="wdt:docType" target="wdt:{$map?DocType}"/>
        </xsl:copy>
    </xsl:template>
    
    

</xsl:stylesheet>