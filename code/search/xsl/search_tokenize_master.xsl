<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:hcmc="http://hcmc.uvic.ca/ns" version="3.0"
    xmlns:jt="http://github.com/joeytakeda">
    
    <xsl:include href="https://raw.githubusercontent.com/joeytakeda/xslt-stemmer/master/porterStemmer.xsl"/>
    <xsl:include href="search_globals_module.xsl"/>
    
       
    <xsl:variable name="tokenRegex" select="'[A-Za-z\d]+'"/>
    
    <xsl:variable name="words" as="xs:string+">
        <xsl:for-each select="$contentDocs//descendant::text()[not(matches(.,'^\s+$'))][ancestor::div[@id='mainBody']][not(ancestor::div[@id='appendix'])][not(ancestor::div[@id='metadata'])]">
            <xsl:analyze-string select="normalize-space(.)" regex="{$tokenRegex}">
                <xsl:matching-substring>
                    <xsl:value-of select="."/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:for-each>
    </xsl:variable>
    
    
    <xsl:variable name="tokenMap" as="map(xs:string, item()*)">
        <xsl:message>Tokenizing words...</xsl:message>
        <xsl:map>
            <xsl:for-each select="distinct-values($words)">

                <xsl:variable name="word" select="."/>
                <xsl:variable name="stem" select="xs:string(jt:stem(.))"/>
                <xsl:variable name="same" select="$stem = $word" as="xs:boolean"/>
                <xsl:variable name="useStem" as="xs:boolean">
                    <xsl:choose>
                        <xsl:when test="matches($word,'^[A-Z]')">
                            <xsl:value-of select="false()"/>
                        </xsl:when>
                        <xsl:when test="matches($word,'\d+')">
                            <xsl:value-of select="false()"/>
                        </xsl:when>
                        <xsl:when test="not($word=$englishWords)">
                            <xsl:value-of select="false()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="true()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
               
               <xsl:message>Word: <xsl:value-of select="$word"/>; use stem: <xsl:value-of select="$useStem"/></xsl:message>
                <xsl:map-entry key="xs:string($word)" select="($stem,$useStem)"/>
                
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:for-each select="$contentDocs">
            <xsl:result-document href="{concat($tokenizedDir,'/',//html/@id,'.html')}">
                <xsl:apply-templates select="." mode="tokenize"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    
    
    
    <xsl:template match="html" mode="tokenize">
        <xsl:copy>
            <xsl:copy-of select="@*|head"/>
            <xsl:apply-templates select="body" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    
    
    <xd:doc scope="component">
        <xd:desc>The meat: tokenizing text nodes.</xd:desc>
    </xd:doc>
    <xsl:template match="text()[not(matches(.,'^\s+$'))][ancestor::div[@id='mainBody']][not(ancestor::div[@id='appendix'])][not(ancestor::div[@id='metadata'])]" mode="tokenize">
        <xsl:variable name="isForeign" select="exists(ancestor::span[@data-el='foreign'])"/>
        <xsl:analyze-string select="normalize-space(.)" regex="[A-Za-z\d]+">
            <xsl:matching-substring>
                
                <xsl:variable name="word" select="."/>
                
                <xsl:variable name="lc" select="lower-case($word)"/>
                
                <xsl:variable name="entry" select="$tokenMap($word)"/>
                <xsl:variable name="stem" select="$entry[1]" as="xs:string"/>
                <xsl:variable name="useStem" select="$entry[2]" as="xs:boolean"/>
                <xsl:choose>
                    <xsl:when test="hcmc:shouldIndex($lc)">
                        
                        <span>
                            <xsl:attribute name="data-stem" select="$stem"/>
                            <xsl:attribute name="data-useStem" select="$useStem"/>
                            <xsl:value-of select="."/>
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        
    </xsl:template>
    
    <xsl:template match="@*|node()" priority="-1" mode="tokenize">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="hcmc:shouldIndex" type="function">hcmc:shouldIndex</xd:ref> 
            is a function to determine whether a term should be indexed or not. 
            <xd:ref name="lcWord" type="parameter">lcWord</xd:ref> is the lower-case form of the term.</xd:desc>
    </xd:doc>
    <xsl:function name="hcmc:shouldIndex" as="xs:boolean">
        <xsl:param name="lcWord" as="xs:string"/>
        <xsl:sequence select="string-length($lcWord) gt 2 and not($lcWord = $englishStopwords)"/>
    </xsl:function>
</xsl:stylesheet>