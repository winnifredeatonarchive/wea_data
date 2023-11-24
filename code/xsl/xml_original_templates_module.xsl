<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet is the master stylesheet for the WEA project's conversion
                from TEI P5 to XHTML5. It may load in other modules, if the complexity of the project
                necessitiates it.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template match="divGen[@xml:id='pseudonyms_table']" mode="original">
        <xsl:call-template name="createPseudonymsTable"/>
<!--        <xsl:call-template name="createPseudonymsTimeline"/>-->
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='we_collaborators_table']" mode="original">
        <xsl:call-template name="createCollabTable"/>
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='we_publishers_table']" mode="original">
        <xsl:call-template name="createPublishersTable"/>
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='contribute_package_texts']" mode="original">
        <xsl:variable name="availableDocs" select="$sourceXml[descendant::gap[@reason='noTranscriptionAvailable'] and descendant::text[@facs] and descendant::revisionDesc/@status='empty']//TEI" as="element(TEI)*"/> 
        <div xml:id="{@xml:id}">
            <head>Texts</head>
           <div>
               <list xml:id="{@xml:id}_texts" type="checklist">
                   <xsl:for-each select="$availableDocs">
                       <xsl:sort select="string(@xml:id)"/>
                       <item facs="facs:{//text/@facs}">
                           <ref target="doc:{@xml:id}"><xsl:sequence select="//teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref>
                       </item>
                   </xsl:for-each>
               </list>
           </div>
        </div>
    </xsl:template>
    
    <xsl:template name="createCollabTable">
        <div>
            <table type="exhibit">
                <row role="label">
                    <cell>Name</cell>
                    <cell>Roles</cell>
                    <cell>Biography</cell>
                </row>
                <xsl:for-each select="$sourceXml//TEI[@xml:id='people']//listPerson[@type='primary']/person[not(@xml:id='WE1')]">
                    <row>
                        <cell><ref target="doc:{@xml:id}"><xsl:sequence select="persName/reg/node()"/></ref></cell>
                        <cell>
                            <xsl:variable name="credits" select="wea:getBiblRolesFromPers(xs:string(@xml:id))"/>
                            <xsl:if test="not(empty($credits))">
                                <xsl:sequence select="string-join(distinct-values(for $key in map:keys($credits) return $credits($key)),', ')"/>
                            </xsl:if>
                        </cell>
                        <cell><xsl:sequence select="note/node()"/></cell>
                    </row>
                </xsl:for-each>
            </table>
        </div>
        
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='statistics_content']" mode="original">
        <xsl:variable name="texts" select="$sourceXml//TEI[not(descendant::catRef[matches(@target,'bornDigital','i')])]"/>
        <xsl:variable name="TOTAL_KEY" select="'Texts in archive '" as="xs:string"/>
        <xsl:variable name="TRANSCRIBED_KEY" select="'Transcribed texts'" as="xs:string"/>
        <xsl:variable name="TOTAL_WORDS_KEY" select="'Words transcribed'" as="xs:string"/>
        <xsl:variable name="WEDA_KEY" select="'Texts inherited from WEDA'" as="xs:string"/>
        <xsl:variable name="KEYS" 
            select="$TOTAL_KEY, $TRANSCRIBED_KEY, $WEDA_KEY, $TOTAL_WORDS_KEY" as="xs:string+"/>
        <xsl:iterate select="$texts">
            <xsl:param name="stats" as="map(xs:string, xs:integer)"
                select="map{
                    $TOTAL_KEY: 0,
                    $TRANSCRIBED_KEY: 0,
                    $TOTAL_WORDS_KEY: 0,
                    $WEDA_KEY: 0
                }"/>
            
            <xsl:on-completion>
                <table>
                    <xsl:for-each select="$KEYS">
                        <row>
                            <cell role="label">
                                <xsl:value-of select="."/>
                            </cell>
                            <cell>
                                <xsl:value-of select="$stats(.)"/>
                            </cell>
                        </row>
                    </xsl:for-each>
                </table>
                <table>
                    <xsl:for-each select="map:keys($stats)[not(. = $KEYS)]">
                        <xsl:sort select="."/>
                        <xsl:sort select="string-length(.)"/>
                        <row>
                            <cell role="label">
                                <xsl:value-of select="."/>
                            </cell>
                            <cell>
                                <xsl:value-of select="$stats(.)"/>
                            </cell>
                        </row>
                    </xsl:for-each>
                </table>
            </xsl:on-completion>
           
            <xsl:variable name="newMap" as="map(*)">
                <xsl:map>
                    <xsl:map-entry key="$TOTAL_KEY" select="$stats($TOTAL_KEY) + 1"/>
                    <xsl:map-entry key="$TRANSCRIBED_KEY" select="$stats($TRANSCRIBED_KEY) + xs:integer(not(descendant::gap[@reason='noTranscriptionAvailable']))"/>
                    <xsl:map-entry key="$TOTAL_WORDS_KEY" select="$stats($TOTAL_WORDS_KEY) + wea:getWordCount(descendant::text)"/>
                    <!--We know a text precedes the WEA is there's a change statement that precedes the 2010-->
                    <xsl:map-entry key="$WEDA_KEY" select="$stats($WEDA_KEY) + xs:integer(exists(//change[matches(@when,'^200\d-')]))"/>
                    <xsl:for-each select="distinct-values(//catRef/@target) ! xs:string(.)">
                        <xsl:map-entry key="." select="(map:get($stats, .), 0)[1] + 1"/>
                    </xsl:for-each>
                </xsl:map>
            </xsl:variable>
            <xsl:next-iteration>
                <xsl:with-param name="stats"
                    as="map(xs:string, xs:integer)"
                    select="map:merge(($newMap, $stats))"/>
            </xsl:next-iteration>
            
        </xsl:iterate>
        
        
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='we_bibliography_content']" mode="original">
        <xsl:call-template name="createWEBibl"/>
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='resources_content']" mode="original">
        <xsl:call-template name="createResourcesBibl"/>
    </xsl:template>
    
    <xsl:template match="body[ancestor::TEI/@xml:id='media']" mode="original">
        <body>
            <head>Media Gallery</head>
            <div type="listFigure">
                <xsl:for-each select="uri-collection($outDir || '/media?select=*')">
                    <xsl:if test="matches(.,'\.(tiff?|png|jpe?g|bmp)$','i')">
                        <figure xml:id="fig{position()}" type="generated">
                            <graphic url="media:{substring-after(.,'media/')}" mimeType="image/png">
                                <desc><xsl:value-of select="substring-after(.,'media/')"/></desc>
                            </graphic>
                        </figure>
                    </xsl:if>
                </xsl:for-each>
            </div>
        </body>
        
    </xsl:template>
    
    
    <!--Clean up empty names in the respStmts-->
    <xsl:template match="respStmt/name[@ref][string(.)='']" mode="original">
        <xsl:variable name="thisRef" select="@ref"/>
        <xsl:variable name="thisPerson" select="wea:getPerson($thisRef)"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:sequence select="$thisPerson/persName/reg/node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--Get the content from the copyOf bibl...-->
  <!--  <xsl:template match="bibl[@copyOf]" mode="original">
        <xsl:variable name="thisBiblPointer" select="substring-after(@copyOf,'bibl:')"/>
        <xsl:variable name="thisBiblId" select="concat('bibl',$thisBiblPointer)"/>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:variable name="thisBibl" select="$sourceXml[//TEI/@xml:id='bibliography']//bibl[@xml:id=$thisBiblId]" as="item()+"/>
            <xsl:apply-templates select="$thisBibl/node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>-->
    
    
    <xsl:template match="item[@corresp]" mode="original">
        <xsl:variable name="thisCorresp" select="@corresp"/>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="original"/>
            <xsl:choose>
                <!--We're pointing to a category reference-->
                <xsl:when test="starts-with($thisCorresp,'wdt:')">
                    <xsl:variable name="catId" select="substring-after($thisCorresp,'wdt:')"/>
                    <ref target="{$catId}.xml"><xsl:sequence select="$sourceXml//category[@xml:id=$catId]/catDesc/term/node()"/></ref>
                </xsl:when>
                <xsl:when test="starts-with($thisCorresp,'doc:')">
                    <xsl:variable name="docId" select="substring-after($thisCorresp,'doc:')"/>
                    <xsl:variable name="thisDoc" select="$sourceXml//TEI[@xml:id=$docId]"/>
                    <xsl:variable name="docTitle" select="$thisDoc//teiHeader/fileDesc/titleStmt/title[1]" as="element(title)"/>
                    <ref target="doc:{$docId}">
                        <graphic url="{$thisDoc//text/@facs}">
                            <desc><xsl:value-of select="normalize-space($docTitle)"/></desc>
                        </graphic>
                    </ref>

                    <label><ref target="{$thisCorresp}"><xsl:sequence select="$docTitle/node()"/></ref></label>
                    <note>
                        <xsl:if test="$thisDoc//abstract">
                            <xsl:apply-templates select="$thisDoc//abstract/p/node()"/>
                            <ptr type="readMore" target="{$thisCorresp}"/>
                            <!--Now add the abstract respbyline-->
                            <xsl:copy-of select="wea:returnHeadnoteByline($thisDoc//abstract)"/>
                        </xsl:if>
                      
                    </note>
                </xsl:when>
            </xsl:choose>
            
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="notesStmt[not(ancestor::biblFull)]" mode="original">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <xsl:if test="ancestor::TEI/descendant::sourceDesc[biblFull]">
                <xsl:call-template name="addSourceDescNote"/>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <!--Add an msIdentifier-->
    <xsl:template match="msDesc[not(msIdentifier)]" mode="original">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <msIdentifier>
                <repository>Winnifred Eaton Archive</repository>
                <idno><xsl:value-of select="ancestor::TEI/@xml:id"/></idno>
            </msIdentifier>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
        
    </xsl:template>
    
    
    <xsl:template match="publicationStmt[not(ancestor::biblFull)][not(following-sibling::notesStmt)]" mode="original">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
        <xsl:if test="ancestor::TEI/descendant::sourceDesc[biblFull]">
            <notesStmt>
                <xsl:call-template name="addSourceDescNote"/>
            </notesStmt>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="publicationStmt/p" mode="original">
        <p>See the <ref target="doc:legal">legal</ref> page for information about republication. The recommended citation for this document can be found below (in the standalone XML version).</p>
    </xsl:template>
    
    <!--Refresh the encoding Desc if necessary-->
    <xsl:template match="encodingDesc" mode="original">
        <xsl:if test="wea:bornDigital(ancestor::TEI)">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()" mode="#current"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="revisionDesc" mode="original">
        <xsl:if test="not(wea:bornDigital(ancestor::TEI))">
            <encodingDesc>
                <p>See <ref target="doc:editorial_principles">Editorial Principles</ref>.</p>               
            </encodingDesc>
        </xsl:if>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="name[@ref='pers:WE1'][ancestor::body][not(ancestor::note)]" mode="original">
        <xsl:copy>
            <xsl:if test="ancestor::TEI/descendant::catRef[contains(@target,'docPrimarySource')]">
                <xsl:attribute name="key" select="wea:makePseudo(.)"/>
            </xsl:if>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    

  
    
    <xsl:template name="addSourceDescNote">
        <note>This document is a remediation of an earlier TEI encoded file, generously provided by <xsl:value-of select="ancestor::TEI/descendant::sourceDesc/biblFull/descendant::publisher[1]"/>. Please see the source <ref target="xml/original/{ancestor::TEI/@xml:id}.xml">XML</ref> for full licensing and source details.</note>
        
    </xsl:template>
    
    
    <!--Now some additional hadnling for respStmts-->
    
    <xsl:template match="titleStmt[ancestor::TEI/descendant::abstract[@resp]]" mode="original">
        <xsl:variable name="abstract" select="ancestor::TEI/descendant::abstract" as="element(abstract)"/>
        <xsl:variable name="respPtrs" select="$abstract/@resp => tokenize('\s+') => distinct-values()" as="xs:string+"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <xsl:for-each select="$respPtrs">
                <xsl:variable name="thisPtr" select="."/>
                <xsl:variable name="thisPerson" select="wea:getPerson(.)"/>
                <respStmt>
                    <xsl:attribute name="xml:id" select="$abstract/ancestor::TEI/@xml:id || '_abstractResp_' || substring-after($thisPtr,'pers:')"/>
                    <resp>Author of Headnote</resp>
                    <name ref="{.}"><xsl:value-of select="$thisPerson/persName/reg"/></name>
                </respStmt>
            </xsl:for-each>
          
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="abstract/@resp" mode="original">
        <xsl:variable name="root" select="ancestor::TEI"/>
        <xsl:variable name="ptrs" select="tokenize(.,'\s+') => distinct-values()"/>
        <xsl:attribute name="resp" 
            select="
            for $p
            in $ptrs 
            return concat('#',$root/@xml:id,'_abstractResp_',substring-after($p,'pers:')) 
            => string-join(' ')"/>
    </xsl:template>
    
    <!--This function gets a person from the personography from our encoding-->
    <xsl:function name="wea:getPerson">
        <xsl:param name="ptr"/>
        <xsl:variable name="id" select="replace($ptr,'^pers:','')" as="xs:string"/>
        <xsl:sequence select="$sourceXml//TEI[@xml:id='people']/descendant::person[@xml:id=$id]"/>
    </xsl:function>
    
    
    <xsl:template match="@*|node()" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>