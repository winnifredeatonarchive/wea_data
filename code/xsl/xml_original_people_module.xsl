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
    
    
    <xsl:template name="createPeoplePages">
        <xsl:for-each select="$sourceXml[//TEI/@xml:id='people']//person[@xml:id]">
            <xsl:call-template name="generateTeiPage">
                <xsl:with-param name="outDoc" select="concat($outDir,'xml/original/',@xml:id,'.xml')"/>
                <xsl:with-param name="thisId" select="@xml:id"/>
                <xsl:with-param name="categories" select="'wdt:docBornDigital'"/>
                <xsl:with-param name="title"><xsl:value-of select="persName/reg"/></xsl:with-param>
                <xsl:with-param name="content">
                    <xsl:apply-templates select="." mode="people"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
  
  
  
    <xsl:template match="person" mode="people">
        <xsl:variable name="thisId" select="@xml:id"/>
        <body>
            <head><xsl:value-of select="persName/reg"/></head>
            <div>
<!--                <head>Biography</head>-->
                <xsl:apply-templates select="note" mode="#current"/>
            </div>
            <xsl:variable name="respStmts" select="$sourceXml//TEI[descendant::respStmt[name[@ref=concat('pers:',$thisId)]]]" as="element(TEI)*"/>
            <xsl:if test="not(empty($respStmts))">
                <div>
                    <head>Credits</head>
                    <table type="exhibit">
                        <row role="label">
                            <cell/>
                            <cell>Title</cell>
                            <cell>Roles Played</cell>
                        </row>
                        <xsl:for-each select="$respStmts">
                            <xsl:variable name="thisDoc" select="."/>
                            <xsl:variable name="docId" select="$thisDoc/@xml:id"/>
                            <row>
                                <cell>
                                    <xsl:choose>
                                        <xsl:when test="$thisDoc//text[@facs]">
                                            <figure>
                                                <graphic url="facsimiles/{substring-after($thisDoc//text/@facs,'facs:')}_tiny.png">
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
                                    <list>
                                        <xsl:for-each select="$thisDoc//respStmt[name[@ref=concat('pers:',$thisId)]]">
                                            <item><xsl:value-of select="resp"/></item>
                                        </xsl:for-each>
                                    </list>
                                </cell>
                            </row>
                        </xsl:for-each>
                    </table>
                </div>
            </xsl:if>
            
        </body>
     
    </xsl:template>
    
    
</xsl:stylesheet>