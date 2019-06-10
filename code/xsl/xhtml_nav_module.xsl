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
            <xsl:for-each select="$standaloneXml[not(//catRef[contains(@target,'Listing')])]">
                <div class="item">
                    <a href="{//TEI/@xml:id}.html">
                        <xsl:apply-templates select="//teiHeader/fileDesc/titleStmt[1]/title[1]/node()" mode="tei"/>
                    </a>
                    <div class="item_info">
                        <xsl:variable name="categories">
                            <xsl:apply-templates select="//catRef" mode="metadata"/>
                        </xsl:variable>
                        <xsl:for-each select="$categories/xh:div/xh:div[2]/xh:a">
                            <span><xsl:copy-of select="node()"/></span>
                        </xsl:for-each>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:variable>
    
    
    <xsl:template name="createNav">
        <xsl:variable name="temp">
            <header>
                <nav id="nav_small">
                    <div class="nav-item">
                        <a href="#nav_main" class="mi" id="hamburger">menu</a>
                    </div>
                    <div class="home"><a href="index.html">WEA</a></div>
                    <div class="search_icon"><a class="mi" href="#headerSearch">search</a></div>
                </nav>
                <nav id="nav_main">
                    <div class="mi closer"><a href="#" id="navCloser">close</a></div>
                    <div class="home" id="nav_home"><a href="index.html">WEA</a></div>
                    <div>About
                        <div>
                            <a href="about.html">About</a>
                            <a href="#">About Subpage</a>
                            <a href="technical.html">Technical</a>
                        </div>
                    </div>
                    <div>Archive
                        <div>
                            <xsl:for-each select="$standaloneXml[/TEI/@xml:id='taxonomies']//category[ancestor::taxonomy[@xml:id='exhibit']]">
                                <xsl:sort select="@n" order="ascending"/>
                                <a href="{@xml:id}.html"><xsl:value-of select="catDesc/term"/></a>
                            </xsl:for-each>
                        </div>
                    </div>
                    
                    <div>Biography
                        <div>
                            <a href="#">Bio Subpage</a>
                            <a href="#">Bio Subpage</a>
                            <a href="#">Bio Subpage</a>
                        </div>
                        
                        
                    </div>
                    <div>Resources
                        <div>
                            <a href="#">Resource Subpage</a>
                            <a href="#">Resource Subpage</a>
                            <a href="#">Resource Subpage</a>
                        </div>
                    </div>
                    <!--                    <div class="nav-item">News</div>-->
                    <div><a href="#">Contact</a></div>
                    <div class="search_icon" id="nav_search">
                        <a class="mi" href="#headerSearch">search</a>
                    </div>
                    
                </nav>
                <div id="headerSearch">
                    <!--                    <div id="headerSearchInputButton" class="search_icon">
                        <a href="search.html">⚲</a>
                    </div>-->
                    <div id="headerSearchInput">
                        <input type="text" id="headerSearchForm" placeholder="Title Search..."/>
                    </div>

                        <a href="search.html" id="headerAdvancedSearchBtn">Search the Archive</a>
                    
                </div>
                <div id="nav_archive" class="nav_option">
                    
                </div>
                <xsl:copy-of select="$siteMap"/>
            </header>
        </xsl:variable>
        <xsl:apply-templates select="$temp" mode="nav">
            <xsl:with-param name="sourceDoc" select="ancestor::TEI" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="xh:nav[@id='nav_main']/xh:div" mode="nav">
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