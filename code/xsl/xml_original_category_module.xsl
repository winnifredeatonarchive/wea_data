<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
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
    
   
    
    
    <!--**************************************************************
       *                                                            * 
       *                     Output                                 *
       *                                                            *
       **************************************************************-->
    
    <xsl:output method="xml" indent="yes"/>
    
    <!--**************************************************************
       *                                                            * 
       *                     Variables                              *
       *                                                            *
       **************************************************************-->
    
    <xsl:variable name="sourceTax" select="$sourceXml[/TEI/@xml:id='taxonomies']//taxonomy"/>
    
    
    <xsl:variable name="noContent" as="element(body)">
        <body>
            <p>No documents available at this time.</p>
        </body>
    </xsl:variable>
    
    
    <!--**************************************************************
       *                                                            * 
       *                     Templates                              *
       *                                                            *
       **************************************************************-->
    
    
    <xd:doc>
        <xd:desc>Root template, which applies templates only to the document taxomies categories</xd:desc>
    </xd:doc>
    <xsl:template name="createCategoryPages">
        <xsl:apply-templates select="$sourceTax/category" mode="root"/>
    </xsl:template>
    
    
    <!--**************************************************************
       *                                                            * 
       *                     Templates: root                        *
       *                                                            *
       **************************************************************-->
    
    <xd:doc>
        <xd:desc>Template category to create both the subcategory page and the category listing page itself.</xd:desc>
    </xd:doc>
    <xsl:template match="category" mode="root">
        <xsl:variable name="thisCat" select="." as="element(category)"/>
        
        <!--If there's a child category, then we'll want to make a 
            subcategory listing page for this category too-->
        <xsl:if test="category and (every $c in category satisfies (not(empty(wea:getCatDocs($c/@xml:id)))))">
            <xsl:call-template name="makePage">
                <xsl:with-param name="content" as="element(body)">
                    <xsl:apply-templates select="$thisCat" mode="sub"/>
                </xsl:with-param>
                <xsl:with-param name="thisCat" select="." as="element(category)"/>
                <xsl:with-param name="appendSub" select="true()" as="xs:boolean"/>
            </xsl:call-template>
        </xsl:if>
        
        <!--Make the full page-->
        <xsl:call-template name="makePage">
            <xsl:with-param name="content" as="element(body)">
                <xsl:apply-templates select="$thisCat" mode="full"/>
            </xsl:with-param>
            <xsl:with-param name="thisCat" select="." as="element(category)"/>
            <xsl:with-param name="appendSub" select="false()" as="xs:boolean"/>
        </xsl:call-template>
        
        <!--And now apply the template to any children categories-->
        <xsl:apply-templates select="category" mode="#current"/>
    </xsl:template>
    
    <!--**************************************************************
       *                                                            * 
       *                     Templates: sub                         *
       *                                                            *
       **************************************************************-->
    
    
    <xd:doc>
        <xd:desc>Category template in mode='sub'; note that we do not apply templates here</xd:desc>
    </xd:doc>
    <xsl:template match="category" mode="sub">
        <body>
            <head><xsl:sequence select="catDesc/term/node()"/>: Subcategories</head>
            <div>
                <xsl:sequence select="catDesc/note/p"/>
                <list>
                    <!--For every child category, make an item-->
                    <xsl:for-each select="category">
                        <xsl:if test="not(empty(wea:getCatDocs(@xml:id)))">
                            <item><ref target="doc:{@xml:id}"><xsl:value-of select="normalize-space(catDesc/term/text()[1])"/></ref></item>
                        </xsl:if>
                    </xsl:for-each>
                </list>
                <!--TODO: Replace with boilerplate string-->
                <p><ref target="doc:{@xml:id}">View all documents in this category.</ref></p>
            </div>
        </body>
        
        
    </xsl:template>
    
    
    <!--**************************************************************
       *                                                            * 
       *                     Templates: full                        *
       *                                                            *
       **************************************************************-->
    
    
    <xd:doc>
        <xd:desc>Category template in mode=full; this is where the full listing of documents in a category goes</xd:desc>
    </xd:doc>
    <xsl:template match="category" mode="full">
        <xsl:variable name="thisCat" select="@xml:id" as="xs:string"/>
        
        
        <body>
            <xsl:if test="ancestor::taxonomy[@xml:id='exhibit']">
                <div type="exhibitInfo">
                    <xsl:copy-of select="catDesc/note/node()"/>
                </div>
            </xsl:if>
            <div>
                <xsl:if test="not(ancestor::taxonomy[@xml:id='exhibit'])">
                    <head><xsl:sequence select="catDesc/term/node()"/></head>   
                </xsl:if>
            
             
                
                <table type="exhibit">
                    <row role="label">
                        <cell/>
                        <cell>Title</cell>
                        <cell role="sortkey">Date Published</cell>
                        <cell>Transcription Available</cell>
                    </row>
                    <!--A small function to get the category docs for this category-->
                    <xsl:for-each select="wea:getCatDocs(@xml:id)">
                        <xsl:variable name="thisDoc" select="." as="element()"/>
                        <xsl:variable name="docId" select="$thisDoc/@xml:id" as="xs:string"/>
                        
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
                                <ref target="doc:{$docId}"><xsl:copy-of select="$thisDoc//teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref>
                            </cell>
                            <cell>
                                <xsl:choose>
                                    <xsl:when test="$thisDoc//sourceDesc/bibl[@copyOf]">
                                        <xsl:variable name="biblId" select="replace($thisDoc//sourceDesc/bibl/@copyOf,':','')"/>
                                        <xsl:variable name="biblDate" select="$sourceXml[//TEI[@xml:id='bibliography']]//bibl[@xml:id=$biblId]/date[1]"/>
                                        <xsl:choose>
                                            <xsl:when test="not(empty($biblDate))">
                                                <xsl:sequence select="wea:formatDate($biblDate)"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <date/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <date/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                
                            </cell>
                            <cell>
                                <xsl:choose>
                                    <xsl:when test="normalize-space(string-join($thisDoc//text,'')) ne ''">
                                        <xsl:text>Yes</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>No</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </cell>
                        </row>
                    </xsl:for-each>
                </table>
            </div>
            
        </body>
        
        
    </xsl:template>
    
    
    <!--**************************************************************
       *                                                            * 
       *                     Named templates                        *
       *                                                            *
       **************************************************************-->
    
    <xd:doc>
        <xd:desc>The <xd:ref type="template" name="makePage">makePage</xd:ref> creates the result TEI document from a category listing.</xd:desc>
        <xd:param name="thisCat">The tei:category that is being processed.</xd:param>
        <xd:param name="content">The content to inject into the TEI text/body. Note that the content is usually created
            by applying templates to the category in either full or sub mode.</xd:param>
        <xd:param name="appendSub">A boolean value to pass onto the teiHeader template.</xd:param>
        <xd:return>A TEI result document.</xd:return>
    </xd:doc>
    <xsl:template name="makePage">
        <xsl:param name="thisCat" as="element(category)"/>
        <xsl:param name="content"/>
        <xsl:param name="appendSub"/>
        <xsl:variable name="thisId" select="if ($appendSub) then concat($thisCat/@xml:id,'_subcategories') else $thisCat/@xml:id"/>
        <xsl:variable name="outDoc" select="concat($outDir,'xml/original/',$thisId,'.xml')"/>
        <xsl:variable name="title" select="if ($appendSub) then concat(normalize-space(catDesc/term/text()[1]),': Subcategories') else normalize-space(catDesc/term/text()[1])" as="xs:string"/>
        <xsl:variable name="categories">wdt:docBornDigitalListing</xsl:variable>
       <xsl:if test="not(empty(wea:getCatDocs($thisCat/@xml:id)))">
           <xsl:call-template name="generateTeiPage">
               <xsl:with-param name="outDoc" select="$outDoc"/>
               <xsl:with-param name="thisId" select="$thisId"/>
               <xsl:with-param name="title" select="$title"/>
               <xsl:with-param name="categories" select="$categories"/>
               <xsl:with-param name="content">
                   <xsl:choose>
                       <xsl:when test="empty(wea:getCatDocs($thisCat/@xml:id))">
                           <xsl:copy-of select="$noContent"/>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:copy-of select="$content"/>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:with-param>
           </xsl:call-template>
       </xsl:if>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>The <xd:ref name="wea:getCatDocs" type="function">hcmc:getCatDocs</xd:ref> functions returns the category documents
            from the source data. It may be changed in future so that it can be used for any document set (i.e. standard, standalone, et cetera).</xd:desc>
        <xd:param name="id">The category id to check.</xd:param>
        <xd:return>0 or more TEI documents</xd:return>
    </xd:doc>
    <xsl:function name="wea:getCatDocs" as="element(TEI)*">
        <xsl:param name="id" as="xs:string"/>
        <xsl:sequence select="$sourceXml//TEI[not(@xml:id=('redirects','footer','menu'))][descendant::catRef[starts-with(@target,concat('wdt:',$id))]]"/>
    </xsl:function>
    

</xsl:stylesheet>