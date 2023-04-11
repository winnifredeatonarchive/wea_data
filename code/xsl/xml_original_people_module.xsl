<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
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
                <xsl:with-param name="categories" select="'wdt:docBornDigitalListing'"/>
                <xsl:with-param name="title"><xsl:value-of select="persName/reg"/></xsl:with-param>
                <xsl:with-param name="respStmts" select="if (@resp) then wea:makeEntityResp(@resp) else ()"/>
                <xsl:with-param name="content">
                    <xsl:apply-templates select="." mode="people"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
  
  
  
   <xsl:template match="person[parent::listPerson[@type='contributor']]" mode="people">
       <xsl:variable name="thisId" select="@xml:id"/>
       <xsl:variable name="ptr" select="'pers:'||$thisId" as="xs:string"/>
       <xsl:variable name="respStmts" 
           select="$sourceXml//TEI[not(@xml:id = ('footer','index','redirects','menu'))][descendant::respStmt[name[@ref=$ptr]] or descendant::abstract[contains-token(@resp,$ptr)]]" as="element(TEI)*"/>
       <xsl:variable name="fragRespStmts" select="$sourceXml//TEI[not(@xml:id = ('footer','index', 'redirects','menu'))]/descendant::tei:*[self::org or self::person or self::place][contains-token(@resp, $ptr)]" as="element()*"/>
       <body>
           <head><xsl:value-of select="persName/reg"/></head>
           <div>
               <xsl:apply-templates select="note" mode="#current"/>
           </div>
           <xsl:if test="exists(($respStmts, $fragRespStmts))">
               <div>
                   <table type="exhibit">
                       <row role="label">
                           <cell/>
                           <cell>Title</cell>
                           <cell>Role</cell>
                       </row>
                       <xsl:for-each select="($respStmts, $fragRespStmts)">
                           <xsl:variable name="thisDoc" select="."/>
                           <xsl:variable name="docId" select="$thisDoc/@xml:id"/>
                           <row>
                               <cell>
                                   <xsl:choose>
                                       <xsl:when test="$thisDoc//text[@facs]">
                                           <ref target="doc:{$docId}">
                                               <figure>
                                                   <graphic url="facsimiles/{substring-after($thisDoc//text/@facs,'facs:')}_tiny.jpg">
                                                       <desc>Thumbnail of the first page of the facsimile for <xsl:value-of select="$thisDoc/teiHeader/fileDesc/titleStmt/title[1]"/>.</desc>
                                                   </graphic>
                                               </figure>
                                           </ref>
                                           
                                       </xsl:when>
                                   </xsl:choose>
                               </cell>
                               <cell>
                                   <ref target="doc:{$docId}">
                                       <xsl:choose>
                                           <xsl:when test="$thisDoc/self::TEI">
                                               <xsl:copy-of select="$thisDoc/teiHeader/fileDesc/titleStmt/title[1]/node()"/>
                                           </xsl:when>
                                           <xsl:otherwise>
                                               <xsl:sequence select="($thisDoc/persName/reg | $thisDoc/orgName)[1]/node()"/>
                                           </xsl:otherwise>
                                       </xsl:choose>
                                   </ref>
                               </cell>
                               <cell>
                                   <list>
                                       <xsl:choose>
                                           <xsl:when test="$thisDoc/self::TEI">
                                               <xsl:for-each select="$thisDoc//respStmt[name[@ref=$ptr]]">
                                                   <item><xsl:value-of select="resp"/></item>
                                               </xsl:for-each>
                                               <xsl:for-each select="$thisDoc//abstract[contains-token(@resp,$ptr)]">
                                                   <item>Author of Headnote</item>
                                               </xsl:for-each>
                                           </xsl:when>
                                           <xsl:otherwise>
                                               <item>Author</item>
                                           </xsl:otherwise>
                                       </xsl:choose>
                                   </list>
                               </cell>
                           </row>
                       </xsl:for-each>
                   </table>
               </div>
           </xsl:if>
           
       </body>
       
       
       
   </xsl:template>
    <xsl:template match="person[parent::listPerson[@type='primary']]" mode="people">
        <xsl:variable name="thisId" select="@xml:id"/>
        <body>
            <head><xsl:value-of select="persName/reg"/></head>
            <div>
                <xsl:apply-templates select="note" mode="#current"/>
            </div>
            <xsl:variable name="bibls" select="wea:getBiblsFromPers($thisId)" as="element(bibl)*"/>
            <xsl:variable name="credits" select="wea:getBiblRolesFromPers($thisId)" as="map(xs:string, xs:string*)?"/>
            <xsl:variable name="creditDocs" select="if (exists($credits)) then map:keys($credits) else ()" as="xs:string*"/>
            <xsl:if test="exists($creditDocs)">
                <div>
                    <head>Credits</head>
                    <table type="exhibit">
                        <row role="label">
                            <cell/>
                            <cell>Title</cell>
                            <cell>Date</cell>
                            <cell>Role</cell>
                        </row>
                        <xsl:for-each select="$creditDocs">
                            <xsl:variable name="docId" select="."/>
                            <xsl:variable name="thisDoc" select="$sourceXml//TEI[@xml:id = $docId]"/>
                            <xsl:variable name="thisBiblId" select="$thisDoc//sourceDesc/bibl/replace(@copyOf,'bibl:','bibl')"/>
                            <xsl:variable name="thisBibl" select="$bibls[@xml:id=$thisBiblId]" as="element(bibl)"/>
                            <row>
                                <cell>
                                    <xsl:choose>
                                        <xsl:when test="$thisDoc//text[@facs]">
                                            <ref target="doc:{$docId}">
                                                <figure>
                                                    <graphic url="facsimiles/{substring-after($thisDoc//text/@facs,'facs:')}_tiny.jpg">
                                                        <desc>Thumbnail of the first page of the facsimile for <xsl:value-of select="$thisDoc/teiHeader/fileDesc/titleStmt/title[1]"/>.</desc>
                                                    </graphic>
                                                </figure>
                                            </ref>
                                            
                                        </xsl:when>
                                    </xsl:choose>
                                </cell>
                                <cell>
                                    <ref target="doc:{$docId}"><xsl:copy-of select="$thisDoc/teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref>
                                </cell>
                                <cell>
                                    <xsl:choose>
                                        <xsl:when test="$thisBibl/date">
                                            <xsl:sequence select="$thisBibl/date"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <date/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </cell>
                                <cell>
                                    <list>
                                        <xsl:for-each select="$credits($docId)">
                                            <item><xsl:value-of select="."/></item>
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
    
    
    <xsl:function name="wea:getBiblRolesFromPers" new-each-time="no" as="map(xs:string, xs:string*)?">
        <xsl:param name="personId" as="xs:string"/>
        <xsl:variable name="bibls" select="wea:getBiblsFromPers($personId)"/>
        <xsl:if test="$bibls">
            <xsl:map>
                <xsl:for-each select="$bibls">
                    <xsl:variable name="thisBibl" select="." as="element(bibl)"/>
                    <xsl:variable name="thisBiblId" select="@xml:id"/>
                    <xsl:variable name="thisBiblKey" select="replace($thisBiblId,'bibl','bibl:')"/>
                    <xsl:variable name="docId" 
                        select="$sourceXml//TEI[descendant::sourceDesc[bibl[@copyOf = $thisBiblKey]]]/@xml:id" as="xs:string?"/>
                    <xsl:variable name="rolesPlayed" as="xs:string*">
                        <xsl:for-each select="$thisBibl/descendant::name[@ref=concat('pers:',$personId)]">
                            <xsl:choose>
                                <xsl:when test="parent::author[@role='illustrator']">Illustrator</xsl:when>
                                <xsl:when test="parent::author">Author</xsl:when>
                                <xsl:when test="parent::editor">Editor</xsl:when>
                                <xsl:otherwise>Contributor</xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:if test="$docId">
                        <xsl:map-entry key="xs:string($docId)" select="distinct-values($rolesPlayed)"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:map>
        </xsl:if>    
        
        
        
    </xsl:function>
    
    <xsl:function name="wea:getBiblsFromPers" new-each-time="no" as="element(bibl)*">
        <xsl:param name="personId" as="xs:string"/>
        <xsl:sequence select="$sourceXml//TEI[@xml:id='bibliography']//bibl[descendant::name[@ref=concat('pers:',$personId)]]"/>
    </xsl:function>
    
</xsl:stylesheet>