<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:jt="http://github.com/joeytakeda"
    exclude-result-prefixes="#all"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="taxonomies" select="document('../data/taxonomies.xml')"/>
    <xsl:variable name="people" select="document('../data/people.xml')"/>
    <xsl:variable name="sq">'</xsl:variable>
    
    <xsl:variable name="pplVar" select="concat('(',string-join(for $n in $people//person[@xml:id[not(.='WE')]] return concat($sq,$n/@xml:id,$sq,':',$sq,$n/persName,$sq),';'),')')" as="xs:string"/>
    <xsl:variable name="docTypeVar" select="concat('(',string-join(for $d in $taxonomies//taxonomy[@xml:id='docType']/descendant::category return concat($sq,$d/@xml:id,$sq,':',$sq,$d/catDesc,$sq),';'),')')"/>
    <xsl:variable name="objectVar" select="concat('(',string-join(for $d in $taxonomies//taxonomy[@xml:id='object']/descendant::category return concat($sq,$d/@xml:id,$sq,':',$sq,$d/catDesc,$sq),';'),')')"/>
    <xsl:variable name="genreVar" select="concat('(',string-join(for $d in $taxonomies//taxonomy[@xml:id='genre']/descendant::category return concat($sq,$d/@xml:id,$sq,':',$sq,$d/catDesc,$sq),';'),')')"/>
    <xsl:variable name="locationsVar" select="concat('(',string-join(for $d in $taxonomies//taxonomy[@xml:id='locations']/descendant::category return concat($sq,$d/@xml:id,$sq,':',$sq,$d/catDesc,$sq),';'),')')"/>
    
    
        
        
    <xsl:template match="respStmt[resp[text()='Transcriber']]/name/@ref">
        <xsl:attribute name="ref" select="concat('pers:',jt:makeCombo('Transcriber',$pplVar,'transcriber'))"/>
    </xsl:template>
    <xsl:template match="respStmt[resp[text()='Encoder']]/name/@ref">
        <xsl:attribute name="ref" select="concat('pers:',jt:makeCombo('Encoder',$pplVar,'encoder'))"/>
    </xsl:template>
    <xsl:template match="respStmt[resp[text()='Copy Editor']]/name/@ref">
        <xsl:attribute name="ref" select="concat('pers:',jt:makeCombo('Copy Editor',$pplVar,'copyeditor'))"/>
    </xsl:template>
    

   <!-- <xsl:template match="catRef[@scheme='wdt:docType']/@target">
        <xsl:attribute name="target" select="concat('wdt:',jt:makeCombo('Document Type',$docTypeVar,'doctype'))"/>
        
    </xsl:template>-->
<!--    <xsl:template match="catRef[@scheme='wdt:object']/@target">
        <xsl:attribute name="target" select="concat('wdt:',jt:makeCombo('Object Type',$objectVar,'object'))"/>
    </xsl:template>-->
    <xsl:template match="catRef[@scheme='wdt:genre']/@target">
        <xsl:attribute name="target" select="concat('wdt:',jt:makeCombo('Genre',$genreVar,'genre'))"/>
    </xsl:template>
    <xsl:template match="catRef[@scheme='wdt:locations']/@target">
        <xsl:attribute name="target" select="concat('wdt:',jt:makeCombo('Location',$locationsVar,'location'))"/>
    </xsl:template>
    
    
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:function name="jt:makeCombo">
        <xsl:param name="message"/>
        <xsl:param name="choice"/>
        <xsl:param name="id"/>
        <xsl:variable name="default" select="substring-before(tokenize(substring-after($choice,'('),';')[1],':')"/>
        <xsl:variable name="result">${ask('<xsl:value-of select="$message"/>',radio,<xsl:value-of select="$choice"/>,<xsl:value-of select="$default"/>, @<xsl:value-of select="$id"/>)}</xsl:variable>
       <xsl:value-of select="normalize-space($result)"/>
    </xsl:function>
    
</xsl:stylesheet>