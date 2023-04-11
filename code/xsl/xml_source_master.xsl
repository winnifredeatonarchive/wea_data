<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: March 11, 2022</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet creates the "source" XML, which is mostly just the flattened version of the documents.
            However, there are some manipulations we make depending on the environment as controlled by the version file.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:include href="globals.xsl"/>
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:variable name="workingDocs" select="wea:getWorkingDocs($srcXml)" as="document-node()*"/>
    
    <xsl:variable name="isProductionBuild"
        select="not(matches(normalize-space($version),'a$'))"
        as="xs:boolean"/>
    
    <xsl:template name="go">
        <xsl:if test="$isProductionBuild">
            <xsl:message>PRODUCTION BUILD: <xsl:value-of select="$version"/></xsl:message>
        </xsl:if>
        <xsl:apply-templates select="$workingDocs"/>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:result-document href="{$sourceDir}{//TEI/@xml:id}.xml" method="xml" indent="no">
            <!--<xsl:message select="'Processing ' || current-output-uri()"/>-->
            <xsl:apply-templates/>
        </xsl:result-document>
    </xsl:template>
    
    <!--Only run this template if we are doing a production build-->
    <xsl:template match="text[$isProductionBuild]">
        <xsl:variable name="status" select="ancestor::TEI//revisionDesc/@status" as="xs:string"/>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="not($status = ('empty','published'))">
                    <xsl:message>REPLACING CONTENT IN <xsl:value-of select="ancestor::TEI/@xml:id"/></xsl:message>
                    <body>
                        <div>
                            <gap reason="{$status}"/>
                        </div>
                    </body>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="node()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>

    
    
</xsl:stylesheet>