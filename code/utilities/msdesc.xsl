<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://winnifredeatonarchive.org/ns"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 10, 2023</xd:p>
            <xd:p><xd:b>Author:</xd:b> takeda</xd:p>
            <xd:p>Stylesheet to migrate document to use msDesc rather the source bibl.</xd:p>
        </xd:desc>
    </xd:doc>
    

    <xsl:param name="dest" select="'out/'"/>
    <xsl:output method="xml" indent="yes" />
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:mode name="pass2" on-no-match="shallow-copy"/>
    
    <xsl:variable name="today" select="current-date() => format-date('[Y0001]-[M01]-[D01]')" as="xs:string"/>
    <xsl:variable name="texts" select="collection('../../data/texts?select=*.xml')" as="document-node()+"/>
    <xsl:variable name="biblio" select="document('../../data/bibliography.xml')" as="document-node()"/>
    
    
    
    <!--
        map{
            'bibl1': <bibl xml:id="bibl1">...</bibl>
        
        } -->
    <xsl:variable name="biblMap" as="map(xs:string, element(bibl))">
        <xsl:map>
            <xsl:for-each select="$biblio//div[@xml:id='bibliography_we']/listBibl/bibl">
                <xsl:map-entry key="string(@xml:id)" select="."/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <!--map{
            'ChineseJapaneseCookbook': 'bibl1'
        } -->
    <xsl:variable name="textToBiblMap" as="map(xs:string, xs:string)">
        <xsl:map>
            <xsl:for-each select="$texts">
                <xsl:map-entry key="string(//TEI/@xml:id)" 
                    select="replace(//sourceDesc/bibl[@copyOf]/@copyOf,':','')"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    
    
    <!--Inverted map from above:
        map{
            'bibl1': 'ChineseJapaneseCookbook'
        } -->
        
    <xsl:variable name="biblToTextMap"
        as="map(xs:string, xs:string)"
        select="map:merge(map:keys($textToBiblMap) ! map{$textToBiblMap(.): .})"/>
    
    <xsl:template name="go">
        <xsl:apply-templates select="$biblio"/>
        <xsl:apply-templates select="$texts"/>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:result-document href="{wea:getDestHref(.)}" suppress-indentation="text bibl p ref title q desc">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:apply-templates/>
        </xsl:result-document>
    </xsl:template>
    
    
    
    <!--Remove relatedItems-->
    <xsl:template match="notesStmt"/>
    
    <xsl:template match="sourceDesc[bibl[@copyOf]]">
        <xsl:variable name="biblId" select="replace(./bibl/@copyOf,':','')" as="xs:string"/>
        <xsl:variable name="srcBibl" select="$biblMap($biblId)" as="element(bibl)"/>
        <xsl:copy>
            <msDesc>
                <xsl:where-populated>
                    <msIdentifier>
                        <xsl:for-each select="$srcBibl/distributor">
                            <repository>
                                <xsl:apply-templates select="@ref|node()"/>
                            </repository>
                        </xsl:for-each>
                        <xsl:sequence select="$srcBibl/idno"/>
                    </msIdentifier>
                </xsl:where-populated>
                <msContents>
                    <msItem>
                        <bibl>
                            <xsl:apply-templates select="$srcBibl/(@*|node())"/>
                        </bibl>
                    </msItem>
                </msContents>
                <xsl:call-template name="makeAdditional"/>
            </msDesc>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="makeAdditional">
        <xsl:variable name="notesStmt" select="ancestor::teiHeader/fileDesc/notesStmt" as="element(notesStmt)?"/>
        <additional>
            <adminInfo>
                <availability>
                    <xsl:sequence>
                        <xsl:apply-templates select="$notesStmt/note[matches(string(.),'\S')]"/>
                        <xsl:on-empty>
                            <p><xsl:comment>[Add information about the holding library (i.e. the source of the facsimile) here]</xsl:comment></p>
                        </xsl:on-empty>
                    </xsl:sequence>
                </availability>
            </adminInfo>
            <surrogates>
                <xsl:sequence>
                    <xsl:call-template name="addRelatedItems"/>
                    <xsl:on-empty>
                        <xsl:call-template name="createComment">
                            <xsl:with-param name="comment" select="'Add other editions of this text using a bibl element
                                with a target pointing to its bibl'"/>
                            <xsl:with-param name="example" as="element()+">
                                 <bibl target="bibl:ABCD1"/>
                                 <bibl><distributor></distributor>, <idno></idno></bibl>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:on-empty>
                </xsl:sequence>
            </surrogates>
        </additional>
    </xsl:template>
    
    <xsl:template name="addRelatedItems">
        <xsl:variable name="doc" select="ancestor::TEI"/>
        <xsl:choose>
            <xsl:when test="$doc/descendant::change[idno[@type='weda']]">
                <bibl type="bibliography" target="bibl:COLE3"/>
                <xsl:variable name="uvaNum" select="string($doc/descendant::change/idno[@type='weda'])"/>
                <bibl type="edition" target="weda:{$uvaNum}"/>
            </xsl:when>
            <xsl:when test="$doc/descendant::notesStmt/relatedItem[matches(@target,'bibl:MOSE')]">
                <bibl type="bibliography" target="bibl:COLE3"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        <xsl:if test="$doc//relatedItem[bibl]">
            <xsl:sequence select="$doc//relatedItem/bibl"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="createComment">
        <xsl:param name="comment"/>
        <xsl:param name="example"/>
        <comment><xsl:sequence select="normalize-space($comment)"/></comment>
        <comment>
            <xsl:sequence select="$example"/>
        </comment>
    </xsl:template>
    
    <xsl:template match="notesStmt/note">
        <xsl:choose>
            <xsl:when test="p">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="relatedItem[@type='bibliography']">
        <bibl target="{@target}"/>
    </xsl:template>
    
    <xsl:template match="relatedItem[@type='edition']">
        <bibl target="{@target}"/>
    </xsl:template>
    
    <xsl:template match="relatedItem[bibl]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="revisionDesc">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:call-template name="change"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    

    <xsl:template match="div[@xml:id = 'bibliography_we']">
        <xsl:call-template name="makeRelationship"/>        
    </xsl:template>
    
    <xsl:template match="listBibl[ancestor::div[@xml:id = 'bibliography_we']]">
        <linkGrp type="work">
            <xsl:sequence select="@xml:id"/>
            <desc>
                <xsl:apply-templates select="head/node()"/>
            </desc>
            <xsl:apply-templates select="bibl"/>
        </linkGrp>
    </xsl:template>
    
    <xsl:template match="bibl[@xml:id]">
        <ptr target="doc:{$biblToTextMap(string(@xml:id))}"/>
    </xsl:template>

    
    <xsl:template match="div[ancestor::TEI/@xml:id ='bibliography'][not(@xml:id = 'bibliography_we')]">
        <xsl:sequence select="."/>
    </xsl:template>
    
    <xsl:template name="change">
        <xsl:param name="status" select="@status" as="xs:string?"/>
        <xsl:param name="message">Added citation from bibliography.xml to <gi>sourceDesc</gi> using utilities/msdesc.xsl.</xsl:param>
        <change who="pers:JT1" when="{$today}" status="{($status,'published')[1]}"><xsl:sequence select="$message"/></change>
    </xsl:template>
    
    <xsl:template name="makeRelationship">
        <xsl:result-document href="{$dest}/relationships.xml" suppress-indentation="q desc">
            <xsl:message select="'Creating ' || current-output-uri()"/>
            <xsl:sequence select="root(.)/processing-instruction('xml-model')"/>
            <TEI xml:id="relationships">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Relationships and Linked Data</title>
                        </titleStmt>
                        <publicationStmt>
                            <p>Publication Information</p>
                        </publicationStmt>
                        <sourceDesc>
                            <p>Born digital.</p>
                        </sourceDesc>
                    </fileDesc>
                    <profileDesc>
                        <textClass>
                            <catRef target="wdt:docBornDigital" scheme="wdt:docType"/>
                        </textClass>
                    </profileDesc>
                    <revisionDesc status="published">
                        <xsl:call-template name="change">
                            <xsl:with-param name="message"
                                select="'Generated new file from bibliography.xml using utilities/msdesc.xsl.'"/>
                        </xsl:call-template>
                    </revisionDesc>
                </teiHeader>
                <text>
                    <body>
                         <div xml:id="{@xml:id}">
                             <xsl:apply-templates select="node()"/>
                         </div>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>       
    </xsl:template>
    
    
    <xsl:function name="wea:getDestHref">
        <xsl:param name="el"/>
        
        <xsl:variable name="uri" select="base-uri(root($el))"/>
        <xsl:sequence select="replace($uri,'^.+/wea_data/data', $dest)"/>
        
    </xsl:function>
    
    
    
    
    
    
    
    
</xsl:stylesheet>