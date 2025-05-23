<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet contains all of the templates for creating the "appendix" content (bibliographies, editorial notes, lists of people, et cetera). Many of these templates end up calling the templates in mode="tei," which are in the main templates module.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <!--First, let's construct a map for all of these people and orgs so that we only need to process their actual inner contents once-->
    <xsl:variable name="personMap" as="map(xs:string, element(xh:div))">
        <xsl:map>
            <xsl:for-each select="$standaloneXml//TEI[@xml:id='people']/descendant::person[@xml:id]">
                <xsl:map-entry key="xs:string(@xml:id)">
                    <xsl:apply-templates select="." mode="popup"/>
                </xsl:map-entry>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <xsl:variable name="orgMap" as="map(xs:string, element(xh:div))">
        <xsl:map>
            <xsl:for-each select="$standaloneXml//TEI[@xml:id='organizations']/descendant::org[@xml:id]">
                <xsl:map-entry key="xs:string(@xml:id)">
                    <xsl:apply-templates select="." mode="popup"/>
                </xsl:map-entry>
            </xsl:for-each>
        </xsl:map>

    </xsl:variable>
    
    <xsl:template match="person" mode="popup">
        <xsl:variable name="thisId" select="@xml:id"/>
        <xsl:variable name="thisResp" select="@resp"/>
        <xsl:variable name="thisStandaloneDoc" select="$standaloneXml//TEI[@xml:id=$thisId]" as="element(TEI)"/>
        <xsl:variable name="thisCreditsTable" select="$thisStandaloneDoc//table" as="element(table)?"/>
        <xsl:variable name="isWinnifred" select="@xml:id ='WE1'" as="xs:boolean"/>
        <div id="{@xml:id}">
            <h3><a href="{if ($isWinnifred) then 'timeline' else @xml:id}.html"><xsl:apply-templates select="persName/reg/node()" mode="tei"/></a></h3>
            <xsl:if test="birth or death">
                <div class="personMeta">
                    <ul>
                        <xsl:if test="birth">
                            <xsl:variable name="when" select="birth/@when" as="xs:string"/>
                            <xsl:variable name="formatted" select="wea:formatPersonDate($when)|| (if (birth/@cert = 'low') then '?' else ())"/>
                            <li>Born: <xsl:value-of select="$formatted"/></li>
                        </xsl:if>
                        <xsl:if test="death">
                            <xsl:variable name="when" select="death/@when" as="xs:string"/>
                            <xsl:variable name="formatted" select="wea:formatPersonDate($when)|| (if (death/@cert = 'low') then '?' else ())"/>
                            <li>Died: <xsl:value-of select="$formatted"/></li>
                        </xsl:if>
                    </ul>
                </div>
            </xsl:if>
            <xsl:if test="exists(note/p)">
                <div>
