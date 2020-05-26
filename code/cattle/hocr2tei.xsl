<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://tei-c.org/ns/1.0"
    xmlns:tei='http://tei-c.org/ns/1.0'
    xmlns:jt="https://joeytakeda.github.io/ns/1.0"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 13, 2019</xd:p>
            <xd:p><xd:b>Author:</xd:b> Joey Takeda</xd:p>
            <xd:p>This stylesheet convert the tesseract HOCR (html-OCR) format into a standardized TEI
            format.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <!--We're outputting the XHTML-ish to TEI-->
    <xsl:output method="xml" indent="true" suppress-indentation="p q"/>
    
    <xsl:include href="../../data/sch/weaQuickFixTemplates.xsl"/>
    
    <xsl:variable name="docs" select="collection('../cattle_tmp/body?select=*.hocr')"/>
    
    <xsl:template match="/">
        <xsl:result-document href="../cattle_tmp/cattle-body.xml">
            <text>
                

                     <xsl:variable name="tmp">
                         <xsl:call-template name="structure">
                             <xsl:with-param name="content">
                                 <body>
                                     <xsl:for-each select="$docs//body">
                                         <xsl:sort select="document-uri(root(.))"/>
                                         <xsl:message>Processing <xsl:value-of select="document-uri(root(.))"/></xsl:message>
                                         <xsl:apply-templates select=".">
                                             <xsl:with-param name="pos" select="position() + 6" tunnel="yes"/>
                                         </xsl:apply-templates>
                                     </xsl:for-each>
                                 </body>
                                 
                             </xsl:with-param>
                         </xsl:call-template>
                     </xsl:variable>
                     <xsl:apply-templates select="$tmp" mode="final"/>
            </text>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="*:q" mode="final">
        <q><xsl:apply-templates mode="#current"/></q>
    </xsl:template>
    
    <xsl:template match="*:q/text()" mode="final">
        <xsl:message>??</xsl:message>
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    <xsl:template match="text()" mode="final">
        <xsl:value-of select="replace(.,'\s+',' ')"/>
    </xsl:template>
    
 
    
    <xsl:template name="structure">
        <xsl:param name="content" as="node()+"/>
        <xsl:param name="pos" tunnel="yes"/>
        <xsl:apply-templates select="$content" mode="structure">
            <xsl:with-param name="pos" select="$pos" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:mode name="structure" on-no-match="shallow-copy"/>
    <xsl:mode name="final" on-no-match="shallow-copy" exclude-result-prefixes="#all"/>
    
   
    <xsl:template match="tei:body" mode="structure">
        <xsl:copy>
            <xsl:for-each-group select="*" group-starting-with="tei:head">
                <xsl:choose>
                    <xsl:when test="some $c in current-group() satisfies $c/self::tei:head">
                        <div type="chapter" n="{position()-1}">
                            <xsl:apply-templates mode="#current" select="current-group()"/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="current-group()" mode="#current"/>
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:for-each-group>
        </xsl:copy>
        
    </xsl:template>
    
    <xsl:template match="tei:p" mode="structure">
        <xsl:choose>
            <xsl:when test="preceding-sibling::*[1]/self::tei:pb and not(*) and matches(text(),'Cattle','i')"/>
            <xsl:when test="following-sibling::*[1]/self::tei:pb and not(*) and matches(text(),'^\s*\d+\s*$')"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:variable name="replaced">
                        <xsl:call-template name="replaceApos">
                            <xsl:with-param name="useDq" select="true()"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:variable name="tagged">
                        <xsl:for-each select="$replaced">
                            <xsl:call-template name="tagQuote">
                                <xsl:with-param name="left">“</xsl:with-param>
                                <xsl:with-param name="right">”</xsl:with-param>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:apply-templates select="$tagged" mode="#current"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="tei:q" mode="structure">
        <xsl:copy>
            <xsl:apply-templates mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:q/text()" mode="structure">
            <xsl:value-of select="normalize-space()"/>
        
    </xsl:template>
    <xsl:template match="tei:fw[@type='pageHeading']" mode="structure">
        <xsl:copy-of select="."/>
        <xsl:text>&#xA;&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:anchor" mode="structure"/>
    
    
    <!--Each page is a <div> but we want to flatten that in the TEI output,
        so create a self-closing <pb/> milestone and process its contents-->
    <xsl:template match="div[@class='ocr_page']">
        <!--We started at page 7-->
        <xsl:param name="pos" tunnel="yes" as="xs:integer"/>
        <pb n="{$pos}"/>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--Just process the inner contents of the ocr-area-->
    <xsl:template match="div[@class='ocr_carea']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--Now we're in an interesting situation where the first para is almost always the header
        and the last is always the page number-->
    
    <!--TO DO: Fix this: the templates have to be a bit smarter at detecting what precisely is going on here.
        
        It might be better to do this in a few passes:
        1) Get rid of the spans completely and normalize spacing
        2) Then, determine various structural components using string match (i.e. if something matches ^\s*\[\s*\d+\s*\]\s*$
        then it's a page number. If something matches HIS ROYAL NIBS,
        then it's a heading. And then we can also determine chapter headings, and then use that heading to create a better structure overall.
        
        The overall goal will be to create a number of analytic outputs for the digital edition, including various speech prefixes and other textual tools (perhaps a Bechdel test type interface, et cetera) in order to create a full edition.
        
        I also need to discuss with MC what sort of project this could be: it could, on the one hand, be an edition built outside of the WEA constraints (since there are many for that archive) but that I then contribute a "santized" version that elimainates much of the dense encoding. It would also need to then receive the texts from the WEA; perhaps part of the project could then be a crosswalk from this structure to the WEA's?-->
        
    
    <xsl:template match="p[@class='ocr_par']">
        <xsl:if test="string-join(descendant::text(),'') => normalize-space() => string-length() gt 0">
            <xsl:variable name="paraParams" select="jt:makeParaMap(.)"/>
            <xsl:variable name="pgHeading" select="$paraParams('isPageHeading')" as="xs:boolean"/>
            <xsl:variable name="pgNum" select="$paraParams('isPageNum')" as="xs:boolean"/>
            <xsl:variable name="chapHead" select="$paraParams('isChapterHeading')" as="xs:boolean"/>
            <xsl:if test="not($pgHeading or $pgNum)">
                <xsl:element name="{if ($chapHead) then 'head' else 'p'}">
                    <xsl:apply-templates>
                        <xsl:with-param name="paraParams" select="$paraParams" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:function name="jt:makeParaMap" as="map(xs:string, xs:boolean)">
        <xsl:param name="p" as="element(p)"/>
        <xsl:map>
            <xsl:map-entry key="'isPageHeading'" select="jt:isPageHeading($p)"/>
            <xsl:map-entry key="'isPageNum'" select="jt:isPageNum($p)"/>
            <xsl:map-entry key="'isChapterHeading'" select="jt:isChapterHeading($p)"/>
        </xsl:map>
    </xsl:function>
    
    <xsl:function name="jt:isPageHeading" as="xs:boolean">
        <xsl:param name="p" as="element(p)"/>
        <xsl:variable name="isFirst" select="empty($p/parent::div/preceding-sibling::div)" as="xs:boolean"/>
        <xsl:variable name="span" select="$p//span[@class='ocrx_word']" as="element(span)+"/>
        <xsl:variable name="hasHeadingText" select="matches(string-join($span),'Cattle|Cattle','i')" as="xs:boolean"/>
        <xsl:sequence select="$isFirst and $hasHeadingText"/>
    </xsl:function>
    
    <xsl:function name="jt:isPageNum" as="xs:boolean">
        <xsl:param name="p" as="element(p)"/>
        <xsl:variable name="isLast" select="empty($p/parent::div/following-sibling::div)" as="xs:boolean"/>
        <xsl:variable name="words" select="$p//span[@class='ocrx_word']" as="element(span)+"/>
        <xsl:variable name="pageNumbery" select="count($words) = (2 to 3) and (some $w in $words satisfies matches($w,'^\d+') and (some $b in $words satisfies ($b,'\[|\]')))" as="xs:boolean"/>
        <xsl:value-of select="$isLast and $pageNumbery"/>
    </xsl:function>
    
    <xsl:function name="jt:isChapterHeading" as="xs:boolean">
        <xsl:param name="p" as="element(p)"/>
        <xsl:variable name="words" select="$p//span[@class='ocrx_word']" as="element(span)+"/>
        <xsl:variable name="chapterHeadingLike" select="matches(string-join($words,''),'^\s*CHAPTER')" as="xs:boolean"/>
        <xsl:value-of select="$chapterHeadingLike"/>
    </xsl:function>
    
    <xsl:template match="p/text()"/>
    
    <xsl:template match="span[@class='ocr_line']">
        <xsl:if test="exists(preceding-sibling::span[@class='ocr_line'])"><xsl:text>&#x9;&#x9;&#x9;&#xA;</xsl:text></xsl:if>
        <xsl:for-each select="span">
            <xsl:apply-templates select="."/><xsl:if test="not(position() = last())"><xsl:text> </xsl:text></xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    
        
        
    <xsl:template match="span[@class='ocrx_word']/text()">
        <xsl:variable name="dq">"</xsl:variable>
        <xsl:value-of select="replace(.,'”’|“‘|“|(‘‘)|(’’)|‘'||$dq||'\*|”|“’|^\*$|^\*\*$',$dq)"/>
     </xsl:template>
        
    
    
    
    
</xsl:stylesheet>