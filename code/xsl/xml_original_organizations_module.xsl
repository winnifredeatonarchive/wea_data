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
                <xsl:with-param name="categories" select="'wdt:docBornDigitalListing'"/>
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
            <xsl:choose>
                <xsl:when test="not(empty($bibls))">
                    <div>
                        <head>In the Archive</head>
                        <table type="exhibit">
                            <row role="label">
                                <cell/>
                                <cell>Title</cell>
                                <cell>Date Published</cell>
                                <cell>Transcription Available</cell>
                            </row>
                            <!--A small function to get the category docs for this category-->
                            <xsl:for-each select="$bibls">
                                <xsl:variable name="thisBibl" select="."/>
                                <xsl:variable name="biblId" select="$thisBibl/@xml:id"/>
                                <xsl:variable name="docs" select="$sourceXml//TEI[//sourceDesc/bibl[@copyOf=replace($biblId,'bibl','bibl:')]]"/>
                                <xsl:for-each select="$docs">
                                    <xsl:variable name="thisDoc" select="."/>
                                    <xsl:variable name="docId" select="$thisDoc/@xml:id"/>
                                    <row>
                                        <cell>
                                            <xsl:choose>
                                                <xsl:when test="$thisDoc//text[@facs]">
                                                    <figure>
                                                        <graphic url="facsimiles/{substring-after($thisDoc//text/@facs,'facs:')}_tiny.jpg">
                                                            <desc>Thumbnail of the first page of the facsimile for <xsl:value-of select="$thisDoc//titleStmt/title[1]"/>.</desc>
                                                        </graphic>
                                                    </figure>
                                                </xsl:when>
                                            </xsl:choose>
                                        </cell>
                                        
                                        <cell>
                                            <ref target="doc:{$docId}"><xsl:copy-of select="$thisDoc//titleStmt/title[1]/node()"/></ref>
                                        </cell>
                                        <cell>
                                            <xsl:choose>
                                                <xsl:when test="not(empty($thisBibl/date))">
                                                    <xsl:copy-of select="$thisBibl/date"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <date/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                                    
                                        </cell>
                                        <cell>
                                            <xsl:choose>
                                                <xsl:when test="normalize-space(string-join($thisDoc//text,'')) ne ''">
                                                    <xsl:text>Yes</xsl:text>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:text>No</xsl:text>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </cell>
                                    </row>
                                </xsl:for-each>
                            </xsl:for-each>
                        </table>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <p>No documents available.</p>
                </xsl:otherwise>
            </xsl:choose>
            
        </body>
        
    </xsl:template>

    
</xsl:stylesheet>