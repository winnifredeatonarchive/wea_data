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
                        <xsl:apply-templates select="$srcBibl"/>
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
                <xsl:sequence>
                    <xsl:where-populated>
                        <recordHist>
                            <xsl:apply-templates select="$notesStmt/relatedItem[@type='bibliography']"/>
                        </recordHist>
                    </xsl:where-populated>
                    <xsl:on-empty>
                        <xsl:call-template name="createComment">
                            <xsl:with-param name="comment" select="'Add information about previous citations or bibliographies
                                using the source element'"/>
                            <xsl:with-param name="example" as="element()">
                                <recordHist>
                                    <source target="bibl:ABCD1"/>
                                </recordHist>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:on-empty>
                </xsl:sequence>
                <availability>
                    <xsl:sequence>
                        <xsl:apply-templates select="$notesStmt/note"/>
                        <xsl:on-empty>
                            <p><!--Add information about provenance of facsimile here.--></p>
                        </xsl:on-empty>
                    </xsl:sequence>
                </availability>
            </adminInfo>
            <xsl:sequence>
                <xsl:where-populated>
                    <listBibl>
                        <xsl:apply-templates select="$notesStmt/relatedItem[@type='edition']"/>
                    </listBibl>
                </xsl:where-populated>
                <xsl:on-empty>
                    <xsl:call-template name="createComment">
                        <xsl:with-param name="comment" select="'Add other editions of this text using a bibl element
                            with a target pointing to its bibl'"/>
                        <xsl:with-param name="example" as="element()">
                            <listBibl>
                                <bibl target="bibl:ABCD1"/>
                            </listBibl>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:on-empty>
            </xsl:sequence>
        </additional>
    </xsl:template>
    
    <xsl:template name="createComment">
        <xsl:param name="comment"/>
        <xsl:param name="example"/>
        <xsl:comment select="normalize-space($comment)"/>
        <xsl:comment select="serialize($example)"/>
        
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
        <source target="{@target}"/>
    </xsl:template>
    
    <xsl:template match="relatedItem[@type='edition']">
        <bibl target="{@target}"/>
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
        <relation name="work">
            <xsl:sequence select="@xml:id"/>
            <xsl:attribute name="mutual"
                select="child::bibl ! ('doc:' || $biblToTextMap(string(./@xml:id)))"
                separator=" "/>
            <desc>
                <xsl:apply-templates select="head/node()"/>
            </desc>
        </relation>
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
                            <title>Bibliography</title>
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
                        <listRelation>
                            <xsl:apply-templates/>
                        </listRelation>
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