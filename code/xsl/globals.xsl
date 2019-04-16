<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:functx="http://www.functx.com"
    version="3.0">
    
    <xsl:param name="verbose">false</xsl:param>
    <xsl:param name="docsToBuild"/>
    <xsl:param name="outDir"/>
    
    <xsl:variable name="documentationOutDir" select="'../../products/docs'"/>
    
    <xsl:variable name="docsToBuildTokens" select="tokenize($docsToBuild,'\s*,\s*')" as="xs:string+"/>
  
    
    <xsl:variable name="today" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
    
    <xsl:variable name="documentationDocs" select="collection('../../data/documentation?select=*.xml;recurse=no')"/>
    <xsl:variable name="sourceDir" select="concat($outDir,'xml/source/')"/>
    <xsl:variable name="originalXmlDir" select="concat($outDir,'xml/original/')"/>
    <xsl:variable name="standaloneXmlDir" select="concat($outDir,'xml/standalone/')"/>
    
    <!--NOTE TO SELF: These collections should be written without the trailing //TEI
         as per the Saxon spec: https://www.saxonica.com/html/documentation/sourcedocs/collections.html-->
    
    <xsl:variable name="sourceXml" select="collection(concat($sourceDir,'?select=*.xml&amp;recurse=yes'))"/>
    
    <xsl:variable name="originalXml" select="collection(concat($originalXmlDir,'?select=*.xml&amp;recurse=yes'))"/>
    
    <xsl:variable name="standaloneXml" select="collection(concat($standaloneXmlDir,'?select=*.xml&amp;recurse=yes'))"/>
    
    <xsl:variable name="personography" select="$standaloneXml[//TEI/@xml:id='people']" as="element(TEI)"/>
    
    <xsl:variable name="taxonomies" select="$standaloneXml[//TEI/@xml:id='taxonomies']" as="element(TEI)"/>
    
    <xsl:variable name="prefixDefs" select="$taxonomies/descendant::prefixDef" as="element(prefixDef)+"/>
    
    <xsl:variable name="fileSizeDoc" select="unparsed-text(concat($outDir,'info/sizes.txt'))"/>
    <xsl:variable name="fileSizeDocLines" select="tokenize($fileSizeDoc,'\n')"/>
    
    <xsl:variable name="imageSizeDoc" select="unparsed-text(concat($outDir,'info/images.txt'))"/>
    <xsl:variable name="imageSizeDocLines" select="tokenize($imageSizeDoc,'\n')"/>
    
    
    <xsl:function name="wea:getFileSize">
        <xsl:param name="filename"/>
        
        <xsl:variable name="thisLine" select="for $f in $fileSizeDocLines return if (ends-with($f, $filename)) then $f else ()" as="xs:string"/>
        <xsl:variable name="size" select="normalize-space(tokenize($thisLine,'\t')[1])"/>
        <xsl:variable name="regex">^\s*([\d\.]+)([A-Z]+)$</xsl:variable>
        <xsl:variable name="integer" select="replace($size,$regex,'$1')"/>
        <xsl:variable name="unit" select="replace($size,$regex,'$2')"/>
        <xsl:value-of select="concat($integer, ' ', replace($unit,'K','k'),'B')"/>
    </xsl:function>
    
    
    <xsl:function name="wea:getImageDimensions" as="xs:integer+">
        <xsl:param name="pngName"/>
            <xsl:variable name="thisLine" select="for $s in $imageSizeDocLines return if (matches($s,concat('^.+/',functx:escape-for-regex($pngName),'.png:'))) then $s else ()" as="xs:string"/>
            <xsl:variable name="size" select="normalize-space(tokenize(substring-after($thisLine,':'),'\s*,\s*')[2])"/>
            <xsl:variable name="height" select="normalize-space(substring-before($size,'x'))"/>
            <xsl:variable name="width" select="normalize-space(substring-after($size,'x'))"/>
            <xsl:value-of select="xs:integer($height)"/>
            <xsl:value-of select="xs:integer($width)"/>
    </xsl:function>
    
    
    
    
    <xsl:function name="wea:makeTitleSortKey" as="xs:string">
        <xsl:param name="string"/>
        <xsl:variable name="lower" select="lower-case($string)"/>
        <xsl:variable name="first" select="replace($lower,'^(an?|the)\s','')"/>
        <xsl:value-of select="$first"/>
    </xsl:function>
    
    
    <xd:doc>
        <xd:desc>Taken from http://www.xsltfunctions.com/xsl/functx_escape-for-regex.html</xd:desc>
    </xd:doc>
    <xsl:function name="functx:escape-for-regex" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="
            replace($arg,
            '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
            "/>
        
    </xsl:function>
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="wea:getWorkingDocs" type="function">wea:getWorkingDocs</xd:ref>
            takes in a set of documents and returns the set of documents to be processed.</xd:desc>
        <xd:param name="docCollection">A TEI document collection</xd:param>
        <xd:return>A set of TEI documents</xd:return>
    </xd:doc>
    <xsl:function name="wea:getWorkingDocs" as="document-node()+">
        <xsl:param name="docCollection" as="document-node()+"/>
        <xsl:message><xsl:value-of select="count($docCollection)"/></xsl:message>
        <xsl:variable name="out" as="document-node()*">
            <xsl:choose>
                <!--If it is unset, then build all documents-->
                <xsl:when test="$docsToBuild = ''">
                    <xsl:sequence select="$docCollection[/tei:TEI | /tei:teiCorpus]"/>
                </xsl:when>
                <xsl:when test="$docsToBuild = 'DOCUMENTATION'">
                    <xsl:sequence select="$docCollection[descendant::tei:catRef[contains(@target,'Documentation')]]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>Building docs: <xsl:value-of select="$docsToBuild"/></xsl:message>
                    <xsl:for-each select="$docsToBuildTokens">
                        <xsl:variable name="thisToken" select="." as="xs:string"/>
                        <xsl:if test="$verbose='true'">
                            <xsl:message>Processing this token: <xsl:value-of select="$thisToken"/></xsl:message>
                        </xsl:if>
                        <xsl:variable name="thisDoc" select="$docCollection[/tei:TEI[@xml:id=$thisToken]|/tei:teiCorpus[@xml:id=$thisToken]]" as="document-node()*"/>
                        <!--Break if the document chosen doesn't exist-->
                        <xsl:if test="empty($thisDoc)">
                            <xsl:message terminate="yes">ERROR: Cannot find <xsl:value-of select="$thisToken"/></xsl:message>
                        </xsl:if>
                        <xsl:copy-of select="$thisDoc"/>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="$out"/>
    </xsl:function>
    
    
    <xsl:template name="generateTeiPage">
  
        <xsl:param name="outDoc"/>
        <xsl:param name="thisId"/>
        <xsl:param name="title"/>
        <xsl:param name="categories"/>
        <xsl:param name="content"/>
        <xsl:message>Generating <xsl:value-of select="$outDoc"/></xsl:message>
        <xsl:result-document href="{$outDoc}" method="xml" indent="no">
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