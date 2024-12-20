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
    
    
    <xsl:variable name="allOrgs" select="$sourceXml//TEI[@xml:id='organizations']/descendant::org[@xml:id]"/>
    
    <xsl:template name="createOrgPages">
        <xsl:for-each select="$allOrgs">
            <xsl:call-template name="generateTeiPage">
                <xsl:with-param name="outDoc" select="concat($outDir,'xml/original/',@xml:id,'.xml')"/>
                <xsl:with-param name="thisId" select="@xml:id"/>
                <xsl:with-param name="categories" select="'wdt:docBornDigitalListing'"/>
                <xsl:with-param name="title"><xsl:value-of select="orgName"/></xsl:with-param>
                <xsl:with-param name="respStmts" select="if (@resp) then wea:makeEntityResp(@resp) else ()"/>
                <xsl:with-param name="content">
                    <xsl:apply-templates select="." mode="orgs"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="createPublishersTable">
        <div>
            <table type="exhibit">
                <row role="label">
                    <cell role="sortkey">Name</cell>
                    <cell>Note</cell>
                    <cell>Texts Published</cell>
                </row>
                <xsl:for-each select="$allOrgs">
                    <xsl:sort select="wea:makeTitleSortKey(string(orgName))"/>
                    <xsl:variable name="thisId" select="@xml:id"/>
                    <xsl:variable name="docsPublished"
                        select="$sourceXml//TEI[descendant::sourceDesc/descendant::bibl[descendant::*[@ref = 'org:' || $thisId]]]"/>
                    <xsl:variable name="count" select="count($docsPublished)" as="xs:integer"/>
                    <xsl:if test="$count gt 0">
                        <row>
                            <cell><ref target="doc:{$thisId}"><xsl:sequence select="orgName/node()"/></ref></cell>
                            <cell><xsl:sequence select="note/node()"/></cell>
                            <cell><xsl:value-of select="$count"/></cell>
                        </row>
                    </xsl:if>
                </xsl:for-each>
            </table>
        </div>
    </xsl:template>
    
    
    
    <xsl:template match="org" mode="orgs">
        <xsl:variable name="thisId" select="@xml:id"/>
        <xsl:variable name="thisIdPtr" select="concat('org:',$thisId)"/>
        
        <xsl:variable name="pubBibls" select="$sourceXml//bibl[ancestor::msDesc][publisher[@ref=$thisIdPtr]]"
            as="element(bibl)*"/>
        <xsl:variable name="fondsBibls"
            select="$sourceXml//bibl[ancestor::msDesc][distributor[@ref=$thisIdPtr]]" as="element(bibl)*"/>
        <xsl:variable name="bibls" select="($pubBibls,$fondsBibls)"/>
        <xsl:variable name="isFonds" select="exists($fondsBibls)"/>
        <xsl:if test="$isFonds and exists($pubBibls)">
            <xsl:message terminate="yes">ERROR: Something is both a publisher and a distributor</xsl:message>
        </xsl:if>
        <body>
            <head><xsl:copy-of select="orgName/node()"/></head>
            <div>
                <xsl:apply-templates select="note" mode="#current"/>
            </div>
            <div>
            <xsl:choose>
                <xsl:when test="not(empty(($pubBibls,$fondsBibls)))">
                    <table type="exhibit">
                        <row role="label">
                            <cell/>
                            <cell>Title</cell>
                
                            <cell>Date</cell>
                            <xsl:if test="$isFonds">
                                <cell>Box/File Number</cell>
                            </xsl:if>
                            <cell>Transcription Available</cell>
                        </row>
                        <xsl:for-each select="$bibls">
                            <xsl:variable name="thisBibl" select="."/>
                            <xsl:variable name="biblId" select="$thisBibl/@xml:id"/>
                            <xsl:variable name="docs" select="ancestor::TEI"/>
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
                                                <xsl:sequence select="wea:formatDate($thisBibl/date)"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <date/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </cell>
                                    <xsl:if test="$isFonds">
                                        <cell><xsl:value-of select="$thisBibl/idno"/></cell>
                                    </xsl:if>
                                    
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
                </xsl:when>
                <xsl:otherwise>
                    <p>No documents available.</p>
                </xsl:otherwise>
            </xsl:choose>
            </div>
        </body>
        
    </xsl:template>
    
    
</xsl:stylesheet>