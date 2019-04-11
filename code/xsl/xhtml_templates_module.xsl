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
                <xsl:call-template name="createInfo"/>
                <div id="text">
                    <xsl:call-template name="processAtts"/>
                    <xsl:apply-templates mode="#current"/>
                    <xsl:call-template name="createSearchResults"/>
                </div>
                <xsl:call-template name="createAppendix"/>
            </div>
            <xsl:call-template name="createPopup"/>
           <xsl:call-template name="createFooter"/>
        </body>
        
        
    </xsl:template>
    
    
    
    <!--Generic block level element templates-->
    <xsl:template match="body | div | p | lg | l | byline | opener | closer | list | item | person/note | listBibl" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </div>
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
    
    
    

    
    <xsl:template match="head" mode="tei">
        <xsl:variable name="nestLevel" select="count(ancestor::div)+1"/>
        <xsl:element name="{concat('h',$nestLevel)}">
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="div[@type='listFigure']/figure" mode="tei">
        <xsl:variable name="ext" select="tokenize(graphic/@mimeType,'/')[last()]"/>
        <xsl:variable name="href" select="replace(graphic/@url,'_sm.png$',concat('.',$ext))"/>
<!--        <div>-->

            <div>
                <xsl:call-template name="processAtts"/>
                <xsl:apply-templates select="head" mode="tei"/>

                <figure class="thumb">
                    <a href="{$href}" xsl:use-attribute-sets="newTabLink">
                        <img src="{graphic/@url}" alt="{ancestor::figure/figDesc}"/>
                        <div class="imageText">
                            <h4>View Image</h4>
                        </div>
                    </a>
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
    <xsl:template match="hi | seg | foreign | note | title[@level=('m','j','s')]" mode="tei">
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
                            <xsl:variable name="cellMap" as="map(xs:string, xs:integer+)">
                                <xsl:map>
                                    <xsl:for-each-group select="row[not(@role='label')]/cell" group-by="count(preceding-sibling::cell)">
                                        <xsl:variable name="colNumber" select="current-grouping-key()+1"/>
                                        <xsl:variable name="type">
                                            <xsl:choose>
                                                <xsl:when test="every $v in current-group() satisfies $v[date]">date</xsl:when>
                                                <xsl:when test="every $v in current-group() satisfies matches(normalize-space(string-join($v,'')),'^\d+(.\d+)?$')">float</xsl:when>
                                                <xsl:otherwise>string</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>
                                        <xsl:for-each select="current-group()">
                                            <xsl:sort select="
                                                if ($type='date') then date/@when (: If it's a date, use the @when :)
                                                else if ($type='float') then xs:float(.) (:If it's a float, use that :)
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
                            <thead>
                                <xsl:apply-templates select="row[1][@role='label']" mode="#current"/>
                            </thead>
                            <xsl:variable name="firstToSortBy"
                                select="
                                min(for $r 
                                in (row[1][@role='label']/cell[normalize-space(string-join(descendant::text(),'')) ne '']) 
                                return count($r/preceding-sibling::cell) + 1)" 
                                as="xs:integer"/>
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
        <th>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes" select="if (normalize-space(string-join(descendant::text(),'')) ne '') then 'sortable' else ()"/>
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
    
    <!--<xsl:template name="createSort">
        <xsl:variable name="table" select="ancestor::table"/>
        <xsl:variable name="thisColNum" select="count(preceding-sibling::cell) + 1"/>
        <xsl:variable name="vals" select="$table/row/cell[$thisColNum]/normalize-space(string-join(descendant::text()[not(ancestor::note)],''))" as="xs:string+"/>
        <xsl:variable name="type">
            <xsl:choose>
                <xsl:when test="every $v in $vals satisfies matches($v,'^\d+(\.\d+)?$')">float</xsl:when>
                <xsl:when test="every $v in $vals satisfies matches($v,'\d{4}(-\d{2}(-\d{2})?)')">date</xsl:when>
                <xsl:otherwise>string</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:attribute name="data-colNum" select="$thisColNum"/>
        <xsl:call-template name="makeSortKey">
            <xsl:with-param name="type" select="$type"/>
            <xsl:with-param name="thisColNum" select="$thisColNum"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="makeSortKey">
        <xsl:param name="type"/>
        <xsl:param name="thisColNum"/>

        <xsl:attribute name="data-sortNum" select="$map(generate-id(.))"/>
    </xsl:template>
    -->
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
    
    
    <xsl:template match="text()[not(ancestor::q)][preceding::text()[1][ancestor::q or ancestor::title[@level='a']]][matches(., '^[,\.]')]" mode="tei">
        <xsl:value-of select="substring(., 2)"/>
    </xsl:template>
    
    <!--Figures-->
    
    <xsl:template match="figure" mode="tei">
        <figure>
            <xsl:apply-templates mode="#current"/>
        </figure>
    </xsl:template>
    
    <xsl:template match="graphic" mode="tei">
        <img src="{@url}" alt="{if (desc) then normalize-space(string-join(desc)) else normalize-space(string-join(ancestor::figure/figDesc,''))}"/>
    </xsl:template>
    
    <xsl:template match="graphic/desc" mode="tei"/>
    
    
    <xsl:template match="gap[@reason='noTranscriptionAvailable']" mode="tei">
        <div class="para">No transcription available at this time.</div>
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
    
    <xsl:template match="name[not(@ref)][not(ancestor::respStmt)]" mode="tei">
        <span><xsl:apply-templates mode="#current"/></span>
    </xsl:template>
    
    <xsl:template match="name[@ref][not(ancestor::respStmt)] | rs" mode="tei">
        <a href="{@ref}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </a>
    </xsl:template>
    
    <xsl:template match="pb" mode="tei">
       <!--This can't really be an hr anymore, since it can't go in <q> (where it appears a lot).-->
        <span>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes" select="if (not(preceding::pb)) then 'first' else ()"/>
            </xsl:call-template>
            <xsl:if test="@n">
                <span class="pbNum">
                    <xsl:value-of select="@n"/>
                </span>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="lb" mode="tei">
        <br>
            <xsl:call-template name="processAtts"/>
        </br>
    </xsl:template>
    
    <!--Now janus elements-->
    
    <xsl:template match="choice" mode="tei">
        <span title="{normalize-space(orig)}">
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes">showTitle</xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="choice/orig" mode="tei"/>
    
    <xsl:template match="choice/reg" mode="tei">
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
        <div id="searchBox">
            <input type="text" name="search" placeholder="Search.."/>
        </div>

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