<!--                    <h4>Note</h4>-->
                    <xsl:apply-templates select="note/p" mode="tei"/>
                </div>
                <xsl:sequence select="wea:makePopupResp(xs:string($thisResp))"/>
            </xsl:if>
            <xsl:if test="not($isWinnifred) and exists($thisCreditsTable)">
                <div class="popupCredits">
                    <xsl:for-each-group select="$thisCreditsTable//row[not(@role='label')]" group-by="cell[last()]/list/item/text()">
                        <xsl:sort select="count(current-group())" order="descending"/>
                        <div>
                            <h4><xsl:value-of select="current-grouping-key()"/></h4>
                            <ul>
                                <xsl:sequence select="wea:makeTruncatedList(current-group(), $thisId)"/>
                            </ul>
                        </div>
                    </xsl:for-each-group>
                </div>
              
                
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="org" mode="popup">
        <xsl:variable name="thisId" select="@xml:id"/>
        <xsl:variable name="thisStandaloneDoc" select="$standaloneXml//TEI[@xml:id=$thisId]" as="element(TEI)"/>
        <xsl:variable name="thisCreditsTable" select="$thisStandaloneDoc//table" as="element(table)?"/>
        <xsl:variable name="isWinnifred" select="@xml:id ='WE1'" as="xs:boolean"/>
        <div id="{@xml:id}">
            <h3><a href="{@xml:id}.html"><xsl:apply-templates select="orgName/node()" mode="tei"/></a></h3>
            <xsl:if test="exists(note/p)">
                <div>
                    <xsl:apply-templates select="note/p" mode="tei"/>
                </div>
                <xsl:sequence select="wea:makePopupResp(xs:string(@resp))"/>
            </xsl:if>

            <xsl:if test="not($isWinnifred) and exists($thisCreditsTable)">
                <div>
                    <h4>Published</h4>
                    <div>
                        <ul>
                            <xsl:sequence select="wea:makeTruncatedList($thisCreditsTable//row[not(@role='label')], $thisId)"/>
                        </ul>
                    </div>
                </div>
            </xsl:if>
        </div>
    </xsl:template>
    
    
    <xsl:function name="wea:makePopupResp" new-each-time="no" as="element()*">
        <xsl:param name="thisResp" as="xs:string?"/>
        <xsl:if test="$thisResp">
            <xsl:variable name="respTokens" select="tokenize($thisResp)"/>
            <xsl:variable name="respTokenCount" select="count($respTokens)"/>
            <xsl:variable name="tmp" as="element(tei:ab)">
                <tei:ab type="headnote_byline">Written by<xsl:text> </xsl:text>
                    <xsl:for-each select="tokenize($thisResp)">
                        <xsl:variable name="respToken" select="." as="xs:string"/>
                        <xsl:variable name="thisPerson" 
                            select="$personography/descendant::person[@xml:id = substring-after($respToken,'#')]" 
                            as="element(person)"/>
                        <tei:name ref="{$respToken}">
                            <xsl:sequence
                                select="$thisPerson/persName/reg/node()"/>
                        </tei:name>
                        <xsl:choose>
                            <xsl:when test="count($respTokens) = 1"/>
                            <xsl:when test="count($respTokens) = 2 and position() = 1">
                                <xsl:text> and </xsl:text>
                            </xsl:when>
                            <xsl:when test="count($respTokens) gt 2 and position() lt ($respTokenCount - 1)">
                                <xsl:text>, </xsl:text>
                            </xsl:when>
                            <xsl:when test="count($respTokens) gt 2 and position() = ($respTokenCount - 1)">
                                <xsl:text>, and </xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </tei:ab>
            </xsl:variable>
            <xsl:apply-templates select="$tmp" mode="tei"/>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="wea:makeTruncatedList" as="element(xh:li)*">
        <xsl:param name="rows"/>
        <xsl:param name="id"/>
        <xsl:variable name="max" select="6"/>
        <xsl:variable name="rowCount" select="count($rows)"/>
        
        <xsl:variable name="rowsToUse" select="$rows[not(wea:getRefFromRow(.)[substring-before(@target,'.xml') = $id])]"/>
        <xsl:for-each select="$rowsToUse[position() lt $max + 1]">
            <li><xsl:apply-templates select="wea:getRefFromRow(.)" mode="tei"/></li>
        </xsl:for-each>
        <xsl:if test="$rowCount gt $max">
            <li><a href="{$id}.html">+ <xsl:value-of select="$rowCount - $max"/></a></li>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="wea:getRefFromRow" as="element(tei:ref)">
        <xsl:param name="row"/>
        <xsl:sequence select="$row/cell[ref[not(descendant::graphic)]]/ref"/>
    </xsl:function>
    
    
    <xsl:function name="wea:formatPersonDate" as="xs:string">
        <xsl:param name="date" as="xs:string"/>
        <xsl:variable name="dateTokens" select="tokenize($date,'-')"/>
        <xsl:variable name="count" select="count($dateTokens)"/>
        <xsl:choose>
            <xsl:when test="$count = 3">
                <xsl:sequence select="format-date(xs:date($date), '[MNn] [D00], [Y0000]')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="expanded" select="wea:expandDate($date)"/>
                <xsl:choose>
                    <xsl:when test="$count = 2">
                        <xsl:sequence select="format-date(xs:date($date),'[MNn] [Y0000]')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="$date"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:function>
    
    
    
    <xsl:template match="note[@type='editorial']" mode="appendix">
        <xsl:variable name="noteId" select="wea:getNoteId(.)"/>
        <xsl:variable name="noteNum" select="tokenize($noteId,'_')[last()]"/>
        <div>

            <xsl:call-template name="processAtts">
                <xsl:with-param name="id" select="$noteId"/>
            </xsl:call-template>
            <a class="returnToNote" href="#noteMarker_{$noteNum}" title="Return to note {$noteNum}."><xsl:value-of select="$noteNum"/></a>
            <div>
                <xsl:apply-templates mode="tei"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="createAppendix">
        <div id="appendix">
            <xsl:call-template name="createNotes"/>
       
            <div id="feedback">
                <xsl:if test="not(ancestor::TEI/descendant::abstract) and wea:isObject(ancestor::TEI)">
                    
                    <xsl:variable name="contribute_subject">WEA: Headnote for <xsl:value-of select="string-join(ancestor::TEI/teiHeader/fileDesc/titleStmt/title[1]/descendant::text(),'')"/> (<xsl:value-of select="ancestor::TEI/@xml:id"/>)</xsl:variable>
                    <div>
                        <h4>Contribute</h4>
                        <div data-el="p">If you'd like to write a headnote for this text (that would be peer-reviewed before publication), 
                            please <a href="mailto:mary.chapman@ubc.ca,winnifredeatonarchive@gmail.com?subject={encode-for-uri($contribute_subject)}">contact the Project Director Mary Chapman</a> to discuss.</div>
                    </div>
                </xsl:if>
                
                <div>
                    <xsl:variable name="feedback_subject">WEA Feedback: <xsl:value-of select="string-join(ancestor::TEI/teiHeader/fileDesc/titleStmt/title[1]/descendant::text(),'')"/> (<xsl:value-of select="ancestor::TEI/@xml:id"/>)</xsl:variable>
                    <xsl:variable name="feedback_body">[If you are reporting a bug or other technical issue, please provide as much detail as possible.]</xsl:variable>
                    <h4>Technical Feedback</h4>
                    <p>If you have noticed a bug, typo, or errors on the site or if you have any other feedback, please <a href="{wea:makeEmail($feedback_subject, $feedback_body)}">contact us</a>.</p>
                </div>

            </div>
            
            <xsl:apply-templates select="ancestor::TEI/text[@type='standoff']" mode="appendix">
                <xsl:with-param name="rootDoc" select="ancestor::TEI" tunnel="yes"/>
            </xsl:apply-templates>
            
          <xsl:call-template name="createStatusAppendix"/>
        </div>
    </xsl:template>
    
    <xsl:template name="createStatusAppendix">
        <xsl:variable name="revisionDesc" as="element(revisionDesc)"
            select="ancestor::TEI//revisionDesc"/>
        <xsl:variable name="currStatus" select="$revisionDesc/@status" as="xs:string"/>
        <div id="status">
            <dl>
            <xsl:for-each select="reverse($taxonomies//taxonomy[@xml:id='docStatusTaxonomy']/category)">
                <xsl:variable name="current" select="@xml:id = ('status_' || $currStatus)" as="xs:boolean"/>
                <dt class="metadataLabel{if ($current) then ' current' else ()}">
                    <xsl:value-of select="catDesc/term"/>
                </dt>
                <dd>
                    <xsl:if test="$current">
                        <xsl:attribute name="class" select="'current'"/>
                    </xsl:if>
                    <xsl:apply-templates select="catDesc/note/p" mode="tei"/>
                </dd>
            </xsl:for-each>
            </dl>
            <div class="rev_history">
                <h5>Full Revision History</h5>
                <xsl:apply-templates select="ancestor::TEI//revisionDesc" mode="appendix"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="revisionDesc" mode="appendix">
        <xsl:variable name="tempTable" as="element(tei:table)">
            <tei:table>
               <!-- <tei:row role="label">
                    <tei:cell>Who</tei:cell>
                    <tei:cell>When</tei:cell>
                    <tei:cell>Status</tei:cell>
                    <tei:cell>Description</tei:cell>
                </tei:row>-->
                <xsl:apply-templates select="change" mode="#current"/>
            </tei:table>
        </xsl:variable>
        <xsl:apply-templates select="$tempTable" mode="tei">
            <xsl:with-param name="isSortable" tunnel="yes" select="false()"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="revisionDesc/change" mode="appendix">
        <xsl:variable name="date" as="element(tei:date)">
            <tei:date>
                <xsl:sequence select="(@when | @notBefore | @notAfter | @from | @to)"/>
            </tei:date>
        </xsl:variable>
        <tei:row>
            <tei:cell><xsl:sequence select="wea:formatDate($date)"/></tei:cell>
            <tei:cell>
                <xsl:for-each select="tokenize(@who,'\s+')">
                    <tei:name ref="{.}"><xsl:value-of select="replace(.,'^#|\d+$','')"/></tei:name>
                    <xsl:if test="position() ne last()">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </tei:cell>
            <tei:cell>
                <xsl:if test="@status">
                    <xsl:value-of select="wea:getCategoryFromStatus(@status)/catDesc/term"/>
                </xsl:if>

            </tei:cell>
            <tei:cell><xsl:sequence select="node()"/></tei:cell>
        </tei:row>
        
    </xsl:template>
    
    
    <xsl:function name="wea:makeEmail">
        <xsl:param name="subject"/>
        <xsl:param name="body"/>
        <xsl:sequence select="'mailto:mary.chapman@ubc.ca,joey.takeda@gmail.com?subject=' || encode-for-uri($subject) || '&amp;body=' || encode-for-uri($body)"/>
    </xsl:function>
    <xsl:template match="listBibl" mode="appendix">
       <xsl:where-populated>
           <div>
               <xsl:on-non-empty>
                   <xsl:call-template name="processAtts">
                       <xsl:with-param name="id" select="'works_cited'"/>
                   </xsl:call-template>
                   <h2>Works Cited</h2>
               </xsl:on-non-empty>
               <xsl:for-each select="bibl">
                   <xsl:variable name="id" select="@xml:id" as="xs:string"/>
                   <xsl:if test="ancestor::TEI/descendant::*[not(ancestor::teiHeader)][@*[contains-token(., ('#' || $id))]]">
                       <xsl:apply-templates select="." mode="tei"/>
                   </xsl:if>
               </xsl:for-each>
 
           </div>
           
       </xsl:where-populated> 

    </xsl:template>
    
    <xsl:template match="listPerson" mode="appendix">
        <div>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="id" select="'personography'"/>
            </xsl:call-template>
            <h2>People Mentioned</h2>
            <xsl:apply-templates select="person" mode="appendix"/>
        </div>
    </xsl:template>
    
    <xsl:template match="listOrg" mode="appendix">
        <div>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="id" select="'organizations'"/>
            </xsl:call-template>
            <h2>Organizations Mentioned</h2>
            <xsl:apply-templates select="org" mode="appendix"/>
        </div>
    </xsl:template>
    
    <xsl:template match="org" mode="appendix">
        <xsl:try>
            <xsl:apply-templates select="$orgMap(xs:string(@xml:id))" mode="localize"/>
            <xsl:catch>
                <xsl:message terminate="yes">
                    ERROR: <xsl:sequence select="."/>
                </xsl:message>
            </xsl:catch>
        </xsl:try>

    </xsl:template>
    
    <xsl:template match="person" mode="appendix">
        
       <xsl:apply-templates select="$personMap(xs:string(@xml:id))" mode="localize"/>
    </xsl:template>
    
    <!--Catch any non-local links-->
    <xsl:template match="xh:a/@href[matches(.,'^#')]" mode="localize">
        <xsl:param name="rootDoc" as="element(TEI)" tunnel="yes"/>
        <xsl:variable name="id" select="substring-after(.,'#')"/>
        <xsl:attribute name="href">
            <xsl:choose>
                <xsl:when test="$rootDoc//*[@xml:id]/@xml:id = $id">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$id || '.html'"/>
                </xsl:otherwise>
            </xsl:choose>  
        </xsl:attribute>
    </xsl:template>
    
    <!--Identity transform for the localization of the already processed popup-->
    <xsl:template match="@*|node()" priority="-1" mode="localize">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="person[@xml:id = 'WE1']" mode="appendix">
        <xsl:variable name="thisFrag" select="$personMap(xs:string(@xml:id))"/>
        <xsl:variable name="root" select="ancestor::TEI"/>
        <xsl:variable name="pseudos" select="$root//name[@key]" as="element(name)*"/>
        <xsl:variable name="distinctPseudos" select="distinct-values($pseudos/@key)" as="xs:string*"/>
        <xsl:for-each select="$thisFrag">
            <xsl:copy>
                <xsl:sequence select="@*|node()"/>
                <xsl:if test="not(empty($pseudos))">
                    <div class="popupPseudonyms">
                        <h4>Pseudonym<xsl:if test="count($distinctPseudos) gt 1">s</xsl:if> used in this text</h4>
                        <ul>
                            <xsl:for-each-group select="$pseudos" group-by="@key">
                                <li><a href="search.html?Pseudonym={encode-for-uri(@key)}"><xsl:value-of select="current-grouping-key()"/></a></li>
                            </xsl:for-each-group>
                        </ul>
                    </div>
                </xsl:if>
            </xsl:copy>
        </xsl:for-each>
    </xsl:template>
    

    
    
    
    <xsl:template name="createNotes">
        <xsl:if test="//note[@type='editorial']">
            <div id="notes">
                <h2>Notes</h2>
                <xsl:apply-templates select="//note[@type='editorial']" mode="appendix"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="createFacsView">
        <div id="facsViewerContainer">
            <span id="facs_closer" class="mi">close</span>
            
            <div id="facs_loader">
                <div class="loader">Loading</div>
            </div>
            <canvas id="viewer"/>
        </div>        

    </xsl:template>
    
    <xsl:template name="createPopup">
        <div id="popup" class="hidden" aria-hidden="true">
            <div class="popup_container">
                <div id="popup_closer">X</div>
                <div id="popup_content"/>
            </div>
        </div>
    </xsl:template>
    
    <!--A simple template to create an empty div that is
        the overlay-->
    <xsl:template name="createOverlay">
        <div id="overlay" class="hidden" aria-hidden="true"/>
    </xsl:template>
    
    
    
</xsl:stylesheet>