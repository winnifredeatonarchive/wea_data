<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:param name="verbose">false</xsl:param>
    <xsl:param name="outDir"/>
    
    
    <xsl:variable name="sourceDir" select="'../../data/'"/>
    
    
    <xsl:variable name="productsDir" select="'../products/'"/>
    
    <xsl:variable name="today" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
    
    
    
    <xsl:variable name="originalXmlDir" select="concat($productsDir,'xml/original/')"/>
    <xsl:variable name="standaloneXmlDir" select="concat($productsDir,'xml/standalone/')"/>
    
    <xsl:variable name="sourceXml" select="collection(concat($sourceDir,'?select=*.xml&amp;recurse=yes'))//TEI"/>
    
    <xsl:variable name="originalXml" select="collection(concat($originalXmlDir,'?select=*.xml&amp;recurse=yes'))//TEI"/>
    
    <xsl:variable name="standaloneXml" select="collection(concat($standaloneXmlDir,'?select=*.xml&amp;recurse=yes'))//TEI"/>
    
    <xsl:variable name="personography" select="$standaloneXml[@xml:id='people']" as="element(TEI)"/>
    
    <xsl:variable name="taxonomies" select="$standaloneXml[@xml:id='taxonomies']" as="element(TEI)"/>
    
    <xsl:variable name="prefixDefs" select="$taxonomies/descendant::prefixDef" as="element(prefixDef)+"/>
</xsl:stylesheet>