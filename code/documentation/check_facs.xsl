<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:param name="facsList"/>
    
    <xsl:variable name="facsIds" select="unparsed-text-lines($facsList)"/>
    
    
    <!--This diagnostics is slightly different from the implementations described in
        Holmes and Takeda 2019; instead, these are created within the ODD itself, generated only
        at build time as part of the documentation.-->
    
    <xsl:variable name="dataDocs" select="collection('../../data/?select=*.xml;recurse=yes')"/>
    
    
    <xsl:template name="check">
        <xsl:variable name="errors" as="element(item)*">
            <xsl:for-each-group select="$dataDocs//@facs" group-by="xs:string(.)">
                <xsl:variable name="thisFacs" select="current-grouping-key()" as="xs:string"/>
                <xsl:if test="not($facsIds[.=concat(substring-after($thisFacs,'facs:'),'.pdf')])">
                    <xsl:variable name="badDocs" as="xs:string+">
                        <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                            <xsl:value-of select="current-grouping-key()"/>
                        </xsl:for-each-group>
                    </xsl:variable>
                    <item>ERROR: Reference to document <xsl:value-of select="$thisFacs"/> cannot be found in the facsimile document. Check for spelling. Error occurs in the following documents: <xsl:value-of select="$badDocs" separator=", "/>.</item>
                    
                </xsl:if>
            </xsl:for-each-group>
        </xsl:variable>
       <xsl:choose>
           <xsl:when test="empty($errors)">
               <xsl:message>All facsimiles found.</xsl:message>
           </xsl:when>
           <xsl:otherwise>
               <xsl:message terminate="yes">
                   <xsl:for-each select="$errors">
                       <xsl:value-of select="."/><xsl:if test="not(position() = last())"><xsl:text>&#xA;&#xA;</xsl:text></xsl:if>
                   </xsl:for-each>
            </xsl:message>
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>