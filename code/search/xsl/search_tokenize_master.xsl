<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:hcmc="http://hcmc.uvic.ca/ns" version="3.0"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
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
    
    <!--We stash a version of the nonEnglishWordsFile in the Github repo and grab it if it's available; 
        this will make dictionary look ups must faster-->
    <xsl:variable name="nonEnglishWordsFile" select="if (unparsed-text-available('https://raw.githubusercontent.com/winnifredeatonarchive/wea/master/js/search/nonEnglishWordList.txt')) then unparsed-text('https://raw.githubusercontent.com/winnifredeatonarchive/wea/master/js/search/nonEnglishWordList.txt') else ()"/>
    
    <xsl:variable name="nonEnglishWords" select="tokenize($nonEnglishWordsFile,'\n')" as="xs:string+"/>
   
    <xsl:variable name="distinctWords" select="distinct-values($words)"/>
    <xsl:variable name="tokenMap" as="map(xs:string, item()*)">
        <xsl:message>Tokenizing words...</xsl:message>

        <!--First create the map-->
       <xsl:map>
           <xsl:for-each-group select="$words" group-by=".">
               <xsl:variable name="word" select="current-grouping-key()"/>
               <xsl:message>Processing <xsl:value-of select="$word"/></xsl:message>
               <xsl:variable name="stem" select="xs:string(jt:stem($word))"/>
               <xsl:variable name="same" select="$stem = $word" as="xs:boolean"/>
               <xsl:variable name="startsWithCap" select="matches($word,'^[A-Z]')" as="xs:boolean"/>
               <xsl:variable name="containsDigit" select="matches($word,'\d+')" as="xs:boolean"/>
               <xsl:variable name="isForeign" as="xs:boolean">
                   <xsl:choose>
                       <xsl:when test="$startsWithCap or $containsDigit">
                           <xsl:value-of select="false()"/>
                       </xsl:when>
                       <xsl:when test="$word=$nonEnglishWords">
                           <xsl:value-of select="true()"/>
                       </xsl:when>
                       <xsl:when test="not($word=$englishWords)">
                           <xsl:value-of select="true()"/>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:value-of select="false()"/>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:variable>
               <xsl:variable name="useStem" select="if ($startsWithCap or $containsDigit or $isForeign) then false() else true()" as="xs:boolean"/>
               
               <xsl:map-entry key="xs:string($word)" select="($startsWithCap, $containsDigit, $isForeign, (if ($useStem) then $stem else $word))"/>
               
           </xsl:for-each-group>
                
        
       </xsl:map>
  
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:for-each select="$contentDocs">
            <xsl:result-document href="{concat($tokenizedDir,'/',//html/@id,'.html')}">
                <xsl:apply-templates select="." mode="tokenize"/>
            </xsl:result-document>
        </xsl:for-each>
        <xsl:call-template name="createForeignWordList"/>
    </xsl:template>
    
    
    <xsl:template name="createForeignWordList">
        <xsl:result-document href="../../products/js/search/nonEnglishWordList.txt" method="text">
            <xsl:for-each select="$distinctWords">
                <xsl:variable name="entry" select="$tokenMap(.)"/>
                <xsl:if test="$entry[3]">
                    <xsl:message>Found foreign word to add to list! <xsl:value-of select="."/></xsl:message>
                    <xsl:value-of select="."/><xsl:text>&#xA;</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:result-document>
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
                
                <xsl:variable name="result" select="$tokenMap($word)"/>
                <xsl:variable name="startsWithCap" select="$result[1]"/>
                <xsl:variable name="containsDigit" select="$result[2]"/>
                <xsl:variable name="isForeign" select="($result[3] or exists($currNode/ancestor::span[@data-el='foreign']))"/>
                <xsl:variable name="stem" select="$result[4]"/>
                
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