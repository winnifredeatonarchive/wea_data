<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns:teix="http://www.tei-c.org/ns/Examples"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet contains all of the basic templates for transforming the TEI into HTML.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:attribute-set name="newTabLink">
        <xsl:attribute name="rel">noopener noreferrer</xsl:attribute>
        <xsl:attribute name="target">_blank</xsl:attribute>
    </xsl:attribute-set>

    
  
    

    
    <xsl:template match="TEI" mode="tei">
        <xsl:message>Processing <xsl:value-of select="@xml:id"/></xsl:message>
 
            <html lang="en">

                <xsl:call-template name="processAtts"/>
                <!--Add the XMLNs-->
                <xsl:call-template name="addNamespaces"/>
                <xsl:call-template name="createHeadMetadata"/>
                <xsl:apply-templates mode="#current"/>
            </html>
        
    </xsl:template>
    
  
    
    <!--Deleted from the regular flow-->
    <xsl:template match="text[@type='standoff'] | teiHeader" mode="tei"/>
    
    
    <xsl:template match="text[not(@type='standoff')][not(ancestor::floatingText)]" mode="tei">
      
        <body>
            <xsl:call-template name="createNav"/>
            <div id="mainBody">
                <xsl:attribute name="class" select="string-join(for $n in //catRef/@target return substring-after($n,'#'),' ')"/>
                <xsl:choose>
                    <xsl:when test="ancestor::TEI/@xml:id='index'">
                        <xsl:call-template name="createIndexPage"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="createInfo"/>
                        <div id="text_container">
                            <xsl:call-template name="createToolbar"/>
                            <div id="text">
                                <xsl:call-template name="processAtts"/>
                                <xsl:apply-templates mode="#current"/>
                                <xsl:call-template name="createSearchResults"/>
                            </div>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:call-template name="createAppendix"/>
            </div>
            <xsl:call-template name="createPopup"/>
            <xsl:if test="//graphic">
                <xsl:call-template name="createFacsView"/>
            </xsl:if>

           <xsl:call-template name="createFooter"/>
        </body>
    </xsl:template>
    
  
    
    <!--Generic block level element templates-->
    <xsl:template match="ab | body | div | p | lg | l | byline | opener | closer | item | person/note | note[p] | listBibl | sp" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    
    <!--Special handling for ab[@type-'headnote_byline'] since it occurs in a span-->
    <xsl:template match="ab[@type='headnote_byline']" mode="tei">
        <span>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <!--We delete the exhibit info div, since it gets processed out of the regular flow-->
    <xsl:template match="div[@type='exhibitInfo']" mode="tei"/>
    
    <!--Special template for handling events-->
    <xsl:template match="listEvent" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates select="event" mode="#current">
                <xsl:sort select="@when" order="ascending"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    

    <xsl:template match="event[@when]" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <!--Annoyingly, we have to hack the processing so that
                it looks like we have a label *and* a paragraph, which
                isn't TEI compliant, but doesn't matter in the HTML-->
            <div data-el="label"><xsl:value-of select="@when"/></div>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="list" mode="tei">
        <ul>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="list/item" mode="tei">
        <li>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </li>
    </xsl:template>
    
    
    <xsl:template match="bibl" mode="tei">
        <div>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes" select="'bibl'"/>
            </xsl:call-template>
            <xsl:apply-templates mode='#current'/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[head][not(ancestor::floatingText)][not(@xml:id)]" mode="tei">
        <div>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="id" select="generate-id(.)"/>
            </xsl:call-template>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="list[@xml:id='menu_main']/item[@corresp]">
        <li>
            <xsl:call-template name="processAtts"/>
            <a href="{replace(@corresp,'.xml','.html')}"><xsl:apply-templates select="$standaloneXml//category[@xml:id=substring-before(@corresp,'.xml')]/catDesc/term/node()" mode="#current"/></a>
        </li>
    </xsl:template>
    
    
    

    
    <xsl:template match="head" mode="tei">
        <xsl:variable name="nestLevel" select="count(ancestor::div)+1"/>
        <xsl:element name="{concat('h',$nestLevel)}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
        <xsl:if test="parent::body and count(following-sibling::head) = 0 and not(wea:isObject(ancestor::TEI)) and not(ancestor::TEI/descendant::catRef[contains(@target,'Listing')]) and not(ancestor::TEI/@xml:id = $personography//person/@xml:id)">
            <div id="info">
                <xsl:call-template name="createTOC"/>
                <xsl:call-template name="createCreditsAndCitations"/>
            </div>
            
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="div[@type='listFigure']/figure" mode="tei">
        <xsl:variable name="ext" select="tokenize(graphic/@mimeType,'/')[last()]"/>
        <xsl:variable name="href" select="replace(graphic/@url,'_sm.png$',concat('.',$ext))"/>
