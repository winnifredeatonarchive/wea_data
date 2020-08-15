<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>Date: August 2020</xd:p>
            <xd:p>This stylesheet is a utility transformation to fix up the respStmts from the 
                texts converted from P4.</xd:p>
            <xd:p>RUN ON AUGUST 15, 2020. DO NOT RUN AGAIN.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:variable name="p4Texts" select="collection('../../p4Texts?select=*.xml')"/>
    
    <xsl:variable name="p5Texts" select="collection('../../data/texts?select=*.xml')"/>
    
    <xsl:variable name="people" 
        select="document('../../data/people.xml')"/>
    
    <xsl:mode name="p5" on-no-match="shallow-copy"/>
    
    
    <xsl:variable name="newNote" as="element(note)">
        <note>This document was originally encoded in TEI P4 by the ∂<name ref="https://dcs.library.virginia.edu/digital-stewardship-services/etext/">University of Virginia Library Electronic Text Center</name>.</note>
    </xsl:variable>
    
    <xsl:template name="go">
        <xsl:for-each select="$p4Texts">
            <xsl:variable name="p4Filename" select="tokenize(document-uri(.),'/')[last()]"/>
            <xsl:variable name="theseRespStmts" as="element(respStmt)*">
                <xsl:apply-templates select="//*:change/*:respStmt" mode="p4"/>
            </xsl:variable>
            <xsl:variable name="theseP5s" select="$p5Texts[//change[contains(string(.), $p4Filename)]]"/>
            <xsl:for-each select="$theseP5s">
                <xsl:result-document href="fix_p4_resps_tmp/{//TEI/@xml:id}.xml" method="xml" indent="yes" suppress-indentation="text body p foreign">
                    <xsl:apply-templates select="." mode="p5">
                        <xsl:with-param name="resps" select="$theseRespStmts" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:result-document>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:template match="notesStmt" mode="p5">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <xsl:sequence select="$newNote"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="sourceDesc[not(preceding::notesStmt)]" mode="p5">
        <notesStmt>
            <xsl:sequence select="$newNote"/>
        </notesStmt>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
        
    <xsl:template match="respStmt" mode="p5">
        <xsl:variable name="thisResp" select="normalize-space(string(resp))"/>
        <xsl:choose>
            <xsl:when test="$thisResp = 'Creation of machine-readable version'">
                <respStmt>
                    <resp notAfter="2017">Original Creator of Machine-Readable Version</resp>
                    <name ref="pers:JLC1">Jean Lee Cole</name>
                </respStmt>
            </xsl:when>
            <xsl:when test="$thisResp = 'Conversion to TEI.2-conformant markup'">
                <respStmt>
                    <resp notAfter="2017">Original Creator of TEI Text</resp>
                    <name ref="https://dcs.library.virginia.edu/digital-stewardship-services/etext/">University of Virginia Library Electronic Text Center</name>
                </respStmt>
            </xsl:when>
            <xsl:when test="$thisResp = 'Conversion to P5 conformant markup:'"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()" mode="#current"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="teiHeader/fileDesc/titleStmt" mode="p5">
        <xsl:param name="resps" tunnel="yes" as="element(respStmt)*"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <xsl:for-each select="$resps">
                <xsl:sort select="if (*:resp/@when) then xs:date(*:resp/@when || '-01') else ()" order="descending"/>
                <xsl:message><xsl:sequence select="*:resp/@when"/></xsl:message>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*:respStmt" mode="p4">
        <xsl:variable name="thisName" select="*:name/string(.)"/>
        <xsl:variable name="newResp" as="xs:string">
            <xsl:choose>
                <xsl:when test="matches(*:resp,'corrector','i')">Corrector</xsl:when>
                <xsl:otherwise>Migrator</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <respStmt>
            <resp when="{../*:date/@value}"><xsl:value-of select="'Original ' || $newResp"/></resp>
            <xsl:variable name="nameId" as="xs:string">
                <xsl:choose>
                    <xsl:when test="matches($thisName, 'Matthew')">MG1</xsl:when>
                    <xsl:when test="matches($thisName, 'Ambrose')">AF1</xsl:when>
                    <xsl:when test="matches($thisName, 'Jolie')">JS1</xsl:when>
                    <xsl:when test="matches($thisName, 'John')">JC2</xsl:when>
                    <xsl:when test="matches($thisName, 'Ethan')">EG1</xsl:when>
                    <xsl:when test="matches($thisName, 'Greg')">GM1</xsl:when>
                    <xsl:when test="matches($thisName, 'Jordan')">JT2</xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="thisPerson" select="$people//person[@xml:id=$nameId]" as="element(person)"/>
            <name ref="pers:{$nameId}"><xsl:value-of select="$thisPerson/persName/reg"/></name>
        </respStmt>
    </xsl:template>
    
</xsl:stylesheet>