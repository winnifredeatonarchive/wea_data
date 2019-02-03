<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:hcmc="http://hcmc.uvic.ca/ns"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> February 1, 2019</xd:p>
            <xd:p><xd:b>Author:</xd:b> jtakeda, but original author mholmes</xd:p>
            <xd:p>This is a utility identity transform which tweaks the default output
                of the standard TEI documentation build process to make for a more human-
                friendly document.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:param name="deleteContentModel" select="true()"/>
    <xsl:param name="deleteSchemaDeclaration" select="true()"/>
    
    <xsl:output method="xhtml" html-version="5.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    
    
    <!-- Root template. -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Identity transform. -->
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy><xsl:apply-templates select="@*|node()" mode="#current"/></xsl:copy>
    </xsl:template>
    
    <!-- Switch to our own css file. -->
    <xsl:template match="link[@type='text/css']">
        <xsl:if test="not(preceding-sibling::link[@type='text/css'])">
            <link rel="stylesheet" href="code/oxygen.css" type="text/css"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="a[@href='index.html']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="body[@id='TOP']/div[contains(@class,'stdheader')][1]">
        <div>
            <h2>Winnifred Eaton Archive Project Documentation</h2>
        </div>
        <div class="note">Note that this is an abridged version of the documentation for editorial use within oXygen.
        See <a href="docs/documentation_full.html">docs/documentation_full.html</a> for full documentation.</div>
    </xsl:template>
    
    <!--Delete the schema declaration-->
    <xsl:template match="tr[td[1][matches(normalize-space(string-join(descendant::text(),'')),'[Ss]chema [Dd]eclaration')]]">
        <xsl:if test="not($deleteSchemaDeclaration)">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>

    
    <!--Delete the content model-->
    <xsl:template match="tr[td[1][matches(normalize-space(string-join(descendant::text(),'')),'[Cc]ontent [Mm]odel')]]">
        <xsl:if test="not($deleteContentModel)">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    
    <!--Delete schematron model-->
    <xsl:template match="tr[td[1][matches(normalize-space(string-join(descendant::text(),'')),'Schematron')]]">
        <xsl:if test="not($deleteContentModel)">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    
    <xsl:variable name="deleteDivsRegex" select="'(model)|(teidata)|(macro)'"/>
    
    <xsl:template match="h2[matches(normalize-space(string-join(descendant::text())),'((Datatypes)|(Macros)|(Model classes))$')]"/>
    
    <!--Delete models, teidata, and macro divs-->
    <xsl:template match="div[h3[matches(@id,concat('^(',$deleteDivsRegex,')\.'))]]"/>
    
    <!--div/h3's with ids that do not contain . must be an element-->
    <xsl:template match="div[h3[@id][not(contains(@id,'.'))]]">
        <xsl:copy>
            <xsl:attribute name="id" select="h3/@id"/>
            <xsl:apply-templates select="@*[not(local-name()='id')]|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="div/h3[not(contains(@id,'.'))]/@id"/>
    
    <xsl:template match="a[@href[matches(.,concat('^#(',$deleteDivsRegex,')'))]]">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <!--we don't use these classes-->
    <!--And we only are doing english-->
    <xsl:template match="td/@class | a/@class | span[@class='label']/@lang"/>
    
    <xsl:template match="span[@class='specChildElements']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="span[@class='specChildModule']">
        <span class="label">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--We'll delete comments too-->
    <xsl:template match="comment()"/>
    
    
    <xsl:template match="div/@class[not(matches(.,'\s*egXML'))]">
        <xsl:if test=".='specChildModule'">
            <xsl:copy>
                <xsl:value-of select="'label'"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="span[@class='attribute'][ancestor::div[contains(@class,'egXML')]]">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/><xsl:text>="</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="span[@class='element']/text()">
        <xsl:variable name="dq">"</xsl:variable>
        <xsl:variable name="temp">
            <xsl:analyze-string regex="{concat('^=',$dq,'$')}" select=".">
                <xsl:matching-substring/>
                <xsl:non-matching-substring>
                    <xsl:analyze-string regex="{concat('^',$dq,'&gt;$')}" select=".">
                        <xsl:matching-substring>
                            <span class="attribute">"</span>&gt;
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:value-of select="$temp"/>
    </xsl:template>
    <!--Get rid of JS-->
    <xsl:template match="script"/>
    
    <!-- Get rid of empty ul elements. -->
    <xsl:template match="ul[not(li)]"/>
    
    <!-- Get rid of pointless itemprop attribute.  -->
    <xsl:template match="@itemprop"/>
    
    <!-- Section headers should be h2s.  -->
    <xsl:template match="section/header/h1 | section/h1">
        <h2><xsl:apply-templates select="@*|node()"/></h2>
    </xsl:template>
    
    <!-- Subsection headings should be h3s. -->
    <xsl:template match="section/div/h2">
        <h3><xsl:apply-templates select="@*|node()"/></h3>
    </xsl:template>
    
    <!-- Get rid of the meta charset element, since we already 
     get the http-equiv one from Saxon and both should not 
     be present. -->
    <xsl:template match="meta[@charset]"/>
    
    
    
</xsl:stylesheet>