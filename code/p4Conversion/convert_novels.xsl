<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    
    <xsl:output indent="yes" suppress-indentation="text body div p hi"/>
    <xsl:include href="../../data/sch/weaQuickFixTemplates.xsl"/>
    
    <xsl:variable name="heart" select="doc('../../data/texts/HeartOfHyacinth1.xml')"/>
    <xsl:variable name="japan" select="doc('../../data/texts/JapaneseBlossom1.xml')"/>
    <xsl:variable name="owjapan" select="doc('owjapan.xml')"/>
    <xsl:variable name="owheart" select="doc('owheart.xml')"/>
    
    <xsl:template match="/">
        <xsl:call-template name="convert">
            <xsl:with-param name="weaDoc" select="$heart"/>
            <xsl:with-param name="oldDoc" select="$owheart"/>
        </xsl:call-template>
        
        <xsl:call-template name="convert">
            <xsl:with-param name="weaDoc" select="$japan"/>
            <xsl:with-param name="oldDoc" select="$owjapan"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="convert">
        <xsl:param name="weaDoc" as="document-node()"/>
        <xsl:param name="oldDoc" as="document-node()"/>
        <xsl:result-document href="../out/{$weaDoc//TEI/@xml:id}.xml">
            <xsl:variable name="convertedDoc">
                <xsl:apply-templates select="$oldDoc" mode="pass1"/>
            </xsl:variable>
            <xsl:variable name="combined">
                <xsl:apply-templates select="$weaDoc" mode="pass2">
                    <xsl:with-param name="convertedDoc" select="$convertedDoc" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:variable>
            <xsl:apply-templates select="$combined" mode="fix"/>
        </xsl:result-document>
        
    </xsl:template>
    
    
    
    
    <!--get rid of the pages attribute-->
    
    <!--And get rid of facs on pages; not necessary for us yet-->
    <xsl:template match="pb/@pages | pb/@facs" mode="pass1"/>
    
    <!--The @n attirbutes for the pages contain running header information,
        whcih we don't capture-->
    <xsl:template match="pb/@n" mode="pass1">
        <xsl:attribute name="n">
            <xsl:value-of select="replace(.,'^(\d+(\.\d+)?).+','$1')"/> 
        </xsl:attribute>
    </xsl:template>
    
    
    <xsl:template match="@rend" mode="pass1">
        <xsl:choose>
            <xsl:when test=".='italic'">
                <xsl:attribute name="style" select="'font-style:italic;'"/>
            </xsl:when>
            <xsl:when test=".='inline'"/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="figure/p" mode="pass1">
        <head><xsl:apply-templates mode="#current"/></head>
    </xsl:template>
    
    <!--Empty authorsdon't mean anything at all-->
    <xsl:template match="author[normalize-space(string-join(descendant::text(),''))='']" mode="pass1"/>
    
    <xsl:template match="author[ancestor::titleStmt][name/choice]" mode="pass1">
        <author><xsl:value-of select="name/choice/reg"/></author>
    </xsl:template>
    
    <!--Split up the respStmt into two; semantically identical-->
    <xsl:template match="seriesStmt/respStmt" mode="pass1">
        <xsl:for-each select="name">
            <respStmt>
                <xsl:copy-of select="../resp"/>
                <xsl:copy-of select="."/>
            </respStmt>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="q[q[floatingText]]" mode="pass1">
        <xsl:apply-templates select="q/floatingText" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="milestone[@rend='blank-line']" mode="pass1"/>
        
    <!--This is an odd practice they engaged in: adding a <pb/> that had an @n
        to signify the new chapter beginning. That ought to have been a milestone
        in the first place, but we'll delete it here-->
    
    <xsl:template match="pb[@n][following-sibling::*[1]/self::div[@type='chapter']]" mode="pass1"/>

    <!--Remove the front matter-->
    <xsl:template match="front" mode="pass1"/>
    
    <!--Get rid of the @xml:ids on paragraphs, since they're not strictly
        necessary-->
    <xsl:template match="p/@xml:id" mode="pass1"/>
    
    <!--And then I'll have to run it through the "fixing" code generated
    from the XSLT quick fixes-->
    
    
    <!--Now add this stuff to the file desc-->
    <xsl:template match="sourceDesc" mode="pass2">
        <xsl:param name="convertedDoc" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <biblFull>
                <xsl:copy-of select="$convertedDoc//teiHeader/fileDesc/node()" copy-namespaces="no"/>
            </biblFull>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="body" mode="pass2">
        <xsl:param name="convertedDoc" tunnel="yes"/>
        <xsl:copy>
            <xsl:copy-of select="$convertedDoc//TEI/text/body/node()" copy-namespaces="no"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!--Templates in "fix" are simply ones that the run the text through
        our standardized process for quickfixing.-->
    <xsl:template match="p/text() | figure/head/text()" mode="fix">
        <xsl:variable name="norm">
            <xsl:choose>
                <xsl:when test="not(preceding-sibling::text()) and not(following-sibling::text())">
                    <xsl:value-of select="replace(.,'(^\s+|\s+$)','')"/>
                </xsl:when>
                <xsl:when test="not(preceding-sibling::text()) and following-sibling::text()">
                    <xsl:value-of select="replace(.,'^\s+','')"/>
                </xsl:when>
                <xsl:when test="preceding-sibling::text() and not(following-sibling::text())">
                    <xsl:value-of select="replace(.,'\s+$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>

        </xsl:variable>
        
        <xsl:variable name="doubleQuotes" as="xs:string">
            <xsl:variable name="temp">
                <xsl:for-each select="$norm">
                    <xsl:call-template name="replaceApos">
                        <xsl:with-param name="useDq" select="true()"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="string-join($temp,'')"/>
        </xsl:variable>
        
        <xsl:variable name="singleQuotes" as="xs:string">
            <xsl:variable name="temp">
                <xsl:for-each select="$doubleQuotes">
                    <xsl:call-template name="replaceApos">
                        <xsl:with-param name="useDq" select="false()"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="string-join($temp,'')"/>
        </xsl:variable>
        
        
        <xsl:for-each select="$singleQuotes">
            <xsl:call-template name="tagQuote">
                <xsl:with-param name="left">“</xsl:with-param>
                <xsl:with-param name="right">”</xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:template match="@*|node()" priority="-1" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>