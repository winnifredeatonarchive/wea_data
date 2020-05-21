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
            <xd:p>This transformation contains the templates for creating the navigation menu (in the HTML header).</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:variable name="siteMap">
        <div id="siteMap">
            <div id="siteMap_input">
                <a href="search.html" id="siteMap_input_link">
                    Search the archive for <span id="siteMap_input_fill">string</span>
                </a>
            </div>
            
        </div>
    </xsl:variable>
    
    
    <xsl:template name="createNav">            
            <header>
                <nav>
                    <a class="home" href="index.html">WEA</a>
                    <a id="nav_toggle" class="hamburger mi" href="#menu_main">menu</a>
      
                    <xsl:variable name="processed">
                        <xsl:apply-templates select="$menu//list[@xml:id='menu_main']" mode="tei"/>
                    </xsl:variable>
                    <xsl:apply-templates select="$processed" mode="nav">
                        <xsl:with-param name="sourceDoc" select="ancestor::TEI" tunnel="yes"/>
                    </xsl:apply-templates>
                    
                    <div id="nav_search">
                        <label for="nav_search_input" class="hidden">Search the Archive</label>
                        <input id="nav_search_input" type="text" placeholder="Search..."/>
                        <button type="button" id="nav_search_button">
                            <span class="mi" aria-hidden="true">search</span>
                        </button>
                        <xsl:copy-of select="$siteMap"/>
                    </div>

                    <a id="header_overlay" href="#"/>
                </nav>
            </header>
    </xsl:template>
    
    <xsl:template match="xh:ul[@id='menu_main']" mode="nav">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <li class="closer">
                <a href="#" class="closer mi" id="nav_closer">close</a>
            </li>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xh:ul[@id='menu_main']/xh:li" mode="nav">
        <xsl:param name="sourceDoc" tunnel="yes"/>
        <xsl:variable name="thisId" select="$sourceDoc/@xml:id"/>
    
        <xsl:variable name="sublinkIds" select="descendant::xh:a[not(starts-with(@href,'#'))]/substring-before(@href,'.htm')" as="xs:string*"/>
       
        <xsl:variable name="containsMe" select="$sublinkIds[.=$thisId]" as="xs:string*"/>
        <xsl:variable name="categories" select="$sourceDoc//catRef[contains(@scheme,'#exhibit')]/@target/substring-after(.,'#')"/>
        <xsl:variable name="containsMyParent" select="$sublinkIds[.=$categories]" as="xs:string*"/>
        <xsl:copy>
            <xsl:if test="not(empty($containsMe)) or not(empty($containsMyParent))">
                <xsl:attribute name="class" select="'selected'"/>
            </xsl:if>
            <xsl:apply-templates select="@*|node()" mode="#current">
                <xsl:with-param name="selectedLinks" select="($containsMe, $containsMyParent)" as="xs:string*" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xh:a[not(starts-with(@href,'#'))]" mode="nav">
        <xsl:param name="selectedLinks" tunnel="yes"/>
        <xsl:variable name="thisHref" select="substring-before(@href, '.htm')"/>
        <xsl:copy>
            <xsl:if test="$thisHref = $selectedLinks">
                <xsl:attribute name="class" select="'selected'"/>
            </xsl:if>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*|node()" mode="nav" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>