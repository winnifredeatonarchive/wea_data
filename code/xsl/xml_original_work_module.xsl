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
            <xd:p>This stylesheet module creates the category pages for the WEA project.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:template name="createWorkPages">
        <xsl:for-each select="$sourceXml//linkGrp[@type='work']">
            <xsl:call-template name="generateTeiPage">
                <xsl:with-param name="outDoc" select="concat($outDir,'xml/original/',@xml:id,'.xml')"/>
                <xsl:with-param name="thisId" select="@xml:id"/>
                <xsl:with-param name="categories" select="'wdt:docBornDigitalListing'"/>
                <xsl:with-param name="title"><xsl:value-of select="desc"/></xsl:with-param>
                <xsl:with-param name="content">
                    <xsl:apply-templates select="." mode="bibls"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:template match="linkGrp[@type='work']" mode="bibls">
        <body>
            <head>
                <xsl:sequence select="desc/node()"/>
            </head>
            <div>                
                <table type="exhibit">
                    <row role="label">
                        <cell/>
                        <cell>Title</cell>
                        <cell>Date Published</cell>
                        <cell>Transcription Available</cell>
                    </row>
                    <!--A small function to get the category docs for this category-->
                    <xsl:for-each select="ptr[@target]">
                        <xsl:variable name="docId" select="substring-after(@target,'doc:')"/>
                        <xsl:variable name="thisDoc"
                            select="$sourceXml//TEI[@xml:id=$docId]" as="element(TEI)"/>
                        <xsl:variable name="bibl" select="$thisDoc//msDesc/msContents/msItem/bibl"
                            as="element(bibl)"/>
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
                                <ref target="doc:{$docId}"><xsl:copy-of select="$thisDoc//teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref>
                            </cell>
                            <cell>
                                <xsl:variable name="biblDate" select="$bibl/date[1]"/>
                                <xsl:choose>
                                    <xsl:when test="not(empty($biblDate))">
                                        <xsl:sequence select="wea:formatDate($biblDate)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <date/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </cell>
                            <cell>
                                <xsl:choose>
                                    <xsl:when test="some $t in 
                                        $thisDoc//text/descendant::text() satisfies matches($t,'\S')">
                                        <xsl:text>Yes</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>No</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </cell>
                        </row>
                    </xsl:for-each>
                
                </table>
            </div>
            
        </body>
    </xsl:template>
    
 
    
</xsl:stylesheet>