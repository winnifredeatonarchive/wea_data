<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet creates the index page(s) for the WEA project.</xd:p>
        </xd:desc>
    </xd:doc>
    
  <xsl:include href="globals.xsl"/>
    
    <xsl:template match="/">
        <xsl:call-template name="createIndexPage"/>
    </xsl:template>
    
    
    
    
   <xsl:template name="createIndexPage">
       <xsl:call-template name="generateTeiPage">
           <xsl:with-param name="thisId" select="'azindex'"/>
           <xsl:with-param name="outDoc" select="concat($outDir,'xml/original/azindex.xml')"/>
           <xsl:with-param name="title">A–Z Index</xsl:with-param>
           <xsl:with-param name="categories" select="'wdt:docBornDigitalListing'"/>
           <xsl:with-param name="content">
               <body>
                   <head>A-Z Index</head>
                   <xsl:for-each-group select="$originalXml//TEI" group-by="some $r in //catRef/@target satisfies matches($r,'PrimarySource')">
                       <xsl:sort select="current-grouping-key()" order="descending"/>
                       <div>
                          <head>
                              <xsl:choose>
                                  <xsl:when test="current-grouping-key()">Primary Sources</xsl:when>
                                  <xsl:otherwise>Other Pages</xsl:otherwise>
                              </xsl:choose>
                          </head>
                              <div>
                                  <xsl:choose>
                                      <xsl:when test="current-grouping-key()">
                                          <table type="exhibit">
                                              <row role="label">
                                                  <cell/>
                                                  <cell>Id</cell>
                                                  <cell>Title</cell>
                                                  <cell role="sortkey">Date Published</cell>
                                                  <cell>Transcription Available</cell>
                                              </row>
                                              <!--A small function to get the category docs for this category-->
                                              <xsl:for-each select="current-group()">
                                                  <xsl:variable name="thisDoc" select="." as="element()"/>
                                                  <xsl:variable name="docId" select="$thisDoc/@xml:id" as="xs:string"/>
                                                  
                                                  <row>
                                                      <cell>
                                                          <xsl:choose>
                                                              <xsl:when test="$thisDoc//text[@facs]">
                                                                  <figure>
                                                                      <graphic url="facsimiles/{substring-after($thisDoc//text/@facs,'facs:')}_tiny.jpg">
                                                                          <desc>Thumbnail of the first page of the facsimile for <xsl:value-of select="$thisDoc/teiHeader/fileDesc/titleStmt/title[1]"/>.</desc>
                                                                      </graphic>
                                                                  </figure>
                                                              </xsl:when>
                                                          </xsl:choose>
                                                      </cell>
                                                      <cell>
                                                          <ref target="doc:{$docId}"><xsl:value-of select="$docId"/></ref>
                                                      </cell>
                                                      <cell>
                                                          <ref target="doc:{$docId}"><xsl:copy-of select="$thisDoc//teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref>
                                                      </cell>
                                                      <cell>
                                                          <xsl:choose>
                                                              <xsl:when test="$thisDoc//sourceDesc/bibl[@copyOf]">
                                                                  <xsl:choose>
                                                                      <xsl:when test="not(empty($thisDoc//sourceDesc/bibl/date))">
                                                                          <xsl:copy-of select="$thisDoc//sourceDesc/bibl/date"/>
                                                                      </xsl:when>
                                                                      <xsl:otherwise>
                                                                          <date/>
                                                                      </xsl:otherwise>
                                                                  </xsl:choose>
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
                                          </table>
                                      </xsl:when>
                                      <xsl:otherwise>
                                          <table>
                                              <row role="label">
                                                  <cell>Title</cell>
                                                  <cell>Document ID</cell>
                                              </row>
                                              <xsl:for-each select="current-group()">
                                                  <row>
                                                      <cell><ref target="doc:{@xml:id}"><xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref></cell>
                                                      <cell><xsl:value-of select="@xml:id"/></cell>
                                                  </row>
                                              </xsl:for-each>
                                          </table>
                                      </xsl:otherwise>
                                  </xsl:choose>
                                  
                              </div>
                       </div>
                   </xsl:for-each-group>
               </body>
           </xsl:with-param>
       </xsl:call-template>
   </xsl:template>
   
</xsl:stylesheet>