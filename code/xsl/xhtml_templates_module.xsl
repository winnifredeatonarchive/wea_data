<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
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
                <xsl:attribute name="class" select="
                    string-join(for $n in //catRef/@target return substring-after($n,'#'),' ') || (if (wea:isExhibit(ancestor::TEI)) then ' exhibit' else ())"/>
                <xsl:choose>
                    <xsl:when test="ancestor::TEI/@xml:id='index'">
                        <xsl:call-template name="createIndexPage"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="createInfo"/>
                        <xsl:call-template name="createPrintInfo"/>
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

            <script src="js/lazyload.min.js"/>
            <xsl:if test="//graphic[contains(@url,'media/')]">
                <script src="js/facsimile_view.js"></script>
            </xsl:if>
            <xsl:if test="ancestor::TEI/@xml:id='index'">
                <script src="js/index.js"></script>
            </xsl:if>
            <xsl:if test="ancestor::TEI/@xml:id = 'contribute'">
                <script src="js/jszip.min.js"/>
                <script src="js/encoding_package.js"></script>
            </xsl:if>
            <script src="js/accordion.js"><!--Keep open--></script>
            <script src="js/wea.js"/>
        </body>
    </xsl:template>
    
  
    
    <!--Generic block level element templates-->
    <xsl:template match="ab | body | front | div | p | lg | l | byline | opener | closer | item | person/note | note[p] | listBibl | sp | fw | titlePage | titlePart | titlePage/publisher" mode="tei">
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
    
    
    <xsl:template match="div[@xml:id='pseudonyms_timeline']/node()" mode="tei"/>
    
    
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
    
    <!--SPECIAL template for handling the contributor download list-->
    <xsl:template match="list[@type='checklist']/item[@facs]" priority="1" mode="tei">
        <xsl:variable name="thisRef" select="child::ref" as="element(ref)"/>
        <xsl:variable name="thisDoc" select="$thisRef/@target" as="xs:string"/>
        <xsl:variable name="thisDocId" select="substring-before($thisDoc,'.xml')"/>
        <xsl:variable name="thisFacs" select="substring-after(@facs,'facs:')" as="xs:string"/>
        <li>
            <input type="checkbox" id="{$thisDocId}" 
                name="{$thisDocId}" value="{$thisDocId}"></input>
            <label for="{$thisDocId}">
                <xsl:apply-templates select="$thisRef/node()" mode="#current"/></label>
        </li>
    </xsl:template>
    
    <xsl:template match="bibl" mode="tei">
        <div>
            <xsl:if test="ancestor::body and ancestor::TEI[@xml:id='resources']">
                <xsl:attribute name="data-chrono" select="wea:getDateSortKey(date)"/>
            </xsl:if>
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
        <xsl:variable name="root" select="ancestor::TEI"/>
        <xsl:variable name="nestLevel" select="count(ancestor::div)+1"/>
        <xsl:element name="{concat('h',$nestLevel)}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
        <xsl:if test="parent::body and count(following-sibling::head) = 0 and not(wea:isObject($root)) and not(wea:isExhibit($root))">
            <div id="info">
                <xsl:if test="not($root/descendant::catRef[matches(@target,'Listing')])">
                    <xsl:call-template name="createTOC"/>
                </xsl:if>
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
    </xsl:template>
    
    
    <!--Generic inline-->
    <xsl:template match="hi | seg | foreign | note | title[@level=('m','j','s')] | milestone[@unit='sectionBreak'] | emph | date | speaker | label | author | editor" mode="tei">
        <span>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </span>
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
        <xsl:variable name="isSortable" select="wea:isSortableTable(.)" as="xs:boolean"/>
        
        <table>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes" select="if ($isSortable) then 'sortable' else ()"/>
            </xsl:call-template>
            <xsl:choose>
                <xsl:when test="$isSortable">
                    <xsl:sequence select="wea:makeSortableTable(.)"/>
                </xsl:when>
                <xsl:otherwise>
                    <tbody>
                        <xsl:apply-templates mode="#current"/>
                    </tbody>
                </xsl:otherwise>
            </xsl:choose>
        </table>
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
        <xsl:param name="cellMap" as="map(xs:string, item())?" select="map{}" tunnel="yes"/>
        <xsl:variable name="id" select="generate-id(.)" as="xs:string"/>
        <xsl:variable name="entry" select="if (map:contains($cellMap, $id)) then $cellMap($id) else ()" as="map(xs:string, xs:integer)?"/>
        
        <td>
            <xsl:call-template name="processAtts"/>
            <xsl:if test="not(empty($entry))">
                <xsl:for-each select="map:keys($entry)">
                    <xsl:attribute name="data-{.}" select="map:get($entry, .)"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:apply-templates mode="#current"/>
        </td>
    </xsl:template>
    
    <!-- TABLE FUNCTIONS -->
    
    
    
    <xsl:function name="wea:isSortableTable" as="xs:boolean">
        <xsl:param name="table" as="element(table)"/>
        <xsl:choose>
            <xsl:when test="$table/ancestor::TEI[descendant::catRef/@target[contains(.,'Documentation')]]">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:when test="count($table/rows) = 1">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:when test="empty($table/row[@role='label'])">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="true()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="wea:makeSortableTable" as="element()+">
        <xsl:param name="table" as="element(table)"/>
        
        <xsl:variable name="labelRow" select="$table/row[1][@role='label']" as="element(row)?"/>
        <xsl:variable name="dataRows" select="$table/row[not(@role='label')]" as="element(row)*"/>
        <xsl:variable name="colMap" select="wea:makeColMap($dataRows)" as="map(xs:integer, xs:string)"/>
        <xsl:variable name="firstToSortBy" select="wea:getFirstColToSort($labelRow, $colMap)" as="xs:integer"/>
        <xsl:variable name="cellMap" select="wea:makeCellMap($dataRows, $colMap, $firstToSortBy)" as="map(xs:string, item())"/>

        
        
        <thead>
            <xsl:apply-templates select="$labelRow" mode="tei">
                <xsl:with-param name="firstToSortBy" select="$firstToSortBy" tunnel="yes"/>
            </xsl:apply-templates>
        </thead>
        
        <tbody>
            <xsl:apply-templates select="$dataRows" mode="tei">
                <xsl:sort>
                    <xsl:variable name="id" select="generate-id(cell[$firstToSortBy])" as="xs:string"/>
                    <xsl:variable name="key" select="if (map:contains($cellMap, $id)) then map:get($cellMap($id), 'sort') else ()"/>
                    <xsl:sequence select="$key"/>
                </xsl:sort>
                <xsl:with-param name="cellMap" select="$cellMap" tunnel="yes"/>
            </xsl:apply-templates>
        </tbody>
    </xsl:function>
    
    
    
    <xsl:function name="wea:makeCellMap" as="map(xs:string, item())">
        <xsl:param name="rows" as="element(row)+"/>
        <xsl:param name="colMap" as="map(xs:integer, xs:string)"/>
        <xsl:param name="firstToSortBy" as="xs:integer"/>
        <xsl:variable name="cols" select="map:keys($colMap)" as="xs:integer*"/>
        <xsl:variable name="firstStringCol" select="min(for $key in $cols return if ($colMap($key) = 'string') then $key else ())" as="xs:integer?"/>
        <xsl:map>
            <xsl:for-each-group select="$rows/cell" group-by="count(preceding-sibling::cell)">
                <xsl:variable name="colNumber" select="current-grouping-key()+1"/>
                <xsl:variable name="colType" select="$colMap($colNumber)"/>
                <xsl:variable name="pre" select="$colNumber - 1" as="xs:integer"/>
                <xsl:variable name="post" select="$colNumber + 1" as="xs:integer"/>
                <xsl:if test="not($colType = 'image')">
                    <xsl:for-each select="current-group()">
                        <xsl:sort select="wea:makeColSortKey(., $colType)"/>
                        <xsl:sort>
                            <xsl:variable name="parentRow" select="parent::row" as="element(row)"/>
                            <xsl:choose>
                                <xsl:when test="$cols = $pre">
                                    <xsl:sequence select="wea:makeColSortKey($parentRow/cell[$pre], $colMap($pre))"/>
                                </xsl:when>
                                <xsl:when test="$cols = $post">
                                    <xsl:sequence select="wea:makeColSortKey($parentRow/cell[$post], $colMap($post))"/> 
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </xsl:sort>
                        <xsl:variable name="pos" select="position()"/>
                        <xsl:map-entry key="generate-id(.)">
                            <xsl:map>
                                <xsl:map-entry key="'col'" select="$colNumber"/>
                                <xsl:map-entry key="'sort'" select="$pos"/>
                            </xsl:map>
                        </xsl:map-entry>
                    </xsl:for-each>
                </xsl:if>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:function>
    
    <xsl:function name="wea:makeColMap" as="map(xs:integer, xs:string)">
        <xsl:param name="rows" as="element(row)*"/>
        <xsl:map>
            <xsl:for-each-group select="$rows/cell" group-by="count(preceding-sibling::cell)">
                <xsl:variable name="colNum" select="current-grouping-key()+1" as="xs:integer"/>
                <xsl:variable name="cells" select="current-group()" as="element(cell)+"/>
                <xsl:map-entry key="$colNum">
                    <xsl:choose>
                        <xsl:when test="every $cell in $cells satisfies wea:isEmpty($cell)">
                            <xsl:sequence select="xs:string('string')"/>
                        </xsl:when>
                        <xsl:when test="every $cell in $cells satisfies matches(normalize-space(string($cell)),'^(yes|no|true|false)$','i')">
                            <xsl:sequence select="xs:string('boolean')"/>
                        </xsl:when>
                        <xsl:when test="not(empty($cells[date])) and (every $cell in $cells satisfies ($cell[date] or wea:isEmpty($cell)))">
                            <xsl:sequence select="xs:string('date')"/>
                        </xsl:when>
                        <xsl:when test="every $cell in $cells satisfies matches(normalize-space(string-join($cell,'')),'^\d+(.\d+)?$')">
                            <xsl:sequence select="xs:string('float')"/>
                        </xsl:when>
                        <xsl:when test="every $cell in $cells satisfies ($cell[ref/figure] or wea:isEmpty($cell))">
                            <xsl:sequence select="xs:string('image')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="xs:string('string')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:map-entry>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:function>
    
    <xsl:function name="wea:isEmpty" as="xs:boolean">
        <xsl:param name="el"/>
        <xsl:sequence select="normalize-space(string($el)) =''"/>
    </xsl:function>
    
    <xsl:function name="wea:getFirstColToSort" as="xs:integer">
        <xsl:param name="labelRow" as="element(row)"/>
        <xsl:param name="colMap" as="map(xs:integer, xs:string)"/>
        
        <xsl:variable name="sortKey"
            select="$labelRow/cell[@role='sortkey'][1]"
            as="element(cell)?"/>
        
        <xsl:variable name="firstDateCol" 
            select="min(for $key in map:keys($colMap) return if ($colMap($key) ='date') then $key else ())" 
            as="xs:integer?"/>
        
        <xsl:variable name="firstMeaningfulCol"
            select="min(for $key in map:keys($colMap) return if ($colMap($key) != 'image') then $key else ())"
            as="xs:integer?"/>
        
        
        <xsl:choose>
            <xsl:when test="exists($sortKey)">
                <xsl:value-of select="count($sortKey/preceding-sibling::cell) + 1"/>
            </xsl:when>
            <xsl:when test="not(empty($firstDateCol))">
                <xsl:sequence select="$firstDateCol"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$firstMeaningfulCol"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>

    <xsl:function name="wea:makeColSortKey" new-each-time="no" as="item()*">
        <xsl:param name="cell" as="element(cell)"/>
        <xsl:param name="colType" as="xs:string"/>

        <xsl:choose>
            <xsl:when test="$colType='date'">
                <xsl:sequence select="wea:getDateSortKey($cell/date[1])"/>
            </xsl:when>
            <xsl:when test="$colType='float'">
                <xsl:sequence select="xs:decimal(string($cell))"/>
            </xsl:when>
            <xsl:when test="$colType='boolean'">
                <xsl:sequence select="if (matches(normalize-space(string($cell)),'yes|true','i')) then 0 else 1"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="wea:makeTitleSortKeyFromCell($cell)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="wea:makeTitleSortKeyFromCell" new-each-time="no" as="xs:string">
        <xsl:param name="cell" as="element(cell)"/>
        <xsl:variable name="thisText" select="string-join($cell/descendant::text()[not(ancestor::note)])" as="xs:string"/>
        <xsl:sequence
            select="wea:makeTitleSortKey(normalize-space($thisText))"/>
    </xsl:function>
    
    <!--QUOTATIONS-->

    <xsl:template match="q[not(descendant::div | descendant::p | descendant::lg | descendant::floatingText)] | title[@level='a']" mode="tei">
        <xsl:variable name="even" select="count(ancestor::q | ancestor::title[@level='a']) mod 2 = 0" as="xs:boolean"/>
        <xsl:variable name="lq" select="if ($even) then '“' else '‘'" as="xs:string"/>
        <xsl:variable name="rq" select="if ($even) then '”' else '’'" as="xs:string"/>
        
        <span>
            <xsl:call-template name="processAtts"/>
            <xsl:value-of select="$lq"/>
            <xsl:apply-templates mode="#current"/>
            <xsl:if test="following::tei:*|text()[1][self::text()] and matches(following::text()[1], '^[,\.]') and not(child::tei:*[self::q][not(following-sibling::text())]) and (not(ancestor::q) or not(following-sibling::*))">
                <xsl:value-of select="substring(following::text()[1], 1, 1)"/>
            </xsl:if>
            <xsl:value-of select="$rq"/>
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
        <xsl:variable name="altText" select="if (desc) then normalize-space(string-join(desc)) else
            normalize-space(string-join(ancestor::figure/figDesc))" as="xs:string?"/>
        
        <xsl:choose>
            <xsl:when test="ancestor::list[@xml:id='featuredItems']" >
                <a href="{replace(parent::item/@corresp,'.xml','.html')}" aria-label="Link to {$altText}">z
                    <img src="{$urlNorm}" alt="{$altText}"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <img src="{$urlNorm}" class="lazy" data-wea-src="{if (matches($url,'\.tiff?','i')) then replace($url,'\.tiff?','.png','i') else $url}" alt="{$altText}"/>
            </xsl:otherwise>
        </xsl:choose>
       
    </xsl:template>
    
    <xsl:template match="graphic/desc" mode="tei"/>
    
    
    <xsl:template match="gap[@reason=('noTranscriptionAvailable','readyForProof','inProgress')]" mode="tei">
        <xsl:variable name="subject">WEA: <xsl:value-of select="ancestor::TEI/teiHeader/fileDesc/titleStmt/title[1]"/> (<xsl:value-of select="ancestor::TEI/@xml:id"/>)</xsl:variable>
        <xsl:variable name="temp" as="element(tei:div)">
            <tei:div type="noTranscriptionAvailable">

                <xsl:choose>
                    <xsl:when test="@reason = 'noTranscriptionAvailable'">
                        <tei:head>No Transcription Available</tei:head>
                        <tei:div>There is no transcription available yet for this item. If you would like to contribute a transcription,
                            please contact the <tei:ref target="mailto:mchapman@ubc.ca?subject={encode-for-uri($subject)}">Project Director</tei:ref>.</tei:div>
                    </xsl:when>
                    <xsl:otherwise>
                        <tei:head>Transcription Forthcoming</tei:head>
                        <tei:div>The transcription for this text is currently in progress.</tei:div>
                    </xsl:otherwise>
                </xsl:choose>
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
        <a href="#{ancestor::TEI/@xml:id}_pg_{@n}" class="pb-link">
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
    
    
    <xsl:template match="body[ancestor::TEI/@xml:id='people']" mode="tei">
        <div>
           <xsl:call-template name="processAtts"/>
           <xsl:apply-templates select="node()[not(self::listPerson)]" mode="#current"/>
           <xsl:variable name="tempTable" as="element(tei:table)">
               <table xmlns="http://www.tei-c.org/ns/1.0" type="exhibit">
                   <row role="label">
                       <cell>ID</cell>
                       <cell>Type</cell>
                       <cell>Regularized name</cell>
                       <cell>Note</cell>
                   </row>
                   <xsl:for-each select="//person[@xml:id]">
                       <row>
                           <cell><ref target="{@xml:id}.html"><xsl:value-of select="@xml:id"/></ref></cell>
                           <cell><xsl:value-of select="wea:capitalize(parent::listPerson/@type)"/></cell>
                           <cell><xsl:sequence select="persName/reg/node()"/></cell>
                           <cell><xsl:sequence select="note/node()"/></cell>
                       </row>
                   </xsl:for-each>
               </table>
           </xsl:variable>
            <xsl:apply-templates select="$tempTable" mode="tei"/>
        </div>
    </xsl:template>
    
    <xsl:template match="body[ancestor::TEI/@xml:id='organizations']" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates select="node()[not(self::listOrg)]" mode="#current"/>
            <xsl:variable name="tempTable" as="element(tei:table)">
                <table xmlns="http://www.tei-c.org/ns/1.0" type="exhibit">
                    <row role="label">
                        <cell>ID</cell>
                        <cell>Name</cell>
                        <cell>Note</cell>
                    </row>
                    <xsl:for-each select="//org[@xml:id]">
                        <row>
                            <cell><ref target="{@xml:id}.html"><xsl:value-of select="@xml:id"/></ref></cell>
                            <cell><xsl:sequence select="orgName/node()"/></cell>
                            <cell><xsl:sequence select="note/node()"/></cell>
                        </row>
                    </xsl:for-each>
                </table>
            </xsl:variable>
            <xsl:apply-templates select="$tempTable" mode="tei"/>
        </div>
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
    
    <xsl:template match="div[@xml:id='search_instructions']" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <details>
                <summary><xsl:apply-templates select="head/node()"/></summary>
                <xsl:apply-templates select="node() except head" mode="#current"/>
            </details>
        </div>
    </xsl:template>
    
    <xsl:template match="code" mode="tei">
        <code><xsl:apply-templates mode="#current"/></code>
    </xsl:template>
    
    
    <xsl:template match="divGen[@xml:id='index_twitter']" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <a data-tweet-limit="2" data-dnt="true"
                class="twitter-timeline" href="https://twitter.com/WEatonArchive?ref_src=twsrc%5Etfw">Tweets by the WEA</a>
            <script async="async" defer="defer" src="https://platform.twitter.com/widgets.js"><!--KEEP OPEN--></script>
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