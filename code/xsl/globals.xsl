<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:param name="verbose">false</xsl:param>
    <xsl:param name="outDir"/>
    
    
    <xsl:variable name="sourceDir" select="'../../data/'"/>
    
    
    <xsl:variable name="productsDir" select="'../../products/'"/>
    
    <xsl:variable name="today" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
    
    
    
    <xsl:variable name="originalXmlDir" select="concat($productsDir,'xml/original/')"/>
    <xsl:variable name="standaloneXmlDir" select="concat($productsDir,'xml/standalone/')"/>
    
    <!--NOTE TO SELF: These collections should be written without the trailing //TEI
         as per the Saxon spec: https://www.saxonica.com/html/documentation/sourcedocs/collections.html-->
    
    <xsl:variable name="sourceXml" select="collection(concat($sourceDir,'?select=*.xml&amp;recurse=yes'))//TEI"/>
    
    <xsl:variable name="originalXml" select="collection(concat($originalXmlDir,'?select=*.xml&amp;recurse=yes'))//TEI"/>
    
    <xsl:variable name="standaloneXml" select="collection(concat($standaloneXmlDir,'?select=*.xml&amp;recurse=yes'))//TEI"/>
    
    <xsl:variable name="personography" select="$standaloneXml[@xml:id='people']" as="element(TEI)"/>
    
    <xsl:variable name="taxonomies" select="$standaloneXml[@xml:id='taxonomies']" as="element(TEI)"/>
    
    <xsl:variable name="prefixDefs" select="$taxonomies/descendant::prefixDef" as="element(prefixDef)+"/>
    
    <xsl:variable name="pdfFileSizeDoc" select="unparsed-text(concat($productsDir,'facsimiles/pdfs.txt'))"/>
    <xsl:variable name="pdfFileSizeDocLines" select="tokenize($pdfFileSizeDoc,'\n')"/>
    
    <xsl:variable name="pngFileSizeDoc" select="unparsed-text(concat($productsDir,'facsimiles/pngs.txt'))"/>
    <xsl:variable name="pngFileSizeDocLines" select="tokenize($pngFileSizeDoc,'\n')"/>
    
    <xsl:function name="wea:getPDFSize">
        <xsl:param name="pdfName"/>
        <xsl:if test="unparsed-text-available(concat($productsDir,'facsimiles/pdfs.txt'))">
            <xsl:variable name="thisLine" select="for $p in $pdfFileSizeDocLines return if (ends-with($p,$pdfName)) then $p else ()" as="xs:string"/>
            <xsl:variable name="size" select="normalize-space(tokenize($thisLine,'\t')[1])"/>
            <xsl:variable name="regex">^\s*([\d\.]+)([A-Z]+)$</xsl:variable>
            <xsl:variable name="integer" select="replace($size,$regex,'$1')"/>
            <xsl:variable name="unit" select="replace($size,$regex,'$2')"/>
            <xsl:value-of select="concat($integer, ' ', replace($unit,'K','k'),'B')"/>
        </xsl:if>
        
    </xsl:function>
    
    <xsl:function name="wea:getPNGHeight" as="xs:integer">
        <xsl:param name="pngName"/>
        <xsl:if test="unparsed-text-available(concat($productsDir,'facsimiles/pngs.txt'))">
            <xsl:variable name="thisLine" select="for $p in $pngFileSizeDocLines return if (matches($p,concat('^.+/',$pngName,'.png:'))) then $p else ()" as="xs:string"/>
            <xsl:variable name="size" select="normalize-space(tokenize(substring-after($thisLine,':'),'\s*,\s*')[2])"/>
            <xsl:variable name="height" select="normalize-space(substring-before($size,'x'))"/>
            <xsl:value-of select="xs:integer($height)"/>
        </xsl:if>
        
    </xsl:function>
    
    <xsl:template name="generateTeiPage">
  
        <xsl:param name="outDoc"/>
        <xsl:param name="thisId"/>
        <xsl:param name="title"/>
        <xsl:param name="categories"/>
        <xsl:param name="content"/>
        <xsl:message>Generating <xsl:value-of select="$outDoc"/></xsl:message>
        <xsl:result-document href="{$outDoc}" method="xml" indent="yes">
            <TEI xml:id="{$thisId}" xmlns="http://www.tei-c.org/ns/1.0">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title><xsl:sequence select="$title"/></title>
                        </titleStmt>
                        <publicationStmt>
                            <p>???</p>
                        </publicationStmt>
                        <sourceDesc>
                            <p>No Source born digital/</p>
                        </sourceDesc>
                    </fileDesc>
                    <profileDesc>
                        <textClass>
                            <xsl:for-each select="$categories">
                                <catRef scheme="wdt:docType" target="{.}"/>
                            </xsl:for-each>
                        </textClass>
                    </profileDesc>
                    <revisionDesc>
                        <change when="{$today}">Generated page.</change>
                    </revisionDesc>
                </teiHeader>
                <text>
                  <xsl:copy-of select="$content"/>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>