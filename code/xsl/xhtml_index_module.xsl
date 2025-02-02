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
            <xd:p>Created on: June 20, 2019.</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet creates the index page for the Winnifred Eaton Archive, which is a specialized
                page that needs more than the standard DOM produced from the TEI (which is kept in info/index.xml).
            Rather than create the blocks in sequence, we wrap them in special divisions; in other words, the order of the elements in the TEI does not determine the final rendering order of the index page.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <!--We've already got the main text, so now it's just slotting bits in-->
    <xsl:template name="createIndexPage">
        <xsl:apply-templates select="//div[@xml:id='index_header']" mode="tei"/>
        <div class="container">
            <div class="row">
                <div class="left">
                    <xsl:apply-templates select="//div[@xml:id='index_info']" mode="tei"/>
                    <div id="index_featuredItemsWrapper">
                        <xsl:apply-templates select="//div[@xml:id='index_featuredItems']" mode="tei"/>
                    </div>

                </div>
                <div class="middle-spacer"/>
                <xsl:apply-templates select="//div[@xml:id='index_archive']" mode="tei"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@xml:id='index_featuredItems']" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates select="head" mode="#current"/>
            <xsl:for-each select="//div[@xml:id='index_featuredItems']/list/item">
                <a  href="#index_featuredItems_{position()}" id="index_featuredItems_{position()}">
                    <xsl:if test="position() = 1">
                        <xsl:attribute name="class" select="'selected'"/>
                    </xsl:if>
                    <xsl:value-of select="position()"/>
                </a>
            </xsl:for-each>
            <xsl:apply-templates select="node()[not(self::head)]" mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template name="createIndexStyles">
        <style>
            <xsl:variable name="items" select="//div[@xml:id='index_featuredItems']/list/item"/>
            <xsl:variable name="itemCount" select="count($items)"/>
                <xsl:for-each select="$items">
                    <xsl:if test="position() gt 1">
                        <xsl:variable name="pos" select="position()" as="xs:integer"/>
                        <xsl:for-each select="1 to $itemCount">
                            <xsl:variable name="i" select="."/>
                            #index_featuredItems_<xsl:value-of select="$pos"/>:target ~ ul li:nth-child(<xsl:value-of select="$i"/>),
                            #index_featuredItems_<xsl:value-of select="$pos"/>.selected ~ ul li:nth-child(<xsl:value-of select="$i"/>)<xsl:if test="not($i = $itemCount)">,</xsl:if>
                        </xsl:for-each>
                        { transform: translateX(-<xsl:value-of select="100 * ($pos - 1)"/>%);}
                    </xsl:if>
                </xsl:for-each>
        </style>
    </xsl:template>
    
</xsl:stylesheet>