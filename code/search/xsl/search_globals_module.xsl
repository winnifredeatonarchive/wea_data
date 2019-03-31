<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:hcmc="http://hcmc.uvic.ca/ns" version="3.0"
    xmlns:jt="http://github.com/joeytakeda">
    
    <xsl:variable name="tokenizedDir" select="'../../temp/tokenized/'"/>
    
    <xsl:variable name="tokenizedDocs" select="collection(concat('../',$tokenizedDir,'?select=*.html&amp;recurse=no'))"/>
    
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="simpleDict">simpleDict</xd:ref> is a plain-text file downloaded from
            https://github.com/dolph/dictionary/blob/master/popular.txt, containing a list of popular
            English words. We use this to guess whether a word which starts with a capital at the
            beginning of a sentence is a regular word or a proper noun.</xd:desc>
    </xd:doc>
    <xsl:variable name="simpleDict" select="unparsed-text('../utilities/english_words.txt')"/>
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="englishWords">englishWords</xd:ref> is a sequence of xs:strings
            containing the words from the simpleDict source.</xd:desc>
    </xd:doc>
    <xsl:variable name="englishWords" select="tokenize($simpleDict, '\s+')"/>
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="stopwordsFile">stopwordsFile</xd:ref> is a plain-text file downloaded
            from https://gist.github.com/sebleier/554280, containing a list of stopwords for English. A
            few terms have been added.</xd:desc>
    </xd:doc>
    <xsl:variable name="stopwordsFile" select="unparsed-text('../utilities/english_stopwords.txt')"/>
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="englishStopwords">englishStopwords</xd:ref> is a sequence of xs:strings
            containing the words from the stopwordsFile source.</xd:desc>
    </xd:doc>
    <xsl:variable name="englishStopwords" select="tokenize($stopwordsFile, '\s+')"/>
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="contentDocs">contentDocs</xd:ref> is the complete collection of content
            documents in the content folder.</xd:desc>
    </xd:doc>
    
    <xsl:variable name="contentDocs"
        select="collection('../../../products/site?select=*.html;recurse=no;on-error=ignore')"/>
    
</xsl:stylesheet>