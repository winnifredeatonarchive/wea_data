<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet is the master stylesheet for the WEA project's conversion
            from TEI P5 to XHTML5. It loads in a number of additional modules; the most significant is the "templates" module, which contains all of the basic transformation templates for the site.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:include href="globals.xsl"/>
    <xsl:include href="xhtml_modules_module.xsl"/>
    <xsl:include href="xhtml_index_module.xsl"/>
   
    <xsl:output method="xhtml" 
        encoding="UTF-8" indent="no" normalization-form="NFC" exclude-result-prefixes="#all" omit-xml-declaration="yes" html-version="5.0"/>
    
    <xsl:variable name="menu" select="$standaloneXml//TEI[@xml:id='menu']"/>
    <xsl:variable name="footer" select="$standaloneXml//TEI[@xml:id='footer']"/>

    
    <xsl:template match="/">
 
        <xsl:for-each select="wea:getWorkingDocs($standaloneXml)">
            <!--EXCLUDE INDEX FOR NOW, BUT NOT FOR LONG-->
            <xsl:if test="not(//TEI/@xml:id=('menu','footer'))">
                <xsl:result-document href="{concat($outDir,'/',//TEI/@xml:id)}.html">
                    <xsl:apply-templates select="." mode="tei"/>
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
        <xsl:call-template name="createRedirects"/>
        <xsl:call-template name="createSiteMap"/>
        <xsl:call-template name="createAjaxFrags"/>
    </xsl:template>
    
    <!--Template to create redirect pages-->
    <xsl:template name="createRedirects">
        <xsl:variable name="redirectsDoc" select="$sourceXml[//TEI[@xml:id='redirects']]//TEI" as="element(TEI)"/>
        <xsl:for-each select="$redirectsDoc//linkGrp/link">
            <xsl:variable name="target" select="tokenize(@target)" as="xs:string+"/>
            <xsl:variable name="old" select="replace($target[1],'^.+:','')"/>
            <xsl:variable name="new" select="replace($target[2],'^.+:','')"/>
            <xsl:result-document href="{$outDir || '/' || $old}.html">
                <xsl:message>Creating redirect page for <xsl:value-of select="$old"/> --> <xsl:value-of select="$new"/></xsl:message>
                <html>
                    <head>
                        <meta http-equiv="refresh" content="0; URL={$new}.html"/>
                        <title>Redirect: <xsl:value-of select="$old"/></title>
                    </head>
                    <body>
                        <p>This page does not exist. Redirecting to current URL.</p>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="createSiteMap">
        <xsl:result-document href="{$outDir || '/ajax/sitemap.html'}">
            <section>
                <xsl:for-each-group select="$standaloneXml[not(//TEI[@xml:id = ('menu','footer','redirects')])]" group-by="exists(descendant::catRef[contains(@target,'Primary')])">
                    <xsl:sort select="current-grouping-key()" order="descending"/>
                    <xsl:variable name="isPrimary" select="current-grouping-key()"/>
                    <div>
                        <h3>
                            <xsl:choose>
                                <xsl:when test="$isPrimary">Primary Sources</xsl:when>
                                <xsl:otherwise>Born Digital</xsl:otherwise>
                            </xsl:choose>
                        </h3>
                        <xsl:for-each select="current-group()">
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
                </xsl:for-each-group>
            </section>
        </xsl:result-document>

    </xsl:template>
    
    <xsl:template name="createAjaxFrags">
        <xsl:message>Creating Ajax fragments....</xsl:message>
        <xsl:for-each select="$orgMap, $personMap">
            <xsl:variable name="map" select="."/>
            <xsl:for-each select="map:keys($map)">
                <xsl:variable name="key" select="."/>
                <xsl:message>Creating <xsl:value-of select="."/></xsl:message>
                <xsl:result-document href="{$outDir}/ajax/{$key}.html">
                    <xsl:sequence select="map:get($map, $key)"/>
                </xsl:result-document>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
    

    
</xsl:stylesheet>