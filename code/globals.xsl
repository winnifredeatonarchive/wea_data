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
    
    
    <xsl:variable name="xmlDir" select="'../data/texts/'"/>
    
    <xsl:variable name="xmlDocs" select="collection(concat($xmlDir,'?select=*.xml&amp;recurse=yes'))"/>  
    
    <xsl:variable name="personography" select="$xmlDocs//TEI[@xml:id='people']"/>
</xsl:stylesheet>