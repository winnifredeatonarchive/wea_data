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
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: March 24, 2019.</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet contains all of the templates for the creating the VIEWABLE (i.e. in the BODY of the document, not the HEAD) metadata in HTML.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template name="createInfo">
        <xsl:variable name="root" select="ancestor::TEI"/>
        <xsl:if test="wea:isObject($root) or wea:isExhibit($root)">
            <div id="info">
                <xsl:choose>
                    <xsl:when test="wea:isObject($root)">
                        <xsl:call-template name="createObjectInfo"/>
                    </xsl:when>
                    <xsl:when test="wea:isExhibit($root)">
                        <xsl:variable name="thisCat" select="$standaloneXml//category[@xml:id=$root/@xml:id]"/>
                        <div id="info_left">
                            <h2><xsl:apply-templates select="$thisCat/catDesc/term/node()" mode="tei"/></h2>
                            <xsl:apply-templates select="$thisCat/catDesc/note/p" mode="tei"/>
                        </div>
                        <div id="info_right">
                            <ul>
                                <xsl:for-each select="$thisCat/parent::*/category">
                                    <xsl:sort select="xs:integer(@n)"/>
                                    <li><a href="{@xml:id}.html">
                                        <xsl:if test="@xml:id=$thisCat/@xml:id">
                                            <xsl:attribute name="class" select="'current'"/>
                                        </xsl:if>
                                        <xsl:apply-templates select="catDesc/term/node()" mode="tei"/>
                                    </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </div>
                    </xsl:when>
                </xsl:choose>
            </div>
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template name="createObjectInfo">
        <xsl:variable name="root" select="ancestor::TEI"/>
        <div id="facsimile">
            <xsl:call-template name="createFacs"/>
            
        </div>
        <div id="metadata_container">
            
            <div id="title">
                <xsl:copy-of select="wea:crumb($root)"/>
                <h2><xsl:value-of select="$root/teiHeader/fileDesc/titleStmt/title[1]"/></h2>
            </div>
            <div id="metadata">
                <xsl:call-template name="makeMetadata"/>
            </div>
        </div>
        
        <!--                <xsl:if test="$root//sourceDesc/bibl">-->
        
        
        <div id="additional_info">
            <xsl:call-template name="createCreditsAndCitations"/>
            <xsl:call-template name="createAbstract"/>
            <xsl:call-template name="createRelatedItems"/>
            <xsl:call-template name="createTOC"/>
            
        </div>
        
    </xsl:template>
   

    
    <xsl:template name="createCreditsAndCitations">
        <xsl:variable name="root" select="ancestor::TEI"/>
        <xsl:variable name="currId" select="$root/@xml:id"/>
        <details id="credits" class="additionalInfo expandable">
            <summary class="metadataLabel additionalInfoHeader" id="credits_header">Credits and Citations<span class="mi">chevron_right</span></summary>
            <div id="credits_content" class="content">
                <xsl:apply-templates select="$root//respStmt[not(ancestor::biblFull)]" mode="metadata"/>
                
                <xsl:if test="$root//availability[ancestor::msDesc]/p">
                    <div>
                        <div class="metadataLabel">Notes</div>
                        <xsl:for-each select="$root//availability[ancestor::msDesc]/p">
                            <div>
                                <xsl:apply-templates select="node()" mode="tei"/>
                            </div>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                
                <xsl:call-template name="createCitations"/>
                
                <xsl:call-template name="createSurrogates"/>
                
                <xsl:apply-templates select="$root//revisionDesc[not(ancestor::biblFull)]" mode="metadata"/>
                
                <xsl:call-template name="createXMLVersions"/>
                

            </div>
            
        </details>
    </xsl:template>
    
    <xsl:template name="createXMLVersions">
        <xsl:variable name="currId" select="root(.)//TEI/@xml:id" as="xs:string"/>
        <div id="xmlVersions">
            <div class="metadataLabel">Download XML</div>
            <xsl:variable name="sourceUri"
                select="concat('xml/original/', $currId, '.xml')"/>
            <xsl:variable name="originalUri" select="concat('xml/original/',$currId,'.xml')"/>
            <xsl:variable name="standaloneUri" 
                select="concat('xml/standalone/', $currId ,'.xml')"/>
            
            <xsl:variable name="thisSourcePath" select="$dataListLines[matches(.,('/' || $currId || '.xml$'))]" as="xs:string?"/>
            
            <xsl:variable name="sourceSize" select="wea:getFileSize($sourceUri)"/>
            <xsl:variable name="originalSize" select="wea:getFileSize($originalUri)"/>
            <xsl:variable name="standaloneSize" select="wea:getFileSize($standaloneUri)"/>
            
            <xsl:variable name="tempList">
                <tei:list>
                    <xsl:if test="exists($sourceUri)">
                        <tei:item>
                            <tei:ref target="{$sourceUri}">Source XML</tei:ref>
                            <xsl:if test="not(empty($sourceSize))">
                                <xsl:value-of select="' (' || $sourceSize || ')'"/>
                            </xsl:if>
                            <xsl:text> [</xsl:text><tei:ref target="https://github.com/winnifredeatonarchive/wea_data/blob/{$sha}{$thisSourcePath}">View on Github</tei:ref><xsl:text>]</xsl:text>
                        </tei:item>
                    </xsl:if>
                    <tei:item>
                        <tei:ref target="{$originalUri}">Original XML</tei:ref>
                        <xsl:if test="not(empty($originalSize))">
                            <xsl:text> (</xsl:text><xsl:value-of select="$originalSize"/><xsl:text>)</xsl:text>
                        </xsl:if>
                    </tei:item>
                    <tei:item>
                        <tei:ref target="{$standaloneUri}">Standalone XML</tei:ref>
                        <xsl:if test="not(empty($originalSize))">
                            <xsl:text> (</xsl:text><xsl:value-of select="$originalSize"/><xsl:text>)</xsl:text>
                        </xsl:if>
                    </tei:item>
                </tei:list>
            </xsl:variable>
            <div>
                <xsl:apply-templates select="$tempList" mode="tei"/>
                <div data-el="p">See the <a href="about.html#about_openSourceCode">About</a> page for information about these XML versions.</div>
            </div>
        </div>
    </xsl:template>
    
    
    <xsl:template name="createCitations">
        <xsl:variable name="root" select="ancestor-or-self::TEI"/>
        <xsl:variable name="uri" select="wea:getURL($root)"/>
        <xsl:if test="$root//sourceDesc[not(ancestor::sourceDesc)]/msDesc/msContents/msItem/bibl">
            <div id="source_citation">
                <div class="metadataLabel">Source Citation</div>
                <xsl:apply-templates select="$root//sourceDesc[not(ancestor::sourceDesc)]/msDesc/msContents/msItem/bibl" mode="tei"/>
            </div>
        </xsl:if>
       
        <div id="this_citation">
            <div class="metadataLabel">Cite this Page</div>
            <xsl:apply-templates select="$root/descendant::publicationStmt[not(ancestor::sourceDesc)]/ab[@type='citations']/listBibl/bibl[@type='mla']" mode="tei"/>
        </div>
    </xsl:template>
    
    
    <xsl:template name="createSurrogates">
        <xsl:for-each-group select="root(.)//surrogates/bibl" group-by="@type">
            <div id="related_items_{current-grouping-key()}">
                <xsl:choose>
                    <xsl:when test="current-grouping-key() = 'bibliography'">Cited In</xsl:when>
                    <xsl:when test="current-grouping-key() = 'edition'">Other Editions</xsl:when>
                    <xsl:when test="current-grouping-key() = 'archival_copy'">Archival Copy</xsl:when>
                </xsl:choose>
                <xsl:for-each select="current-group() ! wea:getBiblFromBiblPtr(.)">
                    <xsl:sort select="if (date) then tokenize(date/@when,'-')[1] => xs:integer() else 0" order="descending"/>
                    <xsl:apply-templates select="." mode="tei"/>
                </xsl:for-each>
            </div>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:function name="wea:getBiblFromBiblPtr" as="element(tei:bibl)">
        <xsl:param name="bibl" as="element(bibl)"/>        
        <xsl:variable name="targ" select="$bibl/@target" as="xs:string?"/>
        <xsl:choose>
            <xsl:when test="empty($targ)">
                <xsl:sequence select="$bibl"/>
            </xsl:when>
            <xsl:when test="starts-with($targ,'#')">
                <xsl:variable name="targId" select="substring-after($targ,'#')" as="xs:string"/>
                <xsl:variable name="bibl" select="$bibl/ancestor::TEI/descendant::bibl[@xml:id = $targId]" as="element(tei:bibl)"/>
                <xsl:sequence select="$bibl"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="bibl" as="element(tei:bibl)">
                    <tei:bibl>
                        <tei:ref target="{$targ}"><xsl:value-of select="$targ"/></tei:ref>
                    </tei:bibl>
                </xsl:variable>
                <xsl:sequence select="$bibl"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    <xsl:template match="biblFull" mode="citation"/>
    
    <xsl:template match="bibl/author/name | bibl/author/rs | bibl/publisher" mode="citation">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="@*|node()" priority="-1" mode="citation">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="createRelatedItems">
        <xsl:variable name="currId" select="ancestor::TEI/@xml:id" as="xs:string"/>
        <xsl:variable name="currMap" select="$relationshipMap($currId)" as="map(*)?"/>
        <xsl:if test="exists($currMap) and not(empty(map:keys($currMap)))">
            <details id="relatedItems" class="additionalInfo expandable">
                <summary class="metadataLabel additionalInfoHeader" id="relatedItems_header">Related Items<span class="mi">chevron_right</span></summary>
                <div class="content">
                    <button class="mi next_prev prev">chevron_left</button>
                    <ul class="related-items">
                        <xsl:for-each select="map:keys(map:get($relationshipMap, string($currId)))">
                            <xsl:variable name="targ" select="."/>
                            <xsl:variable name="relatedDoc" select="$standaloneXml[/TEI/@xml:id= $targ]"/>
                            <xsl:call-template name="makeRelatedItemBox">
                                <xsl:with-param name="label" select="$relatedDoc//teiHeader/fileDesc/titleStmt/title[1]/node()"/>
                                <xsl:with-param name="link" select="$targ || '.xml'"/>
                                <xsl:with-param name="imgSrc" select="if ($relatedDoc//text/@facs) then $relatedDoc//text/replace(@facs,'.pdf','_tiny.jpg') else 'images/cooking.jpg'"/>
                                <xsl:with-param name="imgAlt" select="concat('Facsimile image for ', normalize-space(string-join($relatedDoc//teiHeader/fileDesc/titleStmt/title[1]/node(),'')))"/>
                            </xsl:call-template>
                            
                        </xsl:for-each>
                    </ul>
                    <button class="mi next_prev next">chevron_right</button>
                </div>
            </details>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="makeRelatedItemBox">
        <xsl:param name="label"/>
        <xsl:param name="link"/>
        <xsl:param name="imgSrc"/>
        <xsl:param name="imgAlt"/>
        <li class="related-item">
            <a href="{wea:resolveTarget($link)}">
                <figure>
                    <img src="{$imgSrc}" alt="{normalize-space(string-join($imgAlt,''))}"/>
                    <figCaption><xsl:apply-templates select="$label" mode="tei"/></figCaption>
                </figure>
            </a> 
        </li>
    </xsl:template>
    
    <xsl:template match="figure" mode="metadata">
        <div>
            <div class="metadataLabel"><xsl:apply-templates select="head/node()" mode="tei"/></div>
            <figure>
                <img src="{graphic/@url}" alt="{../figDesc}"/>
            </figure>
        </div>
    </xsl:template>
    
    
    <xsl:template name="createTOC">
        <xsl:variable name="toc" as="element(tei:list)">
            <xsl:apply-templates select="ancestor::TEI" mode="toc"/>
        </xsl:variable>
        <xsl:if test="exists($toc/item)">
            <details id="toc" class="additionalInfo expandable">
                <summary class="metadataLabel additionalInfoHeader" id="toc_header">Table of Contents<span class="mi">chevron_right</span></summary>
                <div class="content" id="toc_content">
                    <xsl:apply-templates select="$toc" mode="tei"/>
                </div>
            </details>
            
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI" mode="toc">
            <tei:list>
                <!--And apply templates to the text-->
                <xsl:apply-templates select="text[not(@type='standoff')]" mode="#current"/>
            </tei:list>
    </xsl:template>
    
    
    <xsl:template match="TEI/text[not(@type='standoff')]" mode="toc">
        <xsl:for-each select="//div[head][not(ancestor::floatingText)][not(ancestor::div[head])]">
            <xsl:apply-templates select="." mode="#current"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="div[head]" mode="toc">
        <tei:item><tei:ref target="#{wea:getId(.)}"><xsl:apply-templates select="head[1]" mode="#current"/></tei:ref>
            <xsl:if test="child::div[head]">
                <tei:list>
                    <xsl:apply-templates select="child::div[head]" mode="#current"/>
                </tei:list>
            </xsl:if>
        </tei:item>
    </xsl:template>
    
    <xd:doc>
    <xd:desc>And just turn the head into text and process its contents through
        the regular chain (ignoring attributes)</xd:desc>
    </xd:doc>
    <xsl:template match="div/head" mode="toc">
        <xsl:apply-templates select="node()" mode="#current"/>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Elements to ignore in processing for the TOC.</xd:desc>
    </xd:doc>
    <xsl:template match="head/descendant::note | head/descendant::app | head/descendant::lb | head/descendant::gap | head/descendant::label | head/descendant::anchor" mode="toc"/>
    
    <xd:doc>
        <xd:desc>Attributes to delete, since we don't want this styling in the TOC.</xd:desc>
    </xd:doc>
    <xsl:template match="@style | @rendition" mode="toc"/>
    
    
    <xd:doc>
        <xd:desc>We copy out any descendant node, unless otherwise specified.</xd:desc>
    </xd:doc>
    <xsl:template match="@*|node()" priority="-1" mode="toc">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="toc"/>
        </xsl:copy>
    </xsl:template>
    
    
    
    
    <xsl:function name="wea:getId">
        <xsl:param name="el"/>
        <xsl:value-of select="if ($el/@xml:id) then $el/@xml:id else generate-id($el)"/>
    </xsl:function>
    
    
    
    <xsl:template name="makeMetadata">
        <!--First thing is to apply templates to the sourceDesc-->
        <xsl:apply-templates
            select="//sourceDesc[not(ancestor::biblFull)]/msDesc/msContents/msItem/bibl/*"
            mode="metadata"/>
        
        <!--Now process the category references-->
        <xsl:apply-templates select="//catRef[not(ancestor::biblFull)]" mode="metadata"/>
        
        <!--And then if there are installments, add those too-->
        <xsl:apply-templates select="//text/@prev" mode="metadata"/>
        <xsl:apply-templates select="//text/@next" mode="metadata"/>
        
  <!--      <!-\-And get some information from the work from which it derives-\->
        <xsl:call-template name="getWork"/>-->

    </xsl:template>
    
    
    <xsl:template name="createAbstract">
        <xsl:apply-templates select="//abstract" mode="metadata"/>
    </xsl:template>
    
    <xsl:template match="abstract" mode="metadata">
        <xsl:variable name="curr" select="."/>
        <details id="headnote" class="additionalInfo expandable" open="open">
            <summary class="metadataLabel additionalInfoHeader" id="headnote_header">Headnote<span class="mi">chevron_right</span></summary>
            <div class="content" id="headnote_content">
                <xsl:apply-templates select="node()" mode="tei"/>         
                <div class="headnoteResp">
                    <xsl:apply-templates select="wea:returnHeadnoteByline($curr)" mode="tei"/>
                </div>
            </div>
        </details>
    </xsl:template>
    
    <xsl:template name="getWork">
        <xsl:variable name="thisId" select="root(.)//TEI/@xml:id" as="xs:string"/>
        <xsl:variable name="thisWork" select="$standaloneXml[//TEI[@xml:id='relationships']]//linkGrp[@type='work'][ptr[contains-token(@target, ($thisId || '.xml'))]]" as="element(linkGrp)"/>
        <div>
            <div class="metadataLabel">Work</div>
            <div>
                <a href="{$thisWork/@xml:id}.html">
                    <xsl:apply-templates select="$thisWork/desc/node()" mode="tei"/>
                </a>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="bibl/note" mode="metadata"/>
    <xsl:template match="sourceDesc/biblFull" mode="metadata"/>
    
    
    <xsl:template match="text/@next | text/@prev" mode="metadata">
        <div>
            <div class="metadataLabel"><xsl:value-of select="if (local-name()='next') then 'Next' else 'Previous'"/> Instalment</div>
            <div><a href="{wea:resolveTarget(.)}"><xsl:apply-templates select="wea:getTitle(substring-before(.,'.xml'))" mode="tei"/></a></div>
        </div>
    </xsl:template>
    
    
    
    <xsl:template match="catRef" mode="metadata">
        <xsl:variable name="target" select="@target"/>
        <xsl:variable name="scheme" select="@scheme"/>
        <xsl:variable name="thisSchemeTitle" select="$standaloneXml//taxonomy[@xml:id=substring-after($scheme,'#')]/bibl/node()"/>
        <xsl:variable name="thisTargetTitle" select="$standaloneXml//category[@xml:id=substring-after($target,'#')]/catDesc/term"/>
        <div>
            <div class="metadataLabel"><xsl:apply-templates select="$thisSchemeTitle" mode="tei"/></div>
            <div><a href="{substring-after($target,'#')}.html"><xsl:apply-templates select="$thisTargetTitle/node()" mode="tei"/></a></div>
        </div>
    </xsl:template>
  
    
    <xsl:template name="createFacs">
        <xsl:variable name="facsAvailable" select="exists(@facs)"/>
        <xsl:variable name="imgToUse" select="if ($facsAvailable) then @facs else 'images/cooking.jpg'"/>
        <xsl:variable name="thisThumbnail" select="if ($facsAvailable) then replace($imgToUse,'\.pdf','.jpg') else $imgToUse"/>
        <xsl:variable name="altText" select="if ($facsAvailable) then 'First page of facsimile' else 'Illustration of woman cooking to denote no facsimile available'"/>
        <xsl:variable name="height" select="wea:getImageDimensions(substring-before(@facs,'.pdf'))[1]"/>
        
        <figure class="thumb">
            <xsl:choose>
                <xsl:when test="$facsAvailable">
                    <a href="{@facs}" xsl:use-attribute-sets="newTabLink">
                        <img src="{$thisThumbnail}" alt="{$altText}"/>
                        <div class="imageText {if ($height gt 600 or empty($height)) then 'landscape' else 'portrait'}">
                            <h4>View Facsimile</h4>
                            <div class="pdfSize"><xsl:value-of select="wea:getFileSize(@facs)"/></div>
                        </div>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <img src="{$thisThumbnail}" alt="{$altText}"/>
                    <div class="imageText portrait">
                        <h4>No facsimile available</h4>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </figure>
    </xsl:template>
    
    
    
    
    
    <xsl:template match="teiHeader" mode="metadata">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="sourceDesc/bibl" mode="metadata">
        <xsl:apply-templates select="*" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="bibl/author[not(@role)]" mode="metadata">
        <xsl:if test="not(preceding-sibling::author[not(@role)])">
            <div>
                <div class="metadataLabel">Author<xsl:if test="following-sibling::author[not(@role)]">s</xsl:if></div>
                <xsl:call-template name="makeAuthorBits"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="makeAuthorBits">
        <div class="author">
            <xsl:apply-templates select="node()" mode="#current"/>
        </div>
        <xsl:for-each select="following-sibling::author[not(@role)]">
            <xsl:call-template name="makeAuthorBits"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="bibl/author[@role='illustrator']" mode="metadata">
        <div>
            <div class="metadataLabel">Illustrator</div>
            <div>
                <xsl:apply-templates select="node()" mode="#current"/>
            </div>
        </div>
    </xsl:template>
    
    
    <xsl:template match="bibl/author/name | bibl/author/rs" mode="metadata">
        <xsl:variable name="nameEl" as="element(name)" select="wea:createSplitNameEl(.)"/>
         
        <span class="authorName">
            <xsl:apply-templates select="$nameEl" mode="tei"/>
        </span>
  

    </xsl:template>
    
    
    
    <xsl:template match="biblScope[@unit='volume']" mode="metadata">
        <div>
            <div class="metadataLabel">Volume</div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    
    <xsl:template match="bibl/title[@level='a']" mode="metadata"/>
    
    <xsl:template match="bibl/title[@level='j']" mode="metadata">
        <div>
            <div class="metadataLabel">Journal</div>
            <div>
                <xsl:apply-templates mode="tei"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="biblScope[@unit='issue']" mode="metadata">
        <div>
            <div class="metadataLabel">Issue</div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    <xsl:template match="biblScope[@unit='page']" mode="metadata">
        <div>
            <div class="metadataLabel">Page Range</div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    
    <xsl:template match="publisher | distributor" mode="metadata">
        <div>
            <div class="metadataLabel">
                <xsl:choose>
                    <xsl:when test="self::publisher">Publisher</xsl:when>
                    <xsl:otherwise>Distributor</xsl:otherwise>
                </xsl:choose>
            </div>
            <div>
                <xsl:choose>
                    <xsl:when test="@ref">
                        <xsl:variable name="tempEl" as="element(name)">
                            <tei:name ref="{@ref}">
                                <xsl:choose>
                                    <xsl:when test="title">
                                        <xsl:sequence select="title/node()"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:sequence select="node()"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </tei:name>
                        </xsl:variable>
                        <xsl:apply-templates select="$tempEl" mode="tei"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="if (title) then title/node() else node()" mode="tei"/>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="idno[preceding-sibling::distributor]" mode="metadata">
        <div>
            <div class="metadataLabel">Identification Number</div>
            <div>
                <xsl:apply-templates mode="tei"/>
            </div>
        </div>
    </xsl:template>
    
    
    <!--We only have one template to match pubPlace but we want to capture all of them in one block.-->
    <xsl:template match="bibl/pubPlace" mode="metadata">
            <xsl:choose>
                <xsl:when test="(parent::bibl[count(pubPlace) gt 1] and not(preceding-sibling::pubPlace)) or parent::bibl[count(pubPlace) =1]">
                    <div>
                        <div class="metadataLabel">Publication Place</div>
                        <div>
                            <xsl:value-of select="string-join(parent::bibl/pubPlace,', ')"/>
                        </div>
                    </div>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
    </xsl:template>
    
    <xsl:template match="title[@level='m']" mode="metadata">
        <xsl:choose>
            <!--If there's no preceding title/@level='a', then this is the only title, which already appears above-->
            <xsl:when test="not(preceding::title[@level='a'])"/>
            <xsl:otherwise>
                <div>
                    <div class="metadataLabel">Monograph Title</div>
                    <div>
                        <xsl:apply-templates mode="tei"/>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="bibl/date" mode="metadata">
        <div>
            <div class="metadataLabel">Date</div>
            <div>
                <xsl:value-of select="wea:formatDate(.)"/>
            </div>
        </div>
    </xsl:template>
    
    
    
    <xsl:template match="titleStmt/title | publicationStmt| profileDesc | encodingDesc" mode="metadata"/>
    
    <xsl:template match="revisionDesc" mode="metadata">
        <xsl:variable name="status" select="wea:getDocStatus(ancestor::TEI)" as="map(*)"/>
        <div>
            <div class="metadataLabel">Document Status</div>
            <div>
                <xsl:value-of select="$status?term"/> (<xsl:value-of select="wea:dateString($status?when)"/>)
            </div>
        </div>
        
    </xsl:template>
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
            <!--Make a virtual copy of the name to avoid something??-->
            <xsl:variable name="thisName">
                <xsl:copy-of select="."/>
            </xsl:variable>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates select="$thisName" mode="tei"/>
        </div>
    </xsl:template>
    
    
    
    
    <xsl:template name="createToolbar">
        <xsl:variable name="doc" select="ancestor::TEI" as="element(TEI)"/>
        <xsl:if test="wea:hasTranscription($doc) and wea:isObject($doc)">
            <div id="tools_container">
                <div id="tools">
                    <xsl:if test="$doc/descendant::text[descendant::div[head]]">
                        <div id="tools_toc" title="Table of Contents">
                            <a class="toolbar_item" href="#toc_content">
                                <div class="mi">list</div>
                                <div class="label">Contents</div>
                            </a>
                        </div>
                    </xsl:if>
                    
                    
                   <!-- <xsl:if test="//text[@facs] or ancestor::TEI/@xml:id='SunnySan1'">
                        <div id="tools_facsimiles">
                            <a class="toolbar_item" href="#tools_facsimiles_content">
                                <div class="mi">photo_library</div>
                                <div class="label">Facsimiles</div>
                            </a>
                            
                        </div>  
                    </xsl:if>-->
                    
     
                    
                    <xsl:if test="//abstract">
                        <div id="tools_headnote">
                            <a class="toolbar_item" href="#headnote_content">
                                <div class="mi">description</div>
                                <div class="label">Headnote</div>
                            </a>
                        </div>
                    </xsl:if>
                    
                    
                <!--    
                    <xsl:if test="//pb">
                        <div id="tools_pagebreaks">
                            <a class="toolbar_item" id="tools_pagebreaks_link" href="#tools_facsimiles_togglePb">
                                <div class="mi">vertical_align_center</div>
                                <div class="label">Toggle pages</div>
                            </a>
                        </div>
                    </xsl:if>-->
                    
                    <div id="tools_cite">
                        <a class="toolbar_item" href="#{ancestor::TEI/@xml:id}_citation_MLA">
                            <div class="mi">bookmark</div>
                            <div class="label">Cite</div>  
                        </a>
                    </div>
                    
                    <div id="tools_info">
                        <a class="toolbar_item" href="#credits_content">
                            <div class="mi">info</div>
                            <div class="label">Metadata</div>
                        </a>
                    </div>
          
                    
                    <div id="tools_feedback">
                        <a class="toolbar_item" href="#feedback">
                            <div class="mi">feedback</div>
                            <div class="label">Contact</div>
                        </a>
                    </div>
                    
                    <xsl:variable name="docStatus" select="wea:getDocStatus($doc)" as="map(*)"/>
                    <div id="tools_status">
                        <a class="toolbar_item badge {$docStatus?ident}" href="#status">
                            <xsl:value-of select="$docStatus?term"/> (<xsl:value-of 
                                select="wea:dateString($docStatus?when)"/>)
                        </a>
                    </div>
                    
<!--  

                    <div id="unhighlightButton" class="tool_search">
                        <a>
                            <div class="mi">
                                <span class="toggle-unhighlight">highlight_off</span>
                                <span class="toggle-highlight">highlight</span>
                            </div>
                            <div class="label">
                                <span class="toggle-unhighlight">Unhighlight matches</span>
                                <span class="toggle-highlight">Highlight matches</span></div>  
                        </a>
                        
                        
                        
                    </div>
                    
                    <div id="goToPrevSearch" class="tool_search">
                        <a>
                            <div class="mi">keyboard_arrow_left</div>
                            <div class="label">Previous match</div>
                        </a>
                        
                        
                        
                    </div>
                    
                    <div id="goToNextSearch" class="tool_search">
                        <a>
                            <div class="mi">keyboard_arrow_right</div>
                            <div class="label">Next match</div>
                        </a>
                        
                        
                    </div>-->
                    
                </div>
            </div>
            
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>