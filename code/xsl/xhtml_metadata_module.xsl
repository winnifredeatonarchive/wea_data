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
                <div id="relatedItems">
                    <xsl:call-template name="createRelatedItems"/>
                </div>
                
                <!--                <xsl:if test="$root//sourceDesc/bibl">-->
                <div id="additional_info">
                    <div class="metadataLabel" id="additional_info_header">Credits and Citations</div>
                    <div id="additional_info_content">
                        <xsl:apply-templates select="$root//respStmt" mode="metadata"/>
                        <div id="source_citation">
                            <div class="metadataLabel">Source Citation</div>
                            <div class="citationItem">
                                <xsl:apply-templates select="$root//sourceDesc/bibl/node()" mode="tei"/>
                            </div>
                            
                        </div>
                        <div id="this_citation">
                            <div class="metadataLabel">Cite this Page</div>
                            <div class="citationItem">
                                <xsl:variable name="thisCitation" as="node()+">
                                    <xsl:sequence select="$root//sourceDesc/bibl/node()"/><xsl:text> </xsl:text><tei:title level="m">The Winnifred Eaton Archive</tei:title>, edited by Mary Chapman and Jean Lee Cole, U of British Columbia.
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
                <!--</xsl:if>-->
                
            </div>
        </xsl:if>
        
    </xsl:template>
    
    
    
    
    <xsl:template name="makeMetadata">
        <!--First thing is to apply templates to the sourceDesc-->
        <xsl:apply-templates select="//sourceDesc/bibl/*" mode="metadata"/>
        <xsl:apply-templates select="//catRef" mode="metadata"/>
        <xsl:apply-templates select="//text/@next" mode="metadata"/>
        <!--I think we want the next before the prev in all cases-->
        <xsl:apply-templates select="//text/@prev" mode="metadata"/>
    </xsl:template>
    
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
    
    <xsl:template name="createRelatedItems">
        <xsl:comment>COMING SOON</xsl:comment>
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
            <div class="metadataLabel">Pseudonym</div>
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