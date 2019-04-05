<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:include href="../../sch/weaQuickFixTemplates.xsl"/>
    
    
    <xsl:template name="makeDocumentation">
        <xsl:apply-templates mode="second"/>
    </xsl:template>
    
    <xsl:output indent="yes" suppress-indentation="ref"/>
    
    <xsl:template match="TEI" mode="second">
        <xsl:copy>
            <xsl:attribute name="xml:id" select="'documentation'"/>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="TEI/@xml:id" mode="second"/>
    
    <xsl:template match="tei:*[ancestor::back]/@rend| tei:*/@xml:base | tei:*/@xml:lang | eg:egXML/@xml:space | tei:*/@xml:space" mode="second"/>
    
    <xsl:template match="index" mode="second"/>
    
    <xsl:template match="c|seg" mode="second">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="choice[abbr and expan]" mode="second">
        <xsl:apply-templates select="expan/node()" mode="#current"/>
    </xsl:template>
    
    
    
    <xsl:template match="hi[starts-with(string-join(text(),''),'@')]" mode="second">
        <att>
            <xsl:value-of select="substring-after(string-join(text(),''),'@')"/>
        </att>
    </xsl:template>
    
    <xsl:template match="processing-instruction('TEIVERSION')" mode="second"/>
    
    
    <xsl:template match="row[cell[normalize-space(string-join(descendant::text(),''))='Example']][descendant::eg:egXML[descendant::eg:egXML]]" mode="second"/>
    
    <xsl:template match="hi" mode="second">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="back/div/div[not(@xmlid)][head]" mode="second">
        <xsl:copy>
            <xsl:attribute name="xml:id" select="lower-case(translate(normalize-space(string-join(head,'')),' ', '_'))"/>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="row" mode="second">
        <xsl:choose>
            <xsl:when test="normalize-space(string-join(cell[1]/descendant::text(),'')) = ('Schema Declaration', 'Declaration')"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()" mode="#current"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    

    <xsl:template match="item[not(ancestor::list)]" mode="second">
        <list>
           <xsl:copy>
               <xsl:apply-templates select="@*|node()" mode="#current"/>
           </xsl:copy>
        </list>
    </xsl:template>
    
    
    
    <xsl:template match="ab[not(ancestor::ab)][ab]" mode="second">
        <list>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </list>
    </xsl:template>
    
    <xsl:template match="ab[ancestor::ab]" mode="second">
        <item>
            <xsl:choose>
                <xsl:when test="ab">
                    <list>
                        <xsl:apply-templates select="@*|node()" mode="#current"/>
                    </list>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="node()" mode="#current"/>
                </xsl:otherwise>
            </xsl:choose>
        </item>
    </xsl:template>
    
    <xsl:template match="ptr[@target]" mode="second">
        <ref target="{@target}"><xsl:value-of select="@target"/></ref>
    </xsl:template>
    
    <xsl:template match="soCalled | mentioned" mode="second">
        <q>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </q>
    </xsl:template>
    
    <xsl:template match="tei:ab[@xml:space='preserve'][contains(.,'&lt;')][not(ancestor::div[head/text()='Constraints'])] " mode="second">
        <code>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </code>
    </xsl:template>
    
    <xsl:template match="eg[@xml:space='preserve'][@rend='eg_rnc']" mode="second">
        <code>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </code>
    </xsl:template>
    
    <xsl:template match="ref/text()" mode="second">
        <xsl:variable name="p1">
            <xsl:choose>
                <xsl:when test="not(preceding-sibling::node()) and not(following-sibling::node())">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:when>
                <xsl:when test="not(preceding-sibling::node()) and following-sibling::node()">
                    <xsl:value-of select="replace(.,'^\s+','')"/>
                </xsl:when>
                <xsl:when test="preceding-sibling::node() and not(following-sibling::node())">
                    <xsl:value-of select="replace(.,'\s$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
         
        </xsl:variable>
        <xsl:analyze-string select="$p1" regex="^&lt;(.+)&gt;$">
            <xsl:matching-substring>
                <gi><xsl:value-of select="regex-group(1)"/></gi>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <xsl:template match="div[table[row/cell/@cols='2']]" mode="second">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="table/preceding-sibling::node()" mode="#current"/>
            <p><xsl:apply-templates select="table/row/cell[@cols='2']/node()" mode="#current"/></p>
            <xsl:apply-templates select="table|table/following-sibling::node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="hi[@rend='label']" mode="second">
        <label>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </label>
    </xsl:template>
    
    <xsl:template match="div/table/row[cell[@cols='2']]" mode="second"/>
    
    
    <xsl:template match="ab[@xml:space='preserve'][@rend='pre'][ancestor::back][ancestor::div[normalize-space(string-join(head/text(),''))='Constraints']] | eg[@xml:space='preserve'][not(@rend='eg_rnc')]" mode="second">
        <code>
            <xsl:value-of select="replace(.,' ',' ')"/>
        </code>
    </xsl:template>
    

    
    <xsl:template match="q[ancestor::back]" mode="second">
        <xsl:text>"</xsl:text><xsl:apply-templates mode="#current"/><xsl:text>"</xsl:text>
    </xsl:template>
    
    <xsl:template match="@*|node()" mode="second addNs" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
  <!--  <xsl:template match="text()[not(ancestor::code)]" mode="second">
        <xsl:variable name="loq">‘</xsl:variable>
        <xsl:variable name="lcq">’</xsl:variable>
        <xsl:variable name="doq">“</xsl:variable>
        <xsl:variable name="dcq">”</xsl:variable>
        <xsl:variable name="p1" as="xs:string">
            <xsl:call-template name="replaceApos">
                <xsl:with-param name="useDq" select="false()"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="p2" as="xs:string">
            <xsl:variable name="result"><xsl:for-each select="$p1">
                <xsl:call-template name="replaceApos">
                    <xsl:with-param name="useDq" select="true()"/>
                </xsl:call-template>
            </xsl:for-each></xsl:variable>
            <xsl:value-of select="string-join($result,'')"/>
        </xsl:variable>
        <xsl:for-each select="$p2">
            <xsl:call-template name="tagQuote">
                <xsl:with-param name="left" select="$loq"/>
                <xsl:with-param name="right" select="$lcq"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>-->
    
    
    
    
</xsl:stylesheet>