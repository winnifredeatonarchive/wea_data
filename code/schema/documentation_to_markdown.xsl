<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:hcmc="http://hcmc.uvic.ca/ns"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> February 1, 2019</xd:p>
            <xd:p><xd:b>Author:</xd:b> jtakeda</xd:p>
            <xd:p>This tranformation takes the compiled HTML documentation meant for editors
            and converts it to a Github markdown file for easier viewing on Github, if desired.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:strip-space elements="*"/>
    
 
    <xsl:variable name="newLine" select="'&#xA;'"/>
    
    <xsl:template match="html">

        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@id='TOP.note']/text()">
        <xsl:analyze-string select="." regex="oXygen">
            <xsl:matching-substring>
                <xsl:text>Github</xsl:text>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template match="p[not(ancestor::table)]">
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    

    
    
    <xsl:template match="h1 | h2 | h3 | h4 | h5 | h6">
        <xsl:variable name="num" select="xs:integer(substring-after(local-name(),'h'))" as="xs:integer"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:for-each select="1 to $num"><xsl:text>#</xsl:text></xsl:for-each><xsl:text> </xsl:text><xsl:apply-templates/><xsl:if test="@id">
            <span id="{@id}"/>
        </xsl:if>
       <xsl:if test="parent::header/parent::section[@id]">
           <xsl:text>  </xsl:text><span id="{parent::header/parent::section[@id]/@id}"/>
       </xsl:if>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="a[@href]">
     <xsl:if test="ancestor::td"><xsl:text> </xsl:text></xsl:if> <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text><xsl:text>(</xsl:text><xsl:value-of select="@href"/><xsl:text>)</xsl:text>
        <xsl:if test="ancestor::td"><xsl:text> </xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="span[@class='label']">
        <xsl:if test="parent::div and following-sibling::*[1][self::a]"><xsl:copy-of select="$newLine"/><xsl:copy-of select="$newLine"/></xsl:if><xsl:text>**</xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text>**</xsl:text><xsl:if test="span[@class='gi']"><xsl:text> </xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="div[contains(@class,'egXML')]">
        <xsl:copy-of select="$newLine"/>
        <xsl:text>```</xsl:text>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/> <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/> <xsl:text>```</xsl:text>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="node()[ancestor::div[contains(@class,'egXML')]]">
        
        <xsl:value-of select="." disable-output-escaping="yes"/>
    </xsl:template>

    
    
    
    <xsl:template match="div[h3][preceding-sibling::div]">
        <xsl:copy-of select="$newLine"/>
        <xsl:text> ----- </xsl:text>
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="table">
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="div/table/tr[td[@colspan]]">
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="div[@id='TOP.note']">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
        <xsl:call-template name="createToc"/>
    </xsl:template>
    
    
    

    
    <xsl:template match="table/tr[position() gt 1][parent::table/parent::div]">
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:variable name="thisH" select="ancestor::div[1]/*[1][matches(local-name(),'h\d')]"/>
        <xsl:variable name="thisLevel" select="xs:integer(substring-after($thisH/local-name(),'h')) + 1"/>
        <xsl:for-each select="1 to $thisLevel"><xsl:text>#</xsl:text></xsl:for-each><xsl:text> </xsl:text><xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    
    <xsl:template match="div/table/tr/td[2]">
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="td/table">
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="td/table/tr[descendant::table]">
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="td/table/tr/td[descendant::table]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="td/table/tr[not(descendant::table)]">
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="td/table/tr/td/table/tr/td[1]">
   <xsl:text>*  </xsl:text><xsl:apply-templates/><xsl:text>: </xsl:text>
    </xsl:template>
    
    <xsl:template match="td/table/tr/td/table/tr/td[2]">
  <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="td/table/tr[descendant::table]/td[span[@class='attribute']]"><xsl:apply-templates/><xsl:text> </xsl:text></xsl:template>
    
    <xsl:template match="span[@class='attribute'][not(ancestor::div[contains(@class,'egXML')])] | span[@class='gi'][not(ancestor::div[contains(@class,'egXML')])]">
        <xsl:text>`</xsl:text><xsl:apply-templates/><xsl:text>`</xsl:text>
    </xsl:template>

    

    
    <xsl:template match="span[@class='attribute']" mode="innertbl">
        <xsl:copy>
            <xsl:attribute name="class" select="'label'"/>
            <xsl:apply-templates mode="#current"/>
        </xsl:copy>
    </xsl:template>

   
   
   <xsl:template match="head"/>
    <xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ul | ol">
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:apply-templates/>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>

    </xsl:template>
    
    <xsl:template name="createToc">
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:text>## Element and Attribute Index</xsl:text>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:value-of select="string-join(for $n in ancestor::html//h3[@id] return concat('[',string-join($n/descendant::text(),''),'](#',$n/@id,')'),' | ')"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    

    
    <xsl:template match="br">
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="img">
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
        <xsl:text>![</xsl:text><xsl:value-of select="@src"/><xsl:text>]</xsl:text><xsl:text>(</xsl:text><xsl:value-of select="@src"/><xsl:text>)</xsl:text>
        <xsl:copy-of select="$newLine"/>
        <xsl:copy-of select="$newLine"/>
    </xsl:template>
    
    <xsl:template match="code">
        <xsl:choose>
            <xsl:when test="@class='block'">
                <xsl:copy-of select="$newLine"/>
                <xsl:text>```</xsl:text>
                <xsl:copy-of select="$newLine"/>
                <xsl:apply-templates/>
                <xsl:copy-of select="$newLine"/>
                <xsl:text>```</xsl:text>
                <xsl:copy-of select="$newLine"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>`</xsl:text><xsl:apply-templates/><xsl:text>`</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="li">
        <xsl:copy-of select="$newLine"/>
        <xsl:choose>
            <xsl:when test="parent::ol">
                <xsl:text>1. </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>* </xsl:text>
            </xsl:otherwise>
        </xsl:choose><xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="dl">
        <xsl:copy-of select="$newLine"/>
        
        <xsl:for-each select="dt"><xsl:copy-of select="$newLine"/><xsl:text>     *   </xsl:text><xsl:text> **</xsl:text><xsl:value-of select="."/>** <xsl:value-of select="following-sibling::dd[1]"/></xsl:for-each>
    </xsl:template>

    
    <xsl:template match="*" priority="-1">
        <xsl:message>Not matching <xsl:value-of select="local-name()"/></xsl:message>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="text()[not(ancestor::div[contains(@class,'egXML')])]">
        <xsl:value-of select="replace(.,'\s+',' ')"/>
    </xsl:template>
    
</xsl:stylesheet>