<!--        <div>-->

            <div>
                <xsl:call-template name="processAtts"/>
                <xsl:apply-templates select="head" mode="tei"/>

                <figure class="thumb">
                    <xsl:apply-templates select="graphic" mode="tei"/>
                    
                </figure>
                <xsl:variable name="tempP">
                    <tei:p>
                        <xsl:copy-of select="figDesc/node()"/>
                    </tei:p>
                </xsl:variable>
                
                <xsl:apply-templates select="$tempP" mode="#current"/>
            </div>
            <!--FIRST MAKE THE IMAGE-->
            
            
           <!--<div class="expandable">
               <div class="content">
                  <!-\- <xsl:if test="listPerson">
                       <div>
                           <h3>Subjects</h3>
                           <xsl:variable name="tempList">
                               
                               <tei:list>
                                   <xsl:for-each select="listPerson/person">
                                       <xsl:variable name="ptr" select="substring-after(@corresp,'#')"/>
                                       <xsl:variable name="thisPerson" select="ancestor::TEI//person[@xml:id=$ptr]"/>
                                       <tei:item>
                                           <tei:name ref="{@corresp}"><xsl:copy-of select="$thisPerson/persName/reg/node()"/></tei:name>
                                       </tei:item>
                                   </xsl:for-each>
                               </tei:list>
                           </xsl:variable>
                           
                           <xsl:apply-templates select="$tempList" mode="#current"/>
                       </div>
                   </xsl:if>-\->
               </div>
                
            </div>-->
        <!--</div>-->
    </xsl:template>
    
    
    <!--Generic inline-->
    <xsl:template match="hi | seg | foreign | note | title[@level=('m','j','s')] | milestone[@unit='sectionBreak'] | emph | date | speaker | label" mode="tei">
        <span>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    
    
    <xsl:template match="seg[@type='currentRevision']" mode="tei">
        
    </xsl:template>
        
    <xsl:template match="note[@type='authorial']" mode="tei">
        <span>
           <xsl:call-template name="processAtts">
               <xsl:with-param name="classes">showTitle</xsl:with-param>
           </xsl:call-template>
            <xsl:attribute name="title">This is an authorial note.</xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="table" mode="tei">
        
        <xsl:choose>
            <xsl:when test="ancestor::TEI[descendant::catRef/@target[contains(.,'Documentation')]] or count(row) = 1">
                <table>
                    <xsl:apply-templates mode="#current"/>
                </table>
            </xsl:when>
            <xsl:otherwise>
                <table>
                    <xsl:choose>
                        <xsl:when test="row[1][@role='label']">
                            
                            <xsl:variable name="maxCols" select="max(for $n in row[not(@role='label')] return count($n/cell))"/>
                            
                            <xsl:variable name="colMap" as="map(xs:integer, xs:string)">
                                <xsl:map>
                                    <xsl:for-each-group select="row[not(@role='label')]/cell" group-by="count(preceding-sibling::cell)">
                                        <xsl:variable name="colNum" select="current-grouping-key()+1" as="xs:integer"/>
                                        <xsl:variable name="type" as="xs:string">
                                            <xsl:choose>
                                                <xsl:when test="not(empty(current-group()[date])) and (every $v in current-group() satisfies ($v[date] or normalize-space(string-join($v,''))=''))">date</xsl:when>
                                                <xsl:when test="every $v in current-group() satisfies matches(normalize-space(string-join($v,'')),'^\d+(.\d+)?$')">float</xsl:when>
                                                <xsl:otherwise>string</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>
                                        
                                        <xsl:map-entry key="$colNum" select="$type"/>
                                    </xsl:for-each-group>
                                </xsl:map>
                            </xsl:variable>
                            
                            
                            <xsl:variable name="cellMap" as="map(xs:string, xs:integer+)">
                                <xsl:map>
                                    <xsl:for-each-group select="row[not(@role='label')]/cell" group-by="count(preceding-sibling::cell)">
                                        <xsl:variable name="colNumber" select="current-grouping-key()+1"/>
                                        <xsl:variable name="colType" select="$colMap($colNumber)"/>
                                        <xsl:for-each select="current-group()">
                                            <xsl:sort select="
                                                if ($colType='date') then (if (date[@*]) then (date/@when | date/@notBefore | date/@from) else '9000') (: If it's a date, use the @when :)
                                                else if ($colType='float') then xs:float(.) (:If it's a float, use that :)
                                                else wea:makeTitleSortKey(normalize-space(string-join(descendant::text()[not(ancestor::note)]))) (:Otherwise, use the string:)
                                                "/>
                                            <!--We'll want a better sorting key mechanism here-->
                                            <xsl:variable name="pos" select="position()"/>
                                            <xsl:map-entry key="generate-id(.)" select="($colNumber, $pos)"/>
                                        </xsl:for-each>
                                    </xsl:for-each-group>
                                </xsl:map>
                            </xsl:variable>
                            
                            <xsl:call-template name="processAtts">
                                <xsl:with-param name="classes" select="'sortable'"/>
                            </xsl:call-template>
                            
                            
                            <xsl:variable name="labelRow" select="row[1][@role='label']"/>
                            
                            
                            
                            <xsl:variable name="firstDateCol" 
                                select="for $r in (1 to $maxCols) return if ($colMap($r) ='date') then $r else ()"/>
                            
                            <xsl:variable name="firstToSortBy" as="xs:integer">
                                <xsl:choose>
                                    <xsl:when test="row[@role='label']/cell[@role='sortkey']">
                                        <xsl:value-of select="count(row[@role='label']/cell[@role='sortkey'][1]/preceding-sibling::cell) + 1"/>
                                    </xsl:when>
                                    <xsl:when test="not(empty($firstDateCol))">
                                        <xsl:value-of select="$firstDateCol"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of
                                            select="
                                            min(for $r 
                                            in (row[1][@role='label']/cell[normalize-space(string-join(descendant::text(),'')) ne '']) 
                                            return count($r/preceding-sibling::cell) + 1)" 
                                        />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            
                            
                            <thead>
                                <xsl:apply-templates select="row[1][@role='label']" mode="#current">
                                    <xsl:with-param name="firstToSortBy" select="$firstToSortBy" tunnel="yes"/>
                                </xsl:apply-templates>
                            </thead>
                            
                            <tbody>
                                <xsl:for-each select="row[position() gt 1]">
                                    <xsl:sort select="$cellMap(generate-id(cell[$firstToSortBy]))[2]"/>
                                    <xsl:apply-templates select="." mode="#current">
                                        <xsl:with-param name="cellMap" select="$cellMap" tunnel="yes"/>
                                    </xsl:apply-templates>
                                </xsl:for-each>
                            </tbody>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="processAtts"/>
                            <tbody>
                                <xsl:apply-templates select="row" mode="#current"/>
                            </tbody>
                        </xsl:otherwise>
                    </xsl:choose>
                </table>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
    <xsl:template match="row[@role='label'][count(preceding-sibling::row) = 0]/cell" mode="tei">
        <xsl:param name="firstToSortBy" tunnel="yes" as="xs:integer?"/>
        <th>
            <xsl:variable name="classes" as="xs:string*">
                <xsl:if test="normalize-space(string-join(descendant::text(),'')) ne ''">
                    <xsl:value-of>sortable</xsl:value-of>
                </xsl:if>
                <xsl:if test="not(empty($firstToSortBy)) and (count(preceding-sibling::cell) + 1 = $firstToSortBy)">
                    <xsl:value-of>selected</xsl:value-of>
                    <xsl:value-of>up</xsl:value-of>
                </xsl:if>
            </xsl:variable>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes" select="string-join($classes,' ')"/>
            </xsl:call-template>
            <xsl:attribute name="data-col" select="count(preceding-sibling::cell)+1"/>
            <xsl:apply-templates mode="#current"/>
        </th>
    </xsl:template>
    
    
    <xsl:template match="row" mode="tei">
        <tr>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </tr>
    </xsl:template>
    
    
    
    <xsl:template match="cell" mode="tei">
        <xsl:param name="cellMap" select="()" tunnel="yes"/>
        <xsl:variable name="entry" select="if (not(empty($cellMap))) then $cellMap(generate-id(.)) else ()"/>
        <td>
            <xsl:call-template name="processAtts"/>
            <xsl:if test="not(empty($cellMap))">
                <xsl:attribute name="data-col" select="$entry[1]"/>
                <xsl:attribute name="data-sort" select="$entry[2]"/>
            </xsl:if>
            
            <xsl:apply-templates mode="#current"/>
        </td>
    </xsl:template>
    

    <!--QUOTATIONS-->
    
    
    <xsl:template match="q[not(descendant::div | descendant::p | descendant::lg | descendant::floatingText)] | title[@level='a']" mode="tei">
        <span>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
            <xsl:if test="following::tei:*|text()[1][self::text()] and matches(following::text()[1], '^[,\.]') and not(child::tei:*[self::q][not(following-sibling::text())]) and (not(ancestor::q) or not(following-sibling::*))">
                <xsl:value-of select="substring(following::text()[1], 1, 1)"/>
            </xsl:if>
        </span>
    </xsl:template>
    
    <xsl:template match="q[descendant::div | descendant::p | descendant::lg | descendant::floatingText]" mode="tei">
        <div>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes" select="'blockquote'"/>
            </xsl:call-template>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    
    
    <xsl:template match="text()[not(parent::q)][preceding::text()[1][ancestor::q or ancestor::title[@level='a']]][matches(., '^[,\.]')]" mode="tei">
        <xsl:value-of select="substring(., 2)"/>
    </xsl:template>
    
    <!--Figures-->
    
    <xsl:template match="figure" mode="tei">
        <figure>
            <xsl:if test="not(graphic)">
                <xsl:attribute name="class" select="'placeholder'"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </figure>
    </xsl:template>
    
    <xsl:template match="graphic" mode="tei">
        <xsl:variable name="url" select="@url"/>
        <xsl:variable name="urlNorm">
            <xsl:choose>
                <xsl:when test="matches($url,'\.pdf$')">
                    <xsl:value-of select="replace($url,'\.pdf$','.jpg')"/>
                </xsl:when>
                <xsl:when test="matches($url,'^media/')">
                    <xsl:value-of 
                        select="replace($url,'^media/','media/small/')
                                => replace('\.[a-zA-Z]+$','.jpg')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$url"/>
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="ancestor::list[@xml:id='featuredItems']">
                <a href="{replace(parent::item/@corresp,'.xml','.html')}">
                    <img src="{$urlNorm}" alt="{if (desc) then normalize-space(string-join(desc)) else normalize-space(string-join(ancestor::figure/figDesc,''))}"/> 
                </a>
            </xsl:when>
            <xsl:otherwise>
                <img src="{$urlNorm}" class="lazy" data-wea-src="{if (matches($url,'\.tiff?','i')) then replace($url,'\.tiff?','.png','i') else $url}" alt="{if (desc) then normalize-space(string-join(desc)) else normalize-space(string-join(ancestor::figure/figDesc,''))}"/>
            </xsl:otherwise>
        </xsl:choose>
       
    </xsl:template>
    
    <xsl:template match="graphic/desc" mode="tei"/>
    
    
    <xsl:template match="gap[@reason='noTranscriptionAvailable']" mode="tei">
        <xsl:variable name="subject">WEA: <xsl:value-of select="ancestor::TEI/teiHeader/fileDesc/titleStmt/title[1]"/> (<xsl:value-of select="ancestor::TEI/@xml:id"/>)</xsl:variable>
        <xsl:variable name="temp" as="element(tei:div)">
            <tei:div type="noTranscriptionAvailable">
                <tei:head>No Transcription Available</tei:head>
                <tei:div>There is no transcription available yet for this item. If you would like to contribute a transcription,
                please contact the <tei:ref target="mailto:mchapman@ubc.ca?subject={encode-for-uri($subject)}">Project Director</tei:ref>.</tei:div>
            </tei:div>
        </xsl:variable>
        <xsl:apply-templates select="$temp" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="supplied | gap" mode="tei">
        <xsl:variable name="leadingSentence">
            <xsl:choose>
                <xsl:when test="self::supplied">
                    <xsl:variable name="thisResp" select="substring-after(@resp,'#')" as="xs:string?"/>
                    
                    <xsl:text>This text has been editorially supplied</xsl:text><xsl:if test="not($thisResp = '')"><xsl:text> by </xsl:text><xsl:value-of select="ancestor::TEI/descendant::person[@xml:id=$thisResp]/persName/reg"/></xsl:if><xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:when test="self::gap">
                    This text has been omitted.
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <span>
            <xsl:attribute name="title">
                <xsl:variable name="title">
                    <xsl:if test="@reason"><xsl:text>Reason: </xsl:text><xsl:value-of select="@reason"/><xsl:text>.</xsl:text></xsl:if>
                    <xsl:if test="@cert"><xsl:text>Certainty: </xsl:text><xsl:value-of select="@cert"/><xsl:text>.</xsl:text></xsl:if>
                </xsl:variable>
                <xsl:value-of select="concat($leadingSentence,' ', string-join($title,' '))"/>
            </xsl:attribute>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes">showTitle</xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    
    
    
    <xsl:template match="ref" mode="tei">
        <a href="{wea:resolveTarget(@target)}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </a>
    </xsl:template>
    
    <xsl:template match="ptr[@type='readMore']" mode="tei">
        <a href="{wea:resolveTarget(@target)}">
         <xsl:call-template name="processAtts"/>
            Read More
        </a>
    </xsl:template>
    
    <xsl:template match="name[not(@ref)][not(ancestor::respStmt)] | name[ancestor::ab[@type='citations']]" mode="tei">
        <span><xsl:apply-templates mode="#current"/></span>
    </xsl:template>
    
    <xsl:template match="name[@ref][not(ancestor::respStmt)][not(ancestor::ab[@type='citations'])] | rs" mode="tei">
        <a href="{@ref}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </a>
    </xsl:template>
    
    <xsl:template match="ref[@type='bibl'][@target]" mode="tei">
        <a href="{@target}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </a>
    </xsl:template>
    
    <xsl:template match="pb" mode="tei">
       <!--This can't really be an hr anymore, since it can't go in <q> (where it appears a lot).-->
        <a href="#{ancestor::TEI/@xml:id}_pg_{@n}">
            <span>
                <xsl:call-template name="processAtts">
                    <xsl:with-param name="classes" select="if (not(preceding::pb)) then 'first' else ()"/>
                </xsl:call-template>
                <xsl:if test="@n">
                    <span class="pbNum" id="{ancestor::TEI/@xml:id}_pg_{@n}">
                        <xsl:value-of select="@n"/>
                    </span>
                </xsl:if>
                <xsl:apply-templates mode="#current"/>
            </span> 
        </a>
        
    </xsl:template>
    
    <xsl:template match="lb" mode="tei">
        <br>
            <xsl:call-template name="processAtts"/>
        </br>
    </xsl:template>
    
    <!--Now janus elements-->
    
    <xsl:template match="choice[orig and reg] | choice[sic and corr]" mode="tei">
        <span title="{normalize-space(if (orig) then orig else sic)} in original">
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes">showTitle</xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="choice[abbr and expan]" mode="tei">
        <span title="{normalize-space(string-join(expan,''))}">
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes">showTitle</xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    
    
    <xsl:template match="choice/orig | choice/sic | choice/expan" mode="tei"/>
    
    <xsl:template match="choice/reg | choice/corr | choice/abbr" mode="tei">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    
    <!--NOTES-->
    
    <xsl:template match="note[@type='editorial']" mode="tei">
        <xsl:variable name="noteId" select="wea:getNoteId(.)"/>
        <xsl:variable name="noteNum" select="tokenize($noteId,'_')[last()]"/>
        <a href="#{$noteId}"  id="noteMarker_{$noteNum}" class="noteMarker" title="{normalize-space(string-join(descendant::text(),''))}">
            <sup><xsl:value-of select="$noteNum"/></sup>
        </a>
    </xsl:template>
    
    <xsl:template match="floatingText" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="signed | salute" mode="tei">
        <span>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    
  
    
    <xsl:template match="person" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <h3><a href="{@xml:id}.html"><xsl:apply-templates select="persName/reg" mode="#current"/></a></h3>
            <xsl:apply-templates select="node()[not(self::persName)][not(self::note[@type='bio'][@subtype='long'])]" mode="#current"/>
        </div>
    </xsl:template>
    
    
    <xsl:template match="org" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <h3><a href="{@xml:id}.html"><xsl:apply-templates select="orgName" mode="#current"/></a></h3>
            <xsl:apply-templates select="node()[not(self::orgName)]" mode="#current"/>
        </div>
    </xsl:template>
    
    

    
    <xsl:template match="divGen[@type='searchBox']" mode="tei">
        <div id="staticSearch"/>
    </xsl:template>
    
    
    
    
    
    <!--**************************************************************
       *                                                            * 
       *                   ATTRIBUTES                               *
       *                                                            *
       **************************************************************-->
    
    <xsl:template match="@xml:id" mode="tei">
        <xsl:attribute name="id" select="."/>
    </xsl:template>
    
    <xsl:template match="@xml:lang" mode="tei">
        <xsl:attribute name="lang" select="."/>
    </xsl:template>
    
    <xsl:template match="@rendition" mode="tei">
        <xsl:param name="classes" as="xs:string*" tunnel="yes"/>
        <xsl:variable name="theseVals" select="translate(.,'#','')"/>
        <xsl:attribute name="class" select="string-join(($classes,$theseVals),' ')"/>
    </xsl:template>
    
    <!--Just copy out style-->
    <xsl:template match="@style" mode="tei">
        <xsl:attribute name="style" select="."/>
    </xsl:template>
    
    <!--We have to handle this for now, but these should probably be @rendition-->
    <xsl:template match="@rend" mode="tei">
        <xsl:variable name="value" as="xs:string?">
            <xsl:choose>
                <xsl:when test=".='center'">text-align:center;</xsl:when>
                <xsl:when test=".='italic'">font-style: italic;</xsl:when>
                <xsl:when test=".='bold'">font-weight: bold;</xsl:when>
                <xsl:when test=".='underline'">text-decoration:underline;</xsl:when>
                <xsl:otherwise>
                    <xsl:message>Rend value <xsl:value-of select="."/> not found.</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="not(empty($value))">
            <xsl:attribute name="style" select="$value"/>
        </xsl:if>
    </xsl:template>
    
    
    <!--By default, delete all attributes from being processed
    as text.-->
    <xsl:template match="@*" priority="-1" mode="tei"/>
    
    <!--**************************************************************
       *                                                            * 
       *                    NAMED TEMPLATE                          *
       *                                                            *
       **************************************************************-->
    
    
    <!--This template is taken from the LEMDO processing model-->
    <xsl:template name="processAtts">
        <xsl:param name="classes" as="xs:string*"/>
        <xsl:param name="id" as="xs:string?"/>
        
        <!--First, create the data-el attribute-->
        <xsl:attribute name="data-el" select="local-name(.)"/>
        
        <!--Now fork and give some warnings (if desired)-->
        <xsl:choose>
            <!--If the class parameter is supplied-->
            <xsl:when test="not(empty($classes))">
                <xsl:if test="$verbose='true'">
                    <xsl:message>Added classes detected: <xsl:value-of select="$classes"/></xsl:message>
                </xsl:if>
                <xsl:choose>
                    <!--They'll be added if there's a rendition declared, so leave it-->
                    <xsl:when test="@rendition">
                        <xsl:if test="$verbose='true'">
                            <xsl:message>Classes to be added to element alongside pre-existing rendition: <xsl:value-of select="@rendition"/></xsl:message>
                        </xsl:if>
                        
                    </xsl:when>
                    <!--Otherwise, create a class attribute-->
                    <xsl:otherwise>
                        <xsl:if test="$verbose='true'">
                            <xsl:message>Classes added to create new class</xsl:message>
                        </xsl:if>
                        
                        <xsl:attribute name="class" select="$classes"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            
            <!--If the id parameter is supplied-->
            <xsl:when test="not(empty($id) or normalize-space($id)='')">
                <xsl:if test="$verbose='true'">
                    <xsl:message>Added id detected: <xsl:value-of select="$id"/></xsl:message>
                </xsl:if>
                
                <!--Break right away if the @xml:id is badly formed-->
                <xsl:if test="matches(normalize-space($id),'^\d+|:|\s+')">
                    <xsl:message terminate="yes">BAD ID: <xsl:value-of select="$id"/></xsl:message>
                </xsl:if>
                <!--If it's fine, then see if there's already an @xml:id on this object-->
                <xsl:choose>
                    <xsl:when test="not(@xml:id)">
                        <!--If there isn't an xml:id, then create an @id-->
                        <xsl:attribute name="id" select="normalize-space($id)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        
                        <xsl:message>ERROR: Element <xsl:value-of select="local-name(.)"/> already has declared id <xsl:value-of select="@xml:id"/>. Added
                            <xsl:value-of select="$id"/> will have no effect.</xsl:message>
                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
        
        <!--Iterate through each @attribute and add it as a data-att-->
        <xsl:for-each select="@*[not(local-name()=('xml:id','id','lang','xml:lang','style','rendition','rend'))]">
            <xsl:attribute name="{concat('data-',local-name())}" select="."/>
        </xsl:for-each>
        
        <!--And now apply templates to the attributes in mode tei-->
        <xsl:apply-templates select="@*" mode="tei">
            <xsl:with-param name="classes" select="$classes" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>

    
    
    <xsl:template name="createSearchResults">
        <xsl:if test="ancestor::TEI/@xml:id='search'">
            <div id="searchResults"/>
        </xsl:if>
    </xsl:template>




    

</xsl:stylesheet>