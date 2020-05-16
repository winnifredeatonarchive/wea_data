<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 27, 2019</xd:p>
            <xd:p><xd:b>Author:</xd:b> joeytakeda</xd:p>
            <xd:p>A small template for cleaning up the static search.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    
  <!--  <xsl:template match="form[@id='ssForm']">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()[not(self::div)]"/>
            <div id="ssFieldSets" class="expandable">
                <div class="additionalInfoHeader">Advanced Search</div>  
                <div class="content">
                    <xsl:apply-templates select="div/*"/>
                </div>
            </div>
        </xsl:copy>
    </xsl:template>-->
    
    
    <xsl:template match="div[@id='staticSearch']">
        <xsl:copy>
            <xsl:apply-templates select="@*|script"/>
            <script src="js/wea_search.js"><!--Keep open--></script>
            <div class="wea-ss-filters">
                <xsl:apply-templates select="./form/div[matches(@class,'Filters')]"/>
            </div>
            <div class="wea-ss-search-and-results">
                  <xsl:apply-templates select="form"/>
                  <xsl:apply-templates select="div"/>
            </div>
        </xsl:copy>
    </xsl:template>
    
    <!--Remove initial static search init; we do it ourselves so we can manipulate the results if we want to-->
    <xsl:template match="div[@id='staticSearch']/script[not(@src)]"/>
    
    
    
    <xsl:template match="form">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()[not(self::div)]"/>
        </xsl:copy>
    </xsl:template>
    
    
    
    <xsl:template match="input[@type='text'][not(@placeholder)]">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="placeholder">Search...</xsl:attribute>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="button[@id='ssDoSearch']">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="'mi'"/>
            <xsl:text>search</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    
    
</xsl:stylesheet>