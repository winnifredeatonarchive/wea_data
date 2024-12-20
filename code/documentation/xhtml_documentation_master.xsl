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
    <xsl:variable name="sourceDoc" select="TEI"/>
    
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
            <xsl:message>Creating document <xsl:value-of select="@xml:id"/></xsl:message>
            <xsl:result-document href="{$outDir}/{@xml:id}.html">
                <xsl:apply-templates select="$template" mode="xh">
                    <xsl:with-param name="thisDiv" tunnel="yes" select="."/>
                    <xsl:with-param name="toc" tunnel="yes">
                        <xsl:apply-templates select="$text/(body|back)" mode="toc">
                            <xsl:with-param name="currDivId" tunnel="yes" select="@xml:id"/>
                        </xsl:apply-templates>
                    </xsl:with-param>
                </xsl:apply-templates>
            </xsl:result-document>
        </xsl:for-each>
        <xsl:result-document href="{$outDir}/full.html">
            <xsl:apply-templates select="$template" mode="xh">
                <xsl:with-param name="thisDiv" tunnel="yes" select="$sourceDoc"/>
                <xsl:with-param name="toc" tunnel="yes">
                    <xsl:apply-templates select="$text/(body|back)" mode="toc">
                        <xsl:with-param name="currDivId" tunnel="yes" select="'full'"/>
                    </xsl:apply-templates>
                </xsl:with-param>
            </xsl:apply-templates>
        </xsl:result-document>
    </xsl:template>
    
    
    <!--MAIN TEMPLATES-->
    
    <xsl:template match="teiHeader | back" mode="main"/>
    <xsl:template match="front | body | TEI | text" mode="main">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="p | div | ab | cit[quote] | cit/quote | list | item | list/label" mode="main">
        <div class="{local-name()}">
            <xsl:if test="self::div and head and not(@xml:id)">
                <xsl:attribute name="id" select="generate-id(.)"/>
            </xsl:if>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="div/@type" mode="main">
        <xsl:attribute name="class" select="."/>
    </xsl:template>
    
    <xsl:template match="q | quote[not(ancestor::cit)] | title[not(@level)] | emph | label | gi | att | val | ident | label | term | foreign" mode="main">
        <span class="{local-name()} ">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="title[@level]" mode="main">
        <span class="title {@level}">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
  
    
    
    <xsl:template match="code[ancestor::head]" mode="main">
        <span class="code{if (@rend) then concat(' ', @rend) else ()}">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="code" mode="main">
        <pre>
            <xsl:if test="@rend">
                <xsl:attribute name="class" select="@rend"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </pre>
    </xsl:template>
    

    
    <xsl:template match="list[count(item) = 1 and item[list]]" mode="main">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="item[list][parent::list[count(item) = 1]]" mode="main">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="table" mode="main">
        <table>
            <xsl:apply-templates mode="#current"/>
        </table>
    </xsl:template>
    
    <xsl:template match="ref" mode="main">
        <xsl:param name="thisDiv" tunnel="yes"/>
        <xsl:variable name="resolvedTarget" select="wea:resolveRef(@target,$thisDiv)"/>
        <xsl:variable name="classes" as="xs:string*">
            <xsl:if test="matches($resolvedTarget,concat('^',$thisDiv/@xml:id,'.html$'))">
                <xsl:value-of select="'selected'"/>
            </xsl:if>
            <xsl:if test="starts-with(@target,'#TEI.')">
                <xsl:value-of select="'spec'"/>
            </xsl:if>
        </xsl:variable>
        <a href="{wea:resolveRef(@target, $thisDiv)}">
             <xsl:if test="not(empty($classes))">
                 <xsl:attribute name="class" select="string-join($classes,' ')"/>
             </xsl:if>
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
            <xsl:attribute name="alt" select="normalize-space(../figDesc)"/>
            <xsl:apply-templates select="@url|node()" mode="#current"/>
        </img>
    </xsl:template>
    
    <xsl:template match="figDesc" mode="main"/>
    
    
    <!--Repoint the src in graphics-->
    <xsl:template match="graphic/@url" mode="main">
        <xsl:attribute name="src" select="concat('graphics/',tokenize(.,'/')[last()])"/>
    </xsl:template>

    
    <xsl:template match="head" mode="main">
        <xsl:param name="thisDiv" tunnel="yes"/>
        <xsl:variable name="count" select="count(ancestor::div[ancestor::div[. is $thisDiv]])"/>
        <xsl:element name="h{$count + 1}">
            <xsl:if test="@n">
                <xsl:attribute name="class" select="if (xs:integer(@n) gt 0) then 'error' else 'checked'"/>
            </xsl:if>
 
            <xsl:apply-templates select="@n|node()" mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="head/@n" mode="main">
        <xsl:attribute name="data-n" select="."/>
    </xsl:template>
        
    <xsl:template match="row" mode="main">
        <tr>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </tr>
    </xsl:template>
    
    <xsl:template match="cell/@rend | table/@rend" mode="main"/>
    
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
        <xsl:param name="currDivId" tunnel="yes"/>

        <ul>
            <xsl:copy-of select="$toc"/>
            <!--
            <li><a href="full.html">
                <xsl:if test="$currDivId = $sourceDoc/@xml:id">
                    <xsl:attribute name="class" select="'selected'"/>
                </xsl:if>
                Read the entire documentation (large file)</a></li>-->
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
    
    
    <xsl:template match="xh:html/@id" mode="xh">
   
        <xsl:param name="thisDiv" tunnel="yes"/>
        <xsl:attribute name="id">
            <xsl:value-of select="
                if ($thisDiv/self::front) then 'index'
                else if ($thisDiv/self::TEI) then 'full'
                else $thisDiv/@xml:id"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="xh:head/xh:title" mode="xh">
        <xsl:param name="thisDiv" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            WEA Documentation: <xsl:value-of select="$thisDiv/head[1]"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xh:article/xh:h2" mode="xh">
        <xsl:param name="thisDiv" tunnel="yes"/>
        <xsl:copy>
            <xsl:value-of select="$thisDiv/head"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xh:link[@rel='stylesheet']/@href | xh:script/@src" mode="xh">
        <xsl:attribute name="{local-name()}">
            <xsl:value-of select="substring-after(.,'../')"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="xh:div[@id='appendix']" mode="xh">
        <xsl:param name="thisDiv" tunnel="yes"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="specLinks" select="$sourceDoc//ref[starts-with(@target,'#TEI.')]/@target/substring-after(.,'#')"/>
            <xsl:for-each select="distinct-values($specLinks)">
                <xsl:variable name="thisLink" select="."/>
                <div id="snippet_{.}">
                    <xsl:apply-templates select="$sourceDoc//div[@xml:id=$thisLink]/p[1]" mode="appendix"/>
                </div>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="p" mode="appendix">
        <div class="p">
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    
    <xsl:template match="*" priority="-1" mode="appendix">
        <xsl:apply-templates select="." mode="main"/>
    </xsl:template>
    
    <xsl:template match="ref" mode="appendix"/>
    
    <xsl:template match="p/text()" mode="appendix">
        <xsl:value-of select="replace(replace(.,'\[\s*$',''),'^\s*\]','')"/>
    </xsl:template>
    
    <!--TOC TEMPLATES-->
    
    <xsl:template match="teiHeader" mode="toc"/>

    <xsl:template match="div[head]" mode="toc">
        <xsl:param name="currDivId" tunnel="yes"/>
        <xsl:variable name="hasNestedDivs" select="exists(child::div[head])"/>
        <xsl:variable name="hasSelectedDiv" select="exists(descendant-or-self::div[@xml:id=$currDivId])"/>
        <xsl:variable name="headAtts" as="attribute()*">
            <xsl:if test="head[@n]">
                <xsl:attribute name="data-n" select="head/@n"/>
                <xsl:attribute name="class" select="if (head/@n/xs:integer(.) gt 0) then 'error' else 'checked'"/>
            </xsl:if>
        </xsl:variable>
        
        <li>
            <xsl:copy-of select="$headAtts"/>
            <xsl:if test="($hasNestedDivs or $hasSelectedDiv)">
                <xsl:attribute name="class" select="string-join((if ($hasNestedDivs) then 'collapse' else (), if ($hasSelectedDiv) then 'open' else 'closed'),' ')"/>
            </xsl:if>
            <xsl:if test="$hasNestedDivs">
                <span class="toggle"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="wea:getId(.) = $currDivId">
                    <span class="selected">
                                      <xsl:value-of select="head"/>
                    </span>
                </xsl:when>
                <xsl:when test="not(@xml:id)">
                    <a href="{ancestor::div[@xml:id][1]/@xml:id}.html#{generate-id(.)}"><xsl:value-of select="head"/></a>
                </xsl:when>
                <xsl:otherwise>
                    <a href="{@xml:id}.html"><xsl:value-of select="head"/></a>
                </xsl:otherwise>
            </xsl:choose>
           <xsl:if test="$hasNestedDivs">
               <ul>
                   <xsl:apply-templates select="child::div[head]" mode="#current"/>
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