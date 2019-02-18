<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:hcmc="http://hcmc.uvic.ca/ns" version="3.0"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xmlns:jt="http://github.com/joeytakeda">
    
    
    <xsl:param name="createContext" select="true()"/>
    
    <xsl:include href="search_globals_module.xsl"/>


    <xsl:template match="/">
        <xsl:call-template name="createJson"/>
    </xsl:template>
    
    <xsl:template name="createJson">
        <xsl:variable name="stems" select="$tokenizedDocs//span[@data-stem]" as="element(span)*"/>
        <xsl:variable name="distinctStems" select="distinct-values(for $r in (for $n in $stems return normalize-space($n)) return if ($r ne '') then $r else ())"/>
        <xsl:variable name="distinctCount" select="count($distinctStems)"/>
        <xsl:call-template name="createMap">
            <xsl:with-param name="stems" select="$stems"/>   
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="createMap">
        <xsl:param name="stems"/>
        <xsl:for-each-group select="$stems" group-by="@data-stem">
            <xsl:variable name="token" select="current-grouping-key()"/>
            <xsl:message>Processing <xsl:value-of select="$token"/></xsl:message>
            <xsl:variable name="map" as="element()">
                <xsl:call-template name="makeMap">
                    <xsl:with-param name="term" select="$token"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:message>Creating <xsl:value-of select="$token"/>.json</xsl:message>
            <xsl:result-document href="../../products/js/json/{$token}.json" method="text">
                <xsl:value-of select="xml-to-json($map, map{'indent': true()})"/>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    
    
    
    <xsl:template name="makeMap">
        <xsl:param name="term"/>
            <map xmlns="http://www.w3.org/2005/xpath-functions">
                <string key="token">
                    <xsl:value-of select="$term"/>
                </string>     
                    <array key="instances">
                        <xsl:for-each-group select="current-group()" group-by="ancestor::html/@id">
                            <xsl:sort select="count($tokenizedDocs//html[@id=current-grouping-key()]/descendant::span[@data-stem=$term])" order="descending"/>
                            <xsl:variable name="docId" select="current-grouping-key()"/>
                            <xsl:variable name="thisDoc" select="current-group()[1]/ancestor::html"/>
                            <xsl:variable name="spans" as="element(span)+" select="$thisDoc//span[@data-stem=$term]"/>
                            <xsl:variable name="docTitle" select="$thisDoc/head/title[1]"/>
                            
                           
                            <map xmlns="http://www.w3.org/2005/xpath-functions">
                                <string key="docId">
                                    <xsl:value-of select="$docId"/>
                                </string>
                                <string key="docTitle">
                                    <xsl:value-of select="$docTitle"/>
                                </string>
                                
                                <number key="count">
                                    <xsl:value-of select="count($spans)"/>
                                </number>
                                <xsl:if test="$createContext">
                                    <array key="contexts">
                                        <xsl:for-each select="$spans">
                                            <xsl:variable name="term" select="text()"/>
                                            <xsl:variable name="context" select="hcmc:returnContext(.)"/>
                                            <map>
                                                <string key="term"><xsl:value-of select="$term"/></string>
                                                <string key="context"><xsl:value-of select="$context"/></string>
                                            </map>
                                        </xsl:for-each>
                                        
                                    </array>
                                </xsl:if>
                            </map>
                        </xsl:for-each-group>
                    </array>
            </map>
       
    </xsl:template>
    
    
   
    <xsl:function name="hcmc:returnContext">
        <xsl:param name="span" as="element(span)"/>
        <xsl:variable name="thisTerm" select="$span/text()"/>
        
        <xsl:variable name="start" select="string-join(reverse(for $n in 1 to 7 return $span/preceding-sibling::node()[$n]),'')"/>
        <xsl:variable name="end" select="string-join(for $n in (1 to 7) return $span/following-sibling::node()[$n],'')"/>
        <xsl:value-of select="normalize-space(concat($start,' ', $thisTerm,' ',$end))"/>
    </xsl:function>
    
    <xsl:function name="hcmc:getText" as="xs:string">
        <xsl:param name="el"/>
        <xsl:value-of select="normalize-space(string-join($el/descendant::text(),''))"/>
    </xsl:function>
  
</xsl:stylesheet>