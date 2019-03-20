<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
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
    
    <xsl:attribute-set name="newTabLink">
        <xsl:attribute name="rel">noopener noreferrer</xsl:attribute>
        <xsl:attribute name="target">_blank</xsl:attribute>
    </xsl:attribute-set>
    

    
    <xsl:template match="TEI" mode="tei">
        <xsl:message>Processing <xsl:value-of select="@xml:id"/></xsl:message>
        <xsl:result-document href="{concat($outDir,'/',@xml:id)}.html" method="xhtml" encoding="UTF-8" indent="no" normalization-form="NFC" exclude-result-prefixes="#all" omit-xml-declaration="yes" html-version="5.0">
            <html lang="en">
                <xsl:call-template name="processAtts"/>
                <xsl:apply-templates mode="#current"/>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!--TODO: METADATA STUFF-->
    <xsl:template match="teiHeader" mode="tei">
        <head>
            <title><xsl:value-of select="fileDesc/titleStmt/title[1]"/></title>
            <xsl:call-template name="createHeader"/>
        </head>
    </xsl:template>
    
    <!--delete the standoff from teh regular flow-->
    <xsl:template match="text[@type='standoff']" mode="tei"/>
    
    
    <xsl:template match="text[not(@type='standoff')][not(ancestor::floatingText)]" mode="tei">
      
        <body>
            <header>
                <button id="hamburger" class="hamburger closed" type="button">
                    <span class="hamburger-box">
                        <span class="hamburger-inner"></span>
                    </span>
                </button>  
                <nav>
                    <div class="nav-item home"><a href="index.html">WEA</a></div>
                    <div class="nav-item">About</div>
                    <div class="nav-item">Archive</div>
                    <div class="nav-item">Career</div>
                    <div class="nav-item">Biography</div>
                    <div class="nav-item">Resources</div>
<!--                    <div class="nav-item">News</div>-->
                    <div class="nav-item">Contact</div>
                    <div class="nav-item"><a href="search.html">Search</a></div>
                </nav>
               
            </header>
            <div id="mainBody">
                <xsl:attribute name="class" select="string-join(for $n in //catRef/@target return substring-after($n,':'),' ')"/>
                <xsl:call-template name="createInfo"/>
                <div id="text">
                    <xsl:call-template name="processAtts"/>
                    <xsl:apply-templates mode="#current"/>
                    <xsl:call-template name="createSearchResults"/>
                </div>
                <xsl:call-template name="createAppendix"/>
            </div>
            <xsl:call-template name="createPopup"/>
            <footer>
                <div id="lastUpdate">Last updated: <xsl:value-of select="$today"/></div>
                <div id="gitRevision"><!--Get this--></div>
            </footer>
        </body>
        
        
    </xsl:template>
    
    <xsl:template name="createInfo">
        <xsl:variable name="root" select="ancestor::TEI"/>
        <xsl:if test="not(wea:bornDigital($root))">
            
            <div id="info">
                <div id="facsimile">
                    <xsl:call-template name="createFacs"/>
                    
                </div>
                <div id="metadata_container">
                    
                <div id="title">
                    <xsl:copy-of select="wea:crumb($root)"/>
                    <h2><xsl:value-of select="$root/teiHeader/fileDesc/titleStmt/title[1]"/></h2>
                </div>
                <div id="metadata">
                    <xsl:apply-templates select="ancestor::TEI/teiHeader" mode="metadata"/>
                </div>
                <div id="relatedItems">
                    <xsl:call-template name="createRelatedItems"/>
                </div>
                </div>
