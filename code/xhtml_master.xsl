<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
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
    
    <xsl:param name="verbose">false</xsl:param>
    
    <xsl:template match="TEI">
        <xsl:message>Processing <xsl:value-of select="@xml:id"/></xsl:message>
        <xsl:result-document href="{@xml:id}.html" method="xhtml" encoding="UTF-8" indent="yes" normalization-form="NFC" exclude-result-prefixes="#all" omit-xml-declaration="yes" html-version="5.0">
            <html lang="en">
                <xsl:call-template name="processAtts"/>
                <xsl:apply-templates/>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!--TODO: METADATA STUFF-->
    <xsl:template match="teiHeader">
        <head>
            <title><xsl:value-of select="fileDesc/titleStmt/title[1]"/></title>
            <xsl:call-template name="addScripts"/>
        </head>
    </xsl:template>
    
    <xsl:template match="text">
        <body>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates/>
        </body>
    </xsl:template>
    
    <!--Generic block level element templates-->
    <xsl:template match="body | div | p | note | lg | l | q">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:variable name="nestLevel" select="count(ancestor::div)+1"/>
        <xsl:element name="{concat('h',$nestLevel)}">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!--Generic inline-->
    <xsl:template match="hi | seg">
        <span>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="ref">
        <a href="{@target}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="pb">
        <hr>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates/>
        </hr>
    </xsl:template>
    
    <xsl:template match="lb">
        <br>
            <xsl:call-template name="processAtts"/>
        </br>
    </xsl:template>
    
    <!--Now janus elements-->
    
    <xsl:template match="choice">
        <span title="{normalize-space(orig)}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="choice/orig"/>
    
    <xsl:template match="choice/reg">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    
    
    
    <!--**************************************************************
       *                                                            * 
       *                   ATTRIBUTES                               *
       *                                                            *
       **************************************************************-->
    
    <xsl:template match="@xml:id">
        <xsl:attribute name="id" select="."/>
    </xsl:template>
    
    <xsl:template match="@xml:lang">
        <xsl:attribute name="lang" select="."/>
    </xsl:template>
    
    <xsl:template match="@rendition">
        <xsl:param name="classes" as="xs:string*" tunnel="yes"/>
        <xsl:variable name="theseVals" select="translate(.,'#','')"/>
        <xsl:attribute name="class" select="string-join(($classes,$theseVals),' ')"/>
    </xsl:template>
    
    <!--Just copy out style-->
    <xsl:template match="@style">
        <xsl:attribute name="style" select="."/>
    </xsl:template>
    
    <!--We have to handle this for now, but these should probably be @rendition-->
    <xsl:template match="@rend">
        <xsl:variable name="value" as="xs:string?">
            <xsl:choose>
                <xsl:when test=".='center'">text-align:center;</xsl:when>
                <xsl:when test=".='italic'">font-style: italic;</xsl:when>
                <xsl:when test=".='bold'">font-weight: bold;</xsl:when>
                <xsl:when test=".='underline'">text-decoration:underline;</xsl:when>
                <xsl:otherwise>
                    <xsl:message>Rend value <xsl:value-of select="."/> not found.</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="not(empty($value))">
            <xsl:attribute name="style" select="$value"/>
        </xsl:if>
    </xsl:template>
    
    
    <!--By default, delete all attributes from being processed
    as text.-->
    <xsl:template match="@*" priority="-1"/>
    
    <!--**************************************************************
       *                                                            * 
       *                    NAMED TEMPLATE                          *
       *                                                            *
       **************************************************************-->
    
    
    <!--This template is taken from the LEMDO processing model-->
    <xsl:template name="processAtts">
        <xsl:param name="classes" as="xs:string*"/>
        <xsl:param name="id" as="xs:string?"/>
        
        <!--First, create the data-el attribute-->
        <xsl:attribute name="data-el" select="local-name(.)"/>
        
        <!--Now fork and give some warnings (if desired)-->
        <xsl:choose>
            <!--If the class parameter is supplied-->
            <xsl:when test="not(empty($classes))">
                <xsl:if test="$verbose='true'">
                    <xsl:message>Added classes detected: <xsl:value-of select="$classes"/></xsl:message>
                </xsl:if>
                <xsl:choose>
                    <!--They'll be added if there's a rendition declared, so leave it-->
                    <xsl:when test="@rendition">
                        <xsl:if test="$verbose='true'">
                            <xsl:message>Classes to be added to element alongside pre-existing rendition: <xsl:value-of select="@rendition"/></xsl:message>
                        </xsl:if>
                        
                    </xsl:when>
                    <!--Otherwise, create a class attribute-->
                    <xsl:otherwise>
                        <xsl:if test="$verbose='true'">
                            <xsl:message>Classes added to create new class</xsl:message>
                        </xsl:if>
                        
                        <xsl:attribute name="class" select="$classes"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            
            <!--If the id parameter is supplied-->
            <xsl:when test="not(empty($id) or normalize-space($id)='')">
                <xsl:if test="$verbose='true'">
                    <xsl:message>Added id detected: <xsl:value-of select="$id"/></xsl:message>
                </xsl:if>
                
                <!--Break right away if the @xml:id is badly formed-->
                <xsl:if test="matches(normalize-space($id),'^\d+|:|\s+')">
                    <xsl:message terminate="yes">BAD ID: <xsl:value-of select="$id"/></xsl:message>
                </xsl:if>
                <!--If it's fine, then see if there's already an @xml:id on this object-->
                <xsl:choose>
                    <xsl:when test="not(@xml:id)">
                        <!--If there isn't an xml:id, then create an @id-->
                        <xsl:attribute name="id" select="normalize-space($id)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        
                        <xsl:message>ERROR: Element <xsl:value-of select="local-name(.)"/> already has declared id <xsl:value-of select="@xml:id"/>. Added
                            <xsl:value-of select="$id"/> will have no effect.</xsl:message>
                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
        
        <!--Iterate through each @attribute and add it as a data-att-->
        <xsl:for-each select="@*[not(local-name()=('xml:id','id','lang','xml:lang'))]">
            <xsl:attribute name="{concat('data-',local-name())}" select="."/>
        </xsl:for-each>
        
        <!--And now apply templates to the attributes in mode tei-->
        <xsl:apply-templates select="@*">
            <xsl:with-param name="classes" select="$classes" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template name="addScripts">
        <link rel="stylesheet" type="text/css" href="css/wea.css"/>
    </xsl:template>
    
    
</xsl:stylesheet>