<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:hcmc="http://hcmc.uvic.ca/ns" version="3.0"
    xmlns:jt="http://github.com/joeytakeda">
    
    <xsl:include href="https://raw.githubusercontent.com/joeytakeda/xslt-stemmer/master/porterStemmer.xsl"/>
    <xsl:include href="search_globals_module.xsl"/>
    
    
    <xsl:variable name="regex" select="concat('^',string-join(for $e in $englishWords return concat('(',$e,')'),'|'),'$')"/>
    
    <xsl:template match="/">
        <xsl:for-each select="$contentDocs">
            <xsl:result-document href="{concat($tokenizedDir,'/',//html/@id,'.html')}">
                <xsl:apply-templates select="." mode="tokenize"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="html" mode="tokenize">
        <xsl:message>Processing <xsl:value-of select="@id"/></xsl:message>
        <xsl:copy>
            <xsl:copy-of select="@*|head"/>
            <xsl:apply-templates select="body" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    
    
    <xd:doc scope="component">
        <xd:desc>The meat: tokenizing text nodes.</xd:desc>
    </xd:doc>
    <xsl:template match="text()[not(matches(.,'^\s+$'))][ancestor::div[@id='mainBody']][not(ancestor::div[@id='appendix'])]" mode="tokenize">
        <xsl:analyze-string select="normalize-space(.)" regex="[A-Za-z\d]+">
            <xsl:matching-substring>
                
                <xsl:variable name="word" select="."/>

                
                <xsl:variable name="lc" select="lower-case($word)"/>
                
                <xsl:variable name="stem" as="xs:string">
                    <xsl:choose>
                        <xsl:when test="$lc = $englishWords">
                            <xsl:value-of select="jt:stem($lc)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message>Not a common English word: <xsl:value-of select="$word"/></xsl:message>
                            <xsl:value-of select="$word"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="hcmc:shouldIndex($lc)">
                        <span>
                            <xsl:attribute name="data-stem" select="$stem"/>
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