<!--                <xsl:if test="$root//sourceDesc/bibl">-->
                <div id="additional_info">
                    <div class="metadataLabel" id="additional_info_header">Additional Metadata</div>
                    <div id="additional_info_content">
                        <div id="source_citation">
                            <div class="metadataLabel">Source Citation</div>
                            <xsl:apply-templates select="$root//sourceDesc/bibl/node()" mode="tei"/>
                        </div>
                    </div>
                    
                    <!--                        <div id="wea_citation">
                            <div class="metadataLabel">Full Citation</div>
                            <xsl:apply-templates select=""
                        </div>-->
                </div>
                <!--</xsl:if>-->
               
            </div>
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template name="createRelatedItems"/>
    
    <xsl:template name="createFacs">
        <xsl:variable name="facsAvailable" select="exists(@facs)"/>
        <xsl:variable name="imgToUse" select="if ($facsAvailable) then @facs else 'graphics/cooking.png'"/>
        <xsl:variable name="thisThumbnail" select="if ($facsAvailable) then replace($imgToUse,'\.pdf','.png') else $imgToUse"/>
        <xsl:variable name="altText" select="if ($facsAvailable) then 'First page of facsimile' else 'Illustration of woman cooking to denote no facsimile available'"/>
        <xsl:variable name="height" select="wea:getPNGHeight(substring-before(@facs,'.pdf'))"/>
        <figure class="facsThumb">
            <xsl:choose>
                <xsl:when test="$facsAvailable">
                    <a href="{@facs}" xsl:use-attribute-sets="newTabLink">
                        <img src="{$thisThumbnail}" alt="{$altText}"/>
                        <div id="imageText" class="{if ($height gt 600) then 'landscape' else 'portrait'}">
                            <h4>View Facsimile</h4>
                            <div class="pdfSize"><xsl:value-of select="wea:getPDFSize(@facs)"/></div>
                        </div>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <img src="{$thisThumbnail}" alt="{$altText}"/>
                    <div id="imageText" class="portrait">
                        <h4>No facsimile available</h4>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
           
            
           <!-- <figCaption>
                <xsl:choose>
                    <xsl:when test="$facsAvailable">
                        <a href="{@facs}" xsl:use-attribute-sets="newTabLink">View Facsimile <span class="pdfSize">(<xsl:value-of select="wea:getPDFSize(@facs)"/>)</span></a>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="noFacsAvailable">
                            No facsimile available
                        </span>
                        
                    </xsl:otherwise>
                </xsl:choose>
            </figCaption>-->
        </figure>
    </xsl:template>
    
    <xsl:function name="wea:crumb">
        <xsl:param name="doc"/>
        <xsl:variable name="category" select="$doc//catRef[contains(@scheme,'#category')]/@target"/>
        <xsl:variable name="thisCat" select="$standaloneXml//category[@xml:id=substring-after($category,'wdt:')]"/>
        <div class="breadcrumb metadataLabel"><a href="{$thisCat/@xml:id}.html"><xsl:value-of select="$thisCat/@n"/></a></div>
    </xsl:function>
    
    
    
    <xsl:template match="teiHeader" mode="metadata">
            <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="sourceDesc/bibl" mode="metadata">
        <xsl:apply-templates select="*" mode="#current"/>
    </xsl:template>
    
     <xsl:template match="bibl/author" mode="metadata">
         <div>
             <xsl:call-template name="processAtts"/>
             <div class="metadataLabel">Pseudonym</div>
             <div><xsl:apply-templates mode="tei"/></div>
         </div>
     </xsl:template>
    
    <xsl:template match="bibl/biblScope[@unit='volume']" mode="metadata">
        <div>
            <xsl:call-template name="processAtts"/>
            <div class="metadataLabel">Volume</div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    
    <xsl:template match="bibl/title[@level='a']" mode="metadata"/>
    
    <xsl:template match="bibl/title[@level='j']" mode="metadata">
        <div>
            <xsl:call-template name="processAtts"/>
            <div class="metadataLabel">Journal</div>
            <div>
                <xsl:apply-templates mode="tei"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="bibl/biblScope[@unit='issue']" mode="metadata">
        <div>
            <xsl:call-template name="processAtts"/>
            <div class="metadataLabel">Issue</div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    <xsl:template match="bibl/biblScope[@unit='page']" mode="metadata">
        <div>
            <xsl:call-template name="processAtts"/>
            <div class="metadataLabel">Page Range</div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    
    <xsl:template match="bibl/date" mode="metadata">
        <div>
            <xsl:call-template name="processAtts"/>
            <div class="metadataLabel">Date</div>
            <div>
                <xsl:apply-templates mode="tei"/>
            </div>
        </div>
    </xsl:template>

  
    
    <xsl:template match="titleStmt/title | revisionDesc | publicationStmt| profileDesc | encodingDesc" mode="metadata"/>
    
    <xsl:template match="respStmt" mode="metadata">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates select="resp" mode="#current"/>
            <xsl:apply-templates select="name" mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="respStmt/resp" mode="metadata">
        <div>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="classes" select="'metadataLabel'"/>
            </xsl:call-template>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="respStmt/name" mode="metadata">
        <div>
            <xsl:variable name="thisName">
                <xsl:copy-of select="."/>
            </xsl:variable>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates select="$thisName" mode="tei"/>
        </div>
    </xsl:template>
    
    <!--Generic block level element templates-->
    <xsl:template match="body | div | p | lg | l | byline | opener | closer" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    

    
    <xsl:template match="head" mode="tei">
        <xsl:variable name="nestLevel" select="count(ancestor::div)+1"/>
        <xsl:element name="{concat('h',$nestLevel)}">
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <!--Generic inline-->
    <xsl:template match="hi | seg | foreign | note" mode="tei">
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
        <table>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </table>
    </xsl:template>
    
    <xsl:template match="row" mode="tei">
        <tr>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </tr>
    </xsl:template>
    <!--QUOTATIONS-->
    
    
    <xsl:template match="q[not(descendant::div | descendant::p | descendant::lg | descendant::floatingText)]" mode="tei">
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


    
    <xsl:template match="text()[not(ancestor::q)][preceding::text()[1][ancestor::q]][matches(., '^[,\.]')]" mode="tei">
        <xsl:value-of select="substring(., 2)"/>
    </xsl:template>
    
    <xsl:template match="cell" mode="tei">
        <td>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </td>
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
    
    <xsl:template match="name[@ref][not(ancestor::respStmt)]" mode="tei">
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
        <a href="#{$noteId}"  id="noteMarker_{$noteNum}" class="noteMarker" title="{normalize-space(string-join(descendant::text(),''))}"><xsl:value-of select="$noteNum"/></a>
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
            <h3><xsl:apply-templates select="persName/reg" mode="#current"/></h3>
            <xsl:apply-templates select="node()[not(self::persName)]" mode="#current"/>
        </div>
    </xsl:template>
    
    
    <!--Repoint the src in graphics-->
    <xsl:template match="img/@src" mode="tei">
        <xsl:attribute name="src" select="concat('graphics/',tokenize(.,'/')[last()])"/>
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
    
    <xsl:template name="createHeader">
        <link rel="stylesheet" type="text/css" href="css/wea.css"/>
        <link rel="icon" type="image/png" href="graphics/icon.png"/>
        <script src="js/wea.js"/>
        <script src="js/porterStemmer.js"/>
        <script src="js/search.js"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        
    </xsl:template>
    
    
    <xsl:template name="createSearchResults">
        <xsl:if test="ancestor::TEI/@xml:id='search'">
            <div id="searchResults"/>
        </xsl:if>
    </xsl:template>




    

</xsl:stylesheet>