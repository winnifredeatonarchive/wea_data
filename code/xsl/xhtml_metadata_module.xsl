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
                        <xsl:call-template name="makeMetadata"/>
                    </div>
                </div>
                
                <!--                <xsl:if test="$root//sourceDesc/bibl">-->
                
                
                <div id="additional_info">
                    <xsl:call-template name="createCreditsAndCitations"/>
                    <xsl:call-template name="createRelatedItems"/>
                    <xsl:call-template name="createTOC"/>
                </div>

                
                
                <!--</xsl:if>-->
                
            </div>
        </xsl:if>
        
    </xsl:template>
    
    
    
    <xsl:template name="createCreditsAndCitations">
        <xsl:variable name="root" select="ancestor::TEI"/>
        <div id="credits" class="additionalInfo">
            <div class="metadataLabel additionalInfoHeader" id="credits_header">Credits and Citations</div>
            <div id="credits_content" class="additionalInfoContent">
                <xsl:apply-templates select="$root//respStmt" mode="metadata"/>
                <xsl:if test="$root//sourceDesc/bibl[note]">
                    <div>
                        <div class="metadataLabel">Notes</div>
                        <xsl:for-each select="$root//sourceDesc/bibl/note">
                            <div>
                                <xsl:apply-templates select="node()" mode="tei"/>
                            </div>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <div id="source_citation">
                    <div class="metadataLabel">Source Citation</div>
                    <div class="citationItem">
                        <xsl:apply-templates select="$root//sourceDesc/bibl/node()[not(self::note)]" mode="tei"/>
                    </div>
                    
                </div>
                <div id="this_citation">
                    <div class="metadataLabel">Cite this Page</div>
                    <div class="citationItem">
                        <xsl:variable name="thisCitation" as="node()+">
                            <xsl:sequence select="$root//sourceDesc/bibl/node()[not(self::note)]"/><xsl:text> </xsl:text><tei:title level="m">The Winnifred Eaton Archive</tei:title>, edited by Mary Chapman and Jean Lee Cole, U of British Columbia.
                        </xsl:variable>
                        <xsl:apply-templates select="$thisCitation" mode="tei"/>
                    </div>
                    
                </div>
                <div id="xmlVersions">
                    <div class="metadataLabel">Download XML</div>
                    <xsl:variable name="tempList">
                        <tei:list>
                            <tei:item><tei:ref target="xml/original/{//ancestor::TEI/@xml:id}.xml">Original XML</tei:ref></tei:item>
                            <tei:item><tei:ref target="xml/standalone/{//ancestor::TEI/@xml:id}.xml">Standalone XML</tei:ref></tei:item>
                        </tei:list>
                    </xsl:variable>
                    <div>
                        <xsl:apply-templates select="$tempList" mode="tei"/>
                    </div>
                </div>
            </div>
            
            <!--                        <div id="wea_citation">
                            <div class="metadataLabel">Full Citation</div>
                            <xsl:apply-templates select=""
                        </div>-->
        </div>
    </xsl:template>
    
    
    <xsl:template name="createRelatedItems">
        <xsl:if test="ancestor::TEI//relatedItems">
            <div id="relatedItems" class="additionalInfo">
                <div class="metadataLabel additionalInfoHeader" id="relatedItems_header">Related Items</div>
                <div class="additionalInfoContent">
                </div>
            </div>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="createTOC">
        <xsl:variable name="toc">
            <xsl:apply-templates select="ancestor::TEI" mode="toc"/>
        </xsl:variable>
        <xsl:if test="exists($toc/item)">
            <div id="toc" class="additionalInfo">
                <div class="metadataLabel additionalInfoHeader" id="toc_header">Table of Contents</div>
                <div class="additionalInfoContent">
                    <xsl:sequence select="$toc"/>
                </div>
            </div>
            
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
                    <xsl:apply-templates select="div[head]" mode="#current"/>
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
        <xsl:apply-templates select="//sourceDesc/bibl/*" mode="metadata"/>
        <xsl:apply-templates select="//catRef" mode="metadata"/>
        <xsl:apply-templates select="//text/@next" mode="metadata"/>
        <!--I think we want the next before the prev in all cases-->
        <xsl:apply-templates select="//text/@prev" mode="metadata"/>
    </xsl:template>
    
    <xsl:template match="bibl/note" mode="metadata"/>
    
    <xsl:template match="text/@next | text/@prev" mode="metadata">
        <div>
            <div class="metadataLabel"><xsl:value-of select="if (local-name()='next') then 'Next' else 'Previous'"/> Installment</div>
            <div><a href="{wea:resolveTarget(.)}"><xsl:apply-templates select="wea:getTitle(substring-before(.,'.xml'))" mode="tei"/></a></div>
        </div>
    </xsl:template>
    
    <xsl:template match="catRef" mode="metadata">
        <xsl:variable name="target" select="@target"/>
        <xsl:variable name="scheme" select="@scheme"/>
        <xsl:variable name="thisSchemeTitle" select="$standaloneXml//taxonomy[@xml:id=substring-after($scheme,'#')]/bibl/node()"/>
        <xsl:variable name="thisTargetTitle" select="$standaloneXml//category[@xml:id=substring-after($target,'#')]/catDesc/node()"/>
        <div>
            <div class="metadataLabel"><xsl:apply-templates select="$thisSchemeTitle" mode="tei"/></div>
            <div><a href="{substring-after($target,'#')}.html"><xsl:apply-templates select="$thisTargetTitle" mode="tei"/></a></div>
        </div>
    </xsl:template>
  
    
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
    
    
    
    
    
    <xsl:template match="teiHeader" mode="metadata">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="sourceDesc/bibl" mode="metadata">
        <xsl:apply-templates select="*" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="bibl/author" mode="metadata">
        <div>
            <div class="metadataLabel">
                <xsl:choose>
                    <xsl:when test="name/@ref='#WE1'">
                        Pseudonym
                    </xsl:when>
                    <xsl:otherwise>
                        Author
                    </xsl:otherwise>
                </xsl:choose>
            </div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    
    <xsl:template match="bibl/biblScope[@unit='volume']" mode="metadata">
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
    <xsl:template match="bibl/biblScope[@unit='issue']" mode="metadata">
        <div>
            <div class="metadataLabel">Issue</div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    <xsl:template match="bibl/biblScope[@unit='page']" mode="metadata">
        <div>
            <div class="metadataLabel">Page Range</div>
            <div><xsl:apply-templates mode="tei"/></div>
        </div>
    </xsl:template>
    
    <xsl:template match="bibl/publisher" mode="metadata">
        <div>
            <div class="metadataLabel">Publisher</div>
            <div><xsl:apply-templates mode="tei"/></div>
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
    
</xsl:stylesheet>