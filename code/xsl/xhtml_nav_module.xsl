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
            <xsl:for-each select="$standaloneXml">
                <div class="item">
                    <a href="{@xml:id}.html">
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
        <header>
            <nav id="nav_small">
                <div class="nav-item">
                    <a href="#nav_main" id="hamburger">
                            <div id="ham_top"/>
                            <div id="ham_middle"/>
                            <div id="ham_bottom"/>
                    </a>
                </div>
                <div class="nav-item home"><a href="index.html">WEA</a></div>
                <div class="search_icon"><a href="#headerSearch">⚲</a></div>
            </nav>
            <nav id="nav_main">
                <div class="nav-item home" id="nav_home"><a href="index.html">WEA</a></div>
                <div class="nav-item">About</div>
                <div class="nav-item">
                    <a href="#nav_archive">Archive</a>
                </div>
                <div class="nav-item" id="nav_career">Career</div>
                <div class="nav-item" id="nav_biography">Biography</div>
                <div class="nav-item" id="nav_resources">Resources</div>
                <!--                    <div class="nav-item">News</div>-->
                <div class="nav-item" id="nav_contact">Contact</div>
                <div class="nav-item search_icon" id="nav_search">
                    <a href="#headerSearch">⚲</a>
                    
                </div>
                
            </nav>
            <div id="headerSearch">
                <!--                    <div id="headerSearchInputButton" class="search_icon">
                        <a href="search.html">⚲</a>
                    </div>-->
                <div id="headerSearchInput">
                    <input type="text" id="headerSearchForm" placeholder="Title Search..."/>
                </div>
                <div id="headerAdvancedSearchBtn">
                    <a href="search.html">Go to full text search</a>
                </div>
            </div>
            <div id="nav_archive" class="nav_option">
                <xsl:for-each select="$standaloneXml[@xml:id='taxonomies']//category[ancestor::taxonomy[@xml:id='exhibit']]">
                    <div class="nav-item"><a href="{@xml:id}.html"><xsl:value-of select="catDesc/term"/></a></div>
                </xsl:for-each>
            </div>
            <xsl:copy-of select="$siteMap"/>
        </header></xsl:template>
</xsl:stylesheet>