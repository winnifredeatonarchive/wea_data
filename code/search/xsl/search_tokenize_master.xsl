<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:hcmc="http://hcmc.uvic.ca/ns" version="3.0"
    xmlns:wea="http://winnifredeatonarchive.github.io"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:jt="http://github.com/joeytakeda">
    
    <xsl:include href="https://raw.githubusercontent.com/joeytakeda/xslt-stemmer/master/porterStemmer.xsl"/>
    <xsl:include href="search_globals_module.xsl"/>
    
    
    <xsl:function name="wea:makeRegex" as="xs:string">
        <xsl:param name="seq"/>
        <xsl:variable name="ordered" as="xs:string+">
            <xsl:for-each select="$seq">
                <xsl:sort select="string-length(.)" order="ascending"/>
                <xsl:value-of select="."/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="concat('^(',string-join(for $s in $ordered return concat('(',$s,')'),'|'),')$')"/>
    </xsl:function>
    
    <xsl:template match="/">
        <xsl:message>Initializing...</xsl:message>
    
        <xsl:for-each select="$contentDocs">
            <xsl:message>Processing <xsl:value-of select="//html/@id"/></xsl:message>
            <xsl:result-document href="{concat($tokenizedDir,'/', //html/@id,'.html')}">
                <xsl:apply-templates mode="tokenize"/>
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
        <xsl:variable name="currNode" select="."/>
        <xsl:analyze-string select="normalize-space(.)" regex="[A-Za-z\d]+">
            <xsl:matching-substring>
                <xsl:variable name="word" select="."/>
                <xsl:variable name="lc" select="lower-case($word)"/>
                <xsl:choose>
                    <xsl:when test="hcmc:shouldIndex($lc)">
                        <xsl:call-template name="performStem">
                            <xsl:with-param name="context" select="$currNode"/>
                        </xsl:call-template>
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
    
    <xsl:template name="performStem">
        <xsl:param name="context"/>
        <xsl:variable name="word" select="."/>
        <xsl:variable name="stem" select="xs:string(jt:stem($word))"/>
        <xsl:variable name="same" select="$stem = $word" as="xs:boolean"/>
        <xsl:variable name="start" select="lower-case(substring($word,1,1))"/>
        <xsl:choose>
            <xsl:when test="$same">
                <span>
                    <xsl:attribute name="data-stem" select="$stem"/>
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
           
            <xsl:otherwise>
                <xsl:variable name="startsWithCap" select="matches($word,'^[A-Z]')" as="xs:boolean"/>
                <xsl:variable name="containsDigit" select="matches($word,'\d+')" as="xs:boolean"/>
                <span>
                    <xsl:attribute name="data-stem" select="if ($containsDigit) then $word else string-join(($stem,if ($startsWithCap) then $word else ()),' ')"/>
                    <xsl:value-of select="."/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <xsl:template match="@*|node()" priority="-1" mode="tokenize">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="wea:shouldIndex" type="function">wea:shouldIndex</xd:ref> 
            is a function to determine whether a term should be indexed or not. 
            </xd:desc>
        <xd:param name="lcWord">the lower-case form of the term</xd:param>
    </xd:doc>
    <xsl:function name="hcmc:shouldIndex" as="xs:boolean">
        <xsl:param name="lcWord" as="xs:string"/>
        <xsl:sequence select="string-length($lcWord) gt 2 and not($lcWord = $englishStopwords)"/>
    </xsl:function>
</xsl:stylesheet>