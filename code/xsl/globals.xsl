<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:functx="http://www.functx.com"
    version="3.0">
    
    <xsl:param name="verbose">false</xsl:param>
    <xsl:param name="docsToBuild"/>
    <xsl:param name="outDir"/>
    <xsl:param name="version"/>
    
    <xsl:variable name="documentationOutDir" select="'../../products/docs'"/>
    
    <xsl:variable name="docsToBuildTokens" select="tokenize($docsToBuild,'\s*,\s*')" as="xs:string+"/>
  
    
    <xsl:variable name="today" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
    
    <xsl:variable name="documentationDocs" select="collection('../../data/documentation?select=*.xml;recurse=no')"/>
    <xsl:variable name="sourceDir" select="concat($outDir,'xml/source/')"/>
    <xsl:variable name="originalXmlDir" select="concat($outDir,'xml/original/')"/>
    <xsl:variable name="standaloneXmlDir" select="concat($outDir,'xml/standalone/')"/>
    
    <!--NOTE TO SELF: These collections should be written without the trailing //TEI
         as per the Saxon spec: https://www.saxonica.com/html/documentation/sourcedocs/collections.html-->
    
    <xsl:variable name="sourceXml" select="collection(concat($sourceDir,'?select=*.xml&amp;recurse=no'))"/>
    
    <xsl:variable name="originalXml" select="collection(concat($originalXmlDir,'?select=*.xml&amp;recurse=no'))"/>
    
    <xsl:variable name="standaloneXml" select="collection(concat($standaloneXmlDir,'?select=*.xml&amp;recurse=no'))"/>
    
    <xsl:variable name="xhtmlDocs" select="collection($outDir || '?select=*.html;recurse=no')[not(descendant::*:meta[@http-equiv='refresh'])]"/>
    
    <xsl:variable name="srcPersonography" select="$sourceXml//TEI[@xml:id='people']" as="element(TEI)"/>
    
    <xsl:variable name="personography" select="$standaloneXml[//TEI/@xml:id='people']/TEI" as="element(TEI)"/>
    
    <xsl:variable name="taxonomies" select="$standaloneXml[//TEI/@xml:id='taxonomies']" as="element(TEI)"/>
    
    <xsl:variable name="prefixDefs" select="$taxonomies/descendant::prefixDef" as="element(prefixDef)+"/>
    
    <xsl:variable name="orgIds" select="$sourceXml//org[@xml:id]/@xml:id"/>
    <xsl:variable name="peopleIds" select="$sourceXml//person[@xml:id]/@xml:id"/>
    <xsl:variable name="workIds" select="$sourceXml//listBibl[@xml:id]/@xml:id"/>
    
    <xsl:variable name="fileSizeDoc" select="unparsed-text(concat($outDir,'info/sizes.txt'))"/>
    <xsl:variable name="fileSizeDocLines" select="tokenize($fileSizeDoc,'\n')"/>
    
    <xsl:variable name="imageSizeDoc" select="unparsed-text(concat($outDir,'info/images.txt'))"/>
    <xsl:variable name="imageSizeDocLines" select="tokenize($imageSizeDoc,'\n')"/>
    
    
    <xsl:variable name="dataListLines" select="unparsed-text-lines($outDir || 'info/dataList.txt')"/>

    <xsl:variable name="siteUrl" select="'https://winnifredeatonarchive.org'"/>
    
    <xsl:variable name="sha" as="xs:string">
        <xsl:variable name="jsonXml" select="unparsed-text('https://api.github.com/repos/winnifredeatonarchive/wea_data/commits/master') =>  json-to-xml()"/>
        <xsl:sequence select="$jsonXml/map:map/map:string[@key='sha']/xs:string(.)"/>
    </xsl:variable>
   
    
    <xsl:function name="wea:getFileSize" as="xs:string?">
        <xsl:param name="filename"/>
        
        <xsl:variable name="thisLine" select="for $f in $fileSizeDocLines return if (ends-with($f, $filename)) then $f else ()" as="xs:string?"/>
        <xsl:if test="not(empty($thisLine))">
            <xsl:variable name="size" select="normalize-space(tokenize($thisLine,'\t')[1])"/>
            <xsl:variable name="regex">^\s*([\d\.]+)([A-Z]+)$</xsl:variable>
            <xsl:variable name="integer" select="replace($size,$regex,'$1')"/>
            <xsl:variable name="unit" select="replace($size,$regex,'$2')"/>
            <xsl:value-of select="concat($integer, ' ', replace($unit,'K','k'),'B')"/>
        </xsl:if>

    </xsl:function>
    
    
    <xsl:function name="wea:getImageDimensions" as="xs:integer*">
        <xsl:param name="pngName"/>
            <xsl:variable name="thisLine"
                select="$imageSizeDocLines[(matches(.,concat('^.+/',functx:escape-for-regex($pngName),'.jpg:')))]"
                as="xs:string?"/>
        <xsl:if test="not(empty($thisLine))">
            <xsl:variable name="size" select="analyze-string($thisLine,',\s*(\d+)x(\d+),')"/>
            <xsl:variable name="height" select="$size//*:group[@nr='1']"/>
            <xsl:variable name="width" select="$size//*:group[@nr='2']"/>
            <xsl:sequence select="xs:integer($height)"/>
            <xsl:sequence select="xs:integer($width)"/>
        </xsl:if>
            
    </xsl:function>

    
    
    <xsl:function name="wea:makeTitleSortKey" as="xs:string">
        <xsl:param name="string"/>
        <xsl:variable name="lower" select="lower-case($string)"/>
        <xsl:variable name="first" select="replace($lower,'^(an?|the)\s','') => translate('[](),.''’','')"/>
        <xsl:sequence select="$first"/>
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
    
    <xsl:function name="wea:returnHeadnoteByline" as="element(ab)">
        <xsl:param name="abstract"/>
        <xsl:variable name="root" select="$abstract/ancestor::tei:TEI"/>
        <tei:ab type="headnote_byline">
            <xsl:text>Written by </xsl:text>
            <xsl:for-each select="tokenize($abstract/@resp,'\s+')">
                <xsl:variable name="token" select="."/>
                <xsl:variable name="persName" select="
                    if (starts-with($token,'#')) 
                    then $root/descendant::respStmt[@xml:id=substring-after($token,'#')]/name
                    else $sourceXml//TEI[@xml:id='people']/descendant::person[@xml:id=substring-after($token,'pers:')]/persName/reg"/>
                <xsl:choose>
                    <xsl:when test="$persName/self::name">
                        <xsl:copy-of select="$persName"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <tei:name ref="{$token}"><xsl:sequence select="$persName/node()"/></tei:name>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="not(position() = last())"><xsl:text>, </xsl:text></xsl:if>
            </xsl:for-each>
        </tei:ab>
       
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
    
    <xsl:function name="wea:bornDigital" as="xs:boolean">
        <xsl:param name="doc"/>
        <xsl:sequence select="some $q in $doc//catRef/@target satisfies (contains($q,'BornDigital'))"/>
    </xsl:function>
    
    <xsl:template name="generateTeiPage">
  
        <xsl:param name="outDoc"/>
        <xsl:param name="thisId"/>
        <xsl:param name="title"/>
        <xsl:param name="categories"/>
        <xsl:param name="content"/>
        <xsl:param name="respStmts"/>
        <xsl:message>Generating <xsl:value-of select="$outDoc"/></xsl:message>
        <xsl:result-document href="{$outDoc}" method="xml" indent="no">
            <TEI xml:id="{$thisId}" xmlns="http://www.tei-c.org/ns/1.0">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title><xsl:sequence select="$title"/></title>
                            <xsl:sequence select="$respStmts"/>
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
                    <revisionDesc status="published">
                        <change who="pers:JT1" when="{$today}" status="published">Generated page.</change>
                    </revisionDesc>
                </teiHeader>
                <text>
                  <xsl:copy-of select="$content"/>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
    
    
    <xsl:function name="wea:makeEntityResp" new-each-time="no" as="element(tei:respStmt)*">
        <xsl:param name="resp" as="attribute(resp)"/>
        <xsl:variable name="respTokens" select="tokenize($resp)" as="xs:string*"/>
        <xsl:variable name="respIds"
            select="distinct-values($respTokens!replace(.,'pers:',''))" as="xs:string*"/>
        <xsl:variable name="people"
            select="$srcPersonography//tei:person[@xml:id = $respIds]" as="element(tei:person)*"/>
        
        <xsl:for-each select="$people">
            <respStmt xmlns="http://www.tei-c.org/ns/1.0">
                <resp>Author</resp>
                <name ref="pers:{@xml:id}"><xsl:value-of select="persName/reg"/></name>
            </respStmt>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="wea:makePseudo" new-each-time="no" as="xs:string">
        <xsl:param name="nameEl" as="element(name)"/>
        <xsl:sequence select="string-join($nameEl/descendant::text(),'') => normalize-space() => lower-case() => wea:namecase()"/>
    </xsl:function>
    
    <xsl:function name="wea:capitalize" as="xs:string">
        <xsl:param name="string" as="xs:string"/>
        <xsl:sequence select="concat(upper-case(substring($string,1,1)),substring($string,2))"/>
    </xsl:function>
    
    
    <xsl:function name="wea:namecase">
        <xsl:param name="name"/>
        <xsl:value-of select="for $r in tokenize($name,'\s+') return wea:capitalize($r)" separator=" "/>
    </xsl:function>
    
    
    <!--Function create a sort key from a date; since we have date ranges this is all very complicated.
        
        If a date has a simple when, then we expand it and then convert it to a number:
        <date when="1922"> 
        => 1922-01-01 
        => 19220101
        
        If a date has a range, then we expand both bits, and then turn it into a decimal number with the latest first
        and the earlier second:
        
        <date notBefore="1920" notAfter="1931"/> 
        => [1920-01-01, 1931-01-01]
        => [19220101, 19310101] 
        => 19310101.19220101 
        
        This allows 1917-1922 to sort before 1920-1922
        
        If a date doesn't exist, just return 0
        
       -->
    <xsl:function name="wea:getDateSortKey" as="xs:decimal">
        <xsl:param name="date" as="element(tei:date)?"/>   
        <xsl:variable name="when" select="$date/@when" as="attribute()?"/>
        <xsl:variable name="leftBound" select="($date/@notBefore | $date/@from)[1]" as="attribute()?"/>
        <xsl:variable name="rightBound" select="($date/@notAfter | $date/@to)[1]" as="attribute()?"/>
        
        <xsl:variable name="ints" as="xs:integer+">
            <xsl:choose>
                <xsl:when test="empty($date)">
                    <xsl:sequence select="0"/>
                </xsl:when>
                <xsl:when test="$when">
                    <xsl:sequence select="wea:dateToInt($when)"/>
                </xsl:when>
                <xsl:when test="$leftBound or $rightBound">
                    <xsl:if test="$leftBound">
                        <xsl:sequence select="wea:dateToInt($leftBound)"/>
                    </xsl:if>
                    <xsl:if test="$rightBound">
                        <xsl:sequence select="wea:dateToInt($rightBound)"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="wea:dateToInt($today)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sortKey" 
            select="string-join(reverse($ints),'.') => xs:decimal()"/>
        <xsl:sequence select="$sortKey"/>
    </xsl:function>
    
    <xsl:function name="wea:dateToInt" as="xs:integer">
        <xsl:param name="date" as="xs:string"/>
        <xsl:variable name="expanded" select="wea:expandDate($date)"/>
        <xsl:sequence select="replace(xs:string($expanded),'-','') => xs:integer()"/>
    </xsl:function>
    
    <xsl:function name="wea:formatDate" as="element(tei:date)">
        <xsl:param name="dateEl" as="element(tei:date)"/>
        <tei:date>
            <xsl:sequence select="$dateEl/@*"/>
            <xsl:choose>
                <xsl:when test="$dateEl/@when">
                    <!--Easiest -->
                    <xsl:sequence select="wea:dateString($dateEl/@when)"/>
                </xsl:when>
                <xsl:when test="$dateEl[@notBefore or @notAfter or @from or @to]">
                    <xsl:variable name="left" select="wea:dateString($dateEl/(@notBefore|@from)[1])" as="xs:string?"/>
                    <xsl:variable name="right" select="wea:dateString($dateEl/(@notAfter|@to)[1])" as="xs:string?"/>
                    <xsl:sequence select="string-join(($left, $right),'–')"/>
                </xsl:when>
            </xsl:choose>
        </tei:date>
        
    </xsl:function>
    
    <xsl:function name="wea:dateString" as="xs:string?">
        <xsl:param name="date" as="xs:string?"/>
        <xsl:if test="not(empty($date))">
            <xsl:variable name="tokens" select="tokenize($date,'-')"/>
            <xsl:variable name="expandedDate" select="wea:expandDate($date)" as="xs:date"/>
            <xsl:choose>
                <xsl:when test="count($tokens) = 3">
                    <xsl:sequence select="format-date($expandedDate, '[MNn] [D01], [Y0001]')"/>
                </xsl:when>
                <xsl:when test="count($tokens) = 2">
                    <xsl:sequence select="format-date($expandedDate, '[MNn] [Y0001]')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="format-date($expandedDate, '[Y0001]')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:function>
    
    
    <xsl:function name="wea:expandDate" as="xs:date">
        <xsl:param name="date" as="xs:string"/>
        <xsl:variable name="tokens" select="tokenize($date,'-')"/>
        <xsl:choose>
            <xsl:when test="count($tokens) = 3">
                <xsl:sequence select="xs:date($date)"/>
            </xsl:when>
            <xsl:when test="count($tokens) = 2">
                <xsl:sequence select="xs:date($date || '-01')"/>
            </xsl:when>
            <xsl:when test="count($tokens) = 1">
                <xsl:sequence select="xs:date($date || '-01-01')"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    
</xsl:stylesheet>