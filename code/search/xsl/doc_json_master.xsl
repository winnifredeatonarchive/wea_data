<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" version="3.0"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xmlns:jt="http://github.com/joeytakeda">
    
    
    <xsl:param name="createContext" select="true()"/>
    <xsl:param name="maxContexts" as="xs:integer" select="3"/>
    
    <xsl:include href="search_globals_module.xsl"/>
    
    
    
    <xsl:template match="/">
        <xsl:message>Creating document JSON...</xsl:message>
        <xsl:call-template name="createJson"/>
    </xsl:template>
    
    <xsl:template name="createJson">
        <xsl:variable name="documents" select="collection('../../../products/xml/standalone?select=*.xml;recurse=false')"/>
        <xsl:for-each select="$documents">

            <xsl:variable name="currDoc" select="//TEI"/>
            <xsl:variable name="currId" select="$currDoc/@xml:id"/>
            <xsl:message>Processing <xsl:value-of select="$currId"/></xsl:message>
            <xsl:variable name="map">
                <map xmlns="http://www.w3.org/2005/xpath-functions">
                    <string key="docId">
                        <xsl:value-of select="$currId"/>
                    </string>
                    <array key="docTypes">
                        <map>
                            <xsl:for-each-group select="$currDoc//catRef" group-by="@scheme">
                                <array key="{current-grouping-key()}">
                                    <xsl:for-each select="current-group()">
                                        <string><xsl:value-of select="@target"/></string>
                                    </xsl:for-each>
                                </array>
                            </xsl:for-each-group>
                        </map>
                    </array>
                    <!--TODO ONCE AVAILBLE: Journal, publication dates, et cetera-->
                </map>
            </xsl:variable>
            <xsl:result-document href="../../products/js/search/docs/{$currId}.json" method="text">
                <xsl:value-of select="xml-to-json($map, map{'indent': true()})"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    
    
</xsl:stylesheet>