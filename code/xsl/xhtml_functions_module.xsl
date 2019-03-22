<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet is the master stylesheet for the WEA project's conversion
                from TEI P5 to XHTML5. It may load in other modules, if the complexity of the project
                necessitiates it.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <!--FUNCTIONS-->
    
    <xsl:function name="wea:getNoteId">
        <xsl:param name="note"/>
        <xsl:value-of select="concat('note_',count($note/preceding::note[@type='editorial'])+1)"/>
    </xsl:function>
    
    <xsl:function name="wea:resolveTarget">
        <xsl:param name="target"/>
        <xsl:choose>
            <xsl:when test="starts-with($target,'http')">
                <xsl:value-of select="$target"/>
            </xsl:when>
            <xsl:when test="contains($target,'.xml')">
                <xsl:value-of select="replace($target,'\.xml','.html')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$target"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="wea:getTitle">
        <xsl:param name="docId"/>
        <xsl:sequence select="$standaloneXml[@xml:id=$docId]/teiHeader/fileDesc/titleStmt/title[1]/node()"/>
    </xsl:function>
    
    <xsl:function name="wea:bornDigital" as="xs:boolean">
        <xsl:param name="doc"/>
        <xsl:value-of select="some $q in $doc//catRef/@target satisfies (contains($q,'BornDigital'))"/>
    </xsl:function>
    
    
    
</xsl:stylesheet>