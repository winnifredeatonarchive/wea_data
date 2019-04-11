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
            <xd:p>Created on: March 7, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet module creates the organization pages for the WEA project.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:template name="createOrgPages">
        <xsl:for-each select="$sourceXml[//TEI/@xml:id='organizations']//org[@xml:id]">
            <xsl:call-template name="generateTeiPage">
                <xsl:with-param name="outDoc" select="concat($outDir,'xml/original/',@xml:id,'.xml')"/>
                <xsl:with-param name="thisId" select="@xml:id"/>
                <xsl:with-param name="categories" select="'wdt:docBornDigital'"/>
                <xsl:with-param name="title"><xsl:value-of select="orgName"/></xsl:with-param>
                <xsl:with-param name="content">
                    <xsl:apply-templates select="." mode="orgs"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    
    
    <xsl:template match="org" mode="orgs">
        <xsl:variable name="thisId" select="@xml:id"/>
        <xsl:variable name="thisIdPtr" select="concat('org:',$thisId)"/>
        <xsl:variable name="bibls" select="$sourceXml[//TEI/@xml:id='bibliography']//bibl[@xml:id][publisher[@ref=$thisIdPtr]]"/>
        <body>
            <head><xsl:value-of select="orgName"/></head>
            <div>
                <head>Publications in the Archive</head>
                <xsl:choose>
                    <xsl:when test="not(empty($bibls))">
                        <xsl:for-each select="$bibls">
                            <xsl:variable name="biblId" select="@xml:id"/>
                            <xsl:variable name="docs" select="$sourceXml//TEI[//sourceDesc/bibl[@copyOf=replace($biblId,'bibl','bibl:')]]"/>
                            <xsl:choose>
                                <xsl:when test="not(empty($docs))">
                                    <list>
                                        <xsl:for-each select="$docs">
                                            <item><ref target="doc:{@xml:id}"><xsl:sequence select="teiHeader/fileDesc/titleStmt/title[1]"/></ref></item>
                                        </xsl:for-each>
                                    </list>
                                </xsl:when>
                                <xsl:otherwise>
                                    <p>No documents.</p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>No documents.</p>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </body>
        
    </xsl:template>

    
</xsl:stylesheet>