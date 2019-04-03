<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xsl:param name="outDir"/>
    <xsl:variable name="template" select="doc('../../documentation/template/template.html')"/>
    <xsl:include href="../xsl/xhtml_eg_module.xsl"/>
    

    <!--We have to have output method='xhtml' and html-version='5.0' to produce
    validate XHTML5 (xhtml with no version specified produces invalid results)-->
    <xsl:output method="xhtml" encoding="UTF-8" indent="yes" normalization-form="NFC"
        exclude-result-prefixes="#all" omit-xml-declaration="yes" html-version="5.0"/>
    
    <xsl:template match="/">
        <xsl:variable name="text" select="//text"/>
        
        <xsl:result-document href="{$outDir}/index.html">
            <xsl:apply-templates select="$template" mode="xh">
                <xsl:with-param name="thisDiv" tunnel="yes" select="$text/front"/>
                <xsl:with-param name="toc" tunnel="yes">
                    <xsl:apply-templates select="$text/(body|back)" mode="toc"/>
                </xsl:with-param>
            </xsl:apply-templates>
        </xsl:result-document>
        <xsl:for-each select="//div[@xml:id]">
            <xsl:result-document href="{$outDir}/{@xml:id}.html">
                <xsl:apply-templates select="$template" mode="xh">
                    <xsl:with-param name="thisDiv" tunnel="yes" select="."/>
                    <xsl:with-param name="toc" tunnel="yes">
                        <xsl:apply-templates select="$text/(body|back)" mode="toc">
                            <xsl:with-param name="divId" tunnel="yes" select="@xml:id"/>
                        </xsl:apply-templates>
                    </xsl:with-param>
                </xsl:apply-templates>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    
    <!--MAIN TEMPLATES-->

    
    <xsl:template match="p | div | ab | cit[quote] | cit/quote | list | item | list/label" mode="main">
        <div class="{local-name()}">
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="q | quote[not(ancestor::cit)] | emph | title | label | gi | att | val | ident | label | term | foreign" mode="main">
        <span class="{local-name()}">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
  
    
    
    <xsl:template match="code" mode="main">
        <pre>
            <xsl:apply-templates mode="#current"/>
        </pre>
    </xsl:template>
    
    <xsl:template match="table" mode="main">
        <table>
            <xsl:apply-templates mode="#current"/>
        </table>
    </xsl:template>
    
    <xsl:template match="ref" mode="main">
        <xsl:param name="thisDiv" tunnel="yes"/>
        <a href="{wea:resolveRef(@target, $thisDiv)}">
            <xsl:apply-templates mode="#current"/>
        </a>
    </xsl:template>
    
    <xsl:function name="wea:resolveRef">
        <xsl:param name="target"/>
        <xsl:param name="div"/>
        <xsl:choose>
            <xsl:when test="starts-with($target,'#')">
                <xsl:choose>
                    <xsl:when test="$div/descendant-or-self::tei:*[@xml:id=substring-after(@target,'#')]">
                        <xsl:value-of select="$target"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(substring-after($target,'#'),'.html')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$target"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    

    
    
    <xsl:template match="figure" mode="main">
        <figure>
            <xsl:apply-templates mode="#current"/>
        </figure>
    </xsl:template>
    <xsl:template match="graphic" mode="main">
        <img>
            <xsl:attribute name="alt" select="normalize-space(desc)"/>
            <xsl:apply-templates select="@url|node()" mode="#current"/>
        </img>
    </xsl:template>
    
    <xsl:template match="graphic/desc" mode="main"/>
    
    
    <!--Repoint the src in graphics-->
    <xsl:template match="graphic/@url" mode="main">
        <xsl:attribute name="src" select="concat('graphics/',tokenize(.,'/')[last()])"/>
    </xsl:template>

    
    <xsl:template match="head" mode="main">
        <h3>
            <xsl:apply-templates mode="#current"/>
        </h3>
    </xsl:template>
        
    <xsl:template match="row" mode="main">
        <tr>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </tr>
    </xsl:template>
    
    <xsl:template match="@role" mode="main">
        <xsl:attribute name='data-role' select="."/>
    </xsl:template>
    
    <xsl:template match="cell" mode="main">
        <td>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </td>
    </xsl:template>
    
    <xsl:template match="*" mode="main" priority="-1">
        <xsl:message>NOT MATCHING <xsl:value-of select="local-name(.)"/></xsl:message>
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    
    
    <xsl:template match="@cols" mode="main">
        <xsl:attribute name="colspan" select="."/>
    </xsl:template>
    
    <xsl:template match="eg:egXML" mode="main">
        <xsl:apply-templates select="." mode="tei"/>
    </xsl:template>
    
    <!--XH TEMPLATES-->
    <xsl:template match="xh:nav/xh:ul" mode="xh">
        <xsl:param name="toc" tunnel="yes"/>
        <ul>
            <xsl:copy-of select="$toc"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="xh:article" mode="xh">
        <xsl:param name="thisDiv" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|h2" mode="#current"/>
            <xsl:apply-templates select="$thisDiv/node()[not(self::div[@xml:id][head])]" mode="main"/>
            <xsl:if test="$thisDiv/div[@xml:id][head]">
                <div>
                    <h3>Contents</h3>
                    <ul>
                        <xsl:for-each select="$thisDiv/div[@xml:id][head]">
                            <li><a href="{@xml:id}.html"><xsl:value-of select="head"/></a></li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xh:article/xh:h2" mode="xh">
        <xsl:param name="thisDiv" tunnel="yes"/>
        <xsl:copy>
            <xsl:value-of select="$thisDiv/head"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xh:link[@rel='stylesheet']/@href" mode="xh">
        <xsl:attribute name="href">
            <xsl:value-of select="substring-after(.,'../')"/>
        </xsl:attribute>
    </xsl:template>
    
    <!--TOC TEMPLATES-->
    
    <xsl:template match="teiHeader" mode="toc"/>

    <xsl:template match="div[head]" mode="toc">
        <xsl:param name="divId"/>
        <li>
            <xsl:choose>
                <xsl:when test="wea:getId(.) = $divId">
                    <span class="selected"><xsl:value-of select="head"/></span>
                </xsl:when>
                <xsl:otherwise>
                    <a href="{wea:getId(.)}.html"><xsl:value-of select="head"/></a>
                </xsl:otherwise>
            </xsl:choose>
           <xsl:if test="div[head]">
               <ul>
                   <xsl:apply-templates select="div[head]" mode="#current"/>
               </ul>
           </xsl:if>
        </li>
    </xsl:template>
    
    
    <xsl:function name="wea:getId">
        <xsl:param name="thing"/>
        <xsl:value-of select="if ($thing/@xml:id) then $thing/@xml:id else generate-id($thing)"/>
    </xsl:function>
    
    <xsl:template match="@*|node()" mode="xh">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>