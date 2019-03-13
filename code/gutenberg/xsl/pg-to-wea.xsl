<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    
    <!--this is a basic stylesheet to convert the HTML generated from PG to WEA standards-->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="html">
        <TEI xml:id="{substring-before(tokenize(document-uri(/),'/')[last()],'.htm')}">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>ADD TITLE</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>ADD STUFF HERE</p>
                    </publicationStmt>
                    
                    <sourceDesc>
                        <bibl>
                            Originally from Project Gutenberg
                        </bibl>
                        
                    </sourceDesc>
                    
                </fileDesc>
                <profileDesc>
                    <textClass>
                        <catRef target="wdt:Japan" scheme="wdt:category"/>
                        <catRef target="wdt:docPrimarySourcePublished" scheme="wdt:docType"/>
                        <catRef target="wdt:genreNovel" scheme="wdt:genre"/>
                    </textClass>
                </profileDesc>
                <revisionDesc>
                    <change who="pers:JT1" when="2019-03-12">Created file from Project Gutenberg transcription.</change>
                </revisionDesc>
            </teiHeader>
            <xsl:apply-templates select="body"/>
        </TEI>
    </xsl:template>
    
    <xsl:template match="body">
        <text>
            <body>
                <xsl:for-each-group select="*[not(self::pre)]" group-starting-with="h2 | div[@class='chapter']">
                    <div type="chapter">
                        <xsl:apply-templates select="current-group()"/>
                    </div>
                </xsl:for-each-group>
            </body>
        </text>
    </xsl:template>
    
    <xsl:template match="img">
        <figure>
            <graphic url="{@src}"/>
        </figure>
    </xsl:template>
    
    <xsl:template match="div[@class='tnbox']">
            <xsl:comment>
                <xsl:apply-templates/>
            </xsl:comment>
    </xsl:template>
    
    <xsl:template match="div[@class='nf-center-c0'][matches(string-join(descendant::text(),''),'Chapter','i')]"/>
    
    <xsl:template match="div[text() and not(*)]" priority="-1">
        <ab>
            <xsl:apply-templates/>
        </ab>
    </xsl:template>
    
    <xsl:template match="i">
        <hi style="font-style:italic"><xsl:apply-templates/></hi>
    </xsl:template>
    
    <xsl:template match="table">
        <list type="toc">
            <xsl:apply-templates/>
        </list>
    </xsl:template>
    
    <xsl:template match="tr">
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>
    
    <xsl:template match="td[1]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="td[a]">
        <ref target="{a/@href}"><xsl:apply-templates/></ref>
    </xsl:template>
    
    
    
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="p[count(child::node())=1][span[@class='pagenum']]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="span[@class='pagenum']">
        <pb n="{tokenize(a/@id,'_')[last()]}" xml:id="{a/@id}"/>
    </xsl:template>
    
    <xsl:template match="div[@class='linegroup']">
        <lg>
            <xsl:apply-templates/>
        </lg>

    </xsl:template>
    
    <xsl:template match="img[@class='drop-capi']"/>
    
    <xsl:template match="div[matches(@class,'line(\s+|$)')]">
        <l>
            <xsl:if test="matches(@class,'\s*in\d+')">
                <xsl:attribute name="style" select="concat('margin-left: ', replace(@class,'(.*)in(\d+)','$2'),'em')"/>
            </xsl:if>
            <xsl:apply-templates/></l>
    </xsl:template>
    
    <xsl:template match="hr[contains(@class,'pb')]">
        <pb/>
    </xsl:template>
    
    
    <xsl:template match="h2">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    
    
</xsl:stylesheet>