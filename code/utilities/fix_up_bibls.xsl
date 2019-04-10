<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>Date: April 2019</xd:p>
            <xd:p>This stylesheet is a quick utility transformation
            for adding some encoding that can be determined programatically to the 
            bibliography. It is meant to be run once against the bibliography.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:variable name="orgs" select="document('../../data/organizations.xml')"/>
    
    
    
    <xd:doc>
        <xd:desc>Try to autotag publishers</xd:desc>
    </xd:doc>
    <xsl:template match="bibl/title[@level='j'] | bibl/publisher[not(@ref)]">
        <publisher>
            <xsl:copy-of select="wea:makePubPointer(.)"/>
            <xsl:choose>
                <xsl:when test="self::title">
                    <xsl:copy>
                        <xsl:apply-templates select="@*|node()" mode="#current"/>
                    </xsl:copy>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:otherwise>
            </xsl:choose>
        </publisher>
    </xsl:template>
    
    
    <xd:doc>
        <xd:desc>Add ids for all bibls</xd:desc>
    </xd:doc>
    <xsl:template match="listBibl[@xml:id]/bibl">
        <xsl:variable name="parentId" select="parent::listBibl/@xml:id"/>
        <xsl:variable name="preCount" select="count(preceding-sibling::bibl) + 1"/>
        <xsl:copy>
            <xsl:attribute name="xml:id" select="concat($parentId,$preCount)"/>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xd:doc>
        <xd:desc>Add dating attributes</xd:desc>
    </xd:doc>
    <xsl:template match="date[not(@*)]">
        <xsl:copy>
            <xsl:copy-of select="wea:makeDateAtts(text())"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xd:doc>
        <xd:desc>Attempt to tag Winnifred Eaton's author name</xd:desc>
    </xd:doc>
    <xsl:template match="author">
        <xsl:variable name="text" select="text()"/>
        <xsl:variable name="names" select="string-join(('Winnifred', 'Reeve', 'Eaton', 'Watanna', 'Onoto'),'|')"/>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="@ref">
                    <name ref="{@ref}">
                        <xsl:apply-templates select="node()"/>
                    </name>
                </xsl:when>
                
                <xsl:when test="not(@ref) and matches($text,$names)">
                    <name ref="pers:WE1">
                        <xsl:apply-templates select="node()"/>
                    </name>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="node()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="author/@ref"/>
    
    
 
    
    
    <xd:doc>
        <xd:desc>Classic identity transform</xd:desc>
    </xd:doc>
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Try and create the ref attribute for the pubpointer</xd:desc>
        <xd:param name="el"/>
    </xd:doc>
    <xsl:function name="wea:makePubPointer">
        <xsl:param name="el"/>
        <xsl:variable name="text" select="normalize-space(string-join($el/descendant::text(),''))"/>
        <xsl:variable name="match" select="$orgs//org[orgName[normalize-space(text()) = $text]]"/>
        <xsl:if test="count($match) = 1">
            <xsl:attribute name="ref" select="concat('org:',$match/@xml:id)"/>
        </xsl:if>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Reading in the text and then analyze the string to see if we can determine
            the the date attributes from it</xd:desc>
        <xd:param name="text"/>
    </xd:doc>
    <xsl:function name="wea:makeDateAtts">
        <xsl:param name="text"/>
            <xsl:analyze-string select="$text" regex="^(\d+) (\w+)\. (\d+)$">
                <xsl:matching-substring>
                    <xsl:attribute name="when" select="concat(regex-group(3),'-',wea:monthNum(regex-group(2)),'-', if (string-length(regex-group(1)) = 1) then concat('0',regex-group(1)) else regex-group(1))"/>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:analyze-string select="$text" regex="^(\w+)\. (\d+)$">
                        <xsl:matching-substring>
                            <xsl:attribute name="when" select="concat(regex-group(2),'-',wea:monthNum(regex-group(1)))"/>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:analyze-string select="$text" regex="(^\d\d\d\d$)">
                                <xsl:matching-substring>
                                    <xsl:attribute name="when" select="regex-group(1)"/>
                                </xsl:matching-substring>
                                <xsl:non-matching-substring>
                                    <xsl:analyze-string select="$text" regex="^(\w+) (\d\d\d\d)$">
                                        <xsl:matching-substring>
                                            <xsl:attribute name="when" select="concat(regex-group(2),'-',wea:monthNum(regex-group(1)))"/>
                                        </xsl:matching-substring>
                                    </xsl:analyze-string>
                                </xsl:non-matching-substring>
                            </xsl:analyze-string>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        
    </xsl:function>
    
    
    <xd:doc>
        <xd:desc>Very simple function that reads in a month name and then 
            associates the number with it; they are slightly inconsistent.</xd:desc>
        <xd:param name="month"/>
    </xd:doc>
    <xsl:function name="wea:monthNum">
        <xsl:param name="month"/>
        <xsl:choose>
            <xsl:when test="matches($month,'^Jan')">
                <xsl:value-of select="'01'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Feb')">
                <xsl:value-of select="'02'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Mar')">
                <xsl:value-of select="'03'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Apr')">
                <xsl:value-of select="'04'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^May')">
                <xsl:value-of select="'05'"/>
                
            </xsl:when>
            <xsl:when test="matches($month,'^Jun')">
                <xsl:value-of select="'06'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Jul')">
                <xsl:value-of select="'07'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Aug')">
                <xsl:value-of select="'08'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Sept')">
                <xsl:value-of select="'09'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Oct')">
                <xsl:value-of select="'10'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Nov')">
                <xsl:value-of select="'11'"/>
            </xsl:when>
            <xsl:when test="matches($month,'^Dec')">
                <xsl:value-of select="'12'"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>