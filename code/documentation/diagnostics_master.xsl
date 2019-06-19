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
    
    
    <!--This diagnostics is slightly different from the implementations described in
        Holmes and Takeda 2019; instead, these are created within the ODD itself, generated only
        at build time as part of the documentation.-->
    
    <xsl:variable name="dataDocs" select="collection('../../data/?select=*.xml;recurse=yes')"/>
    <xsl:variable name="ids" select="$dataDocs//*/@xml:id"/>
    
    
    <xsl:template match="divGen[@xml:id='diagnostics_content']">
        <xsl:call-template name="createDiagnostics"/>
    </xsl:template>
    
    
    <xsl:template name="createDiagnostics">
        <div xml:id="diagnostics_content">
            <head>WEA Site Diagnostics</head>
            <div>
                <head>Statistics</head>
                <xsl:call-template name="createStatsTable"/>
            </div>
            <div>
                <head>Checks</head>
                <xsl:call-template name="createChecks"/>
            </div>
        </div>
    </xsl:template>
    
    
    <xsl:template name="createStatsTable">
        <table>
            <row>
                <cell>TEI Documents</cell>
                <cell><xsl:value-of select="count($dataDocs//TEI)"/></cell>
            </row>
        </table>
    </xsl:template>
    
    <xsl:template name="createChecks">
        <xsl:call-template name="duplicateIds"/>
<!--        <xsl:call-template name="badPtrs"/>-->
        <xsl:call-template name="documentsAwaitingMC"/>
        <xsl:call-template name="documentsWithoutFacs"/>
        <xsl:call-template name="documentsWithoutGenre"/>
        <xsl:call-template name="documentsWithoutExhibit"/>
    </xsl:template>
    
    
    <xsl:template name="duplicateIds">
        <xsl:variable name="errors" as="element(list)*">
            <xsl:for-each select="distinct-values($ids)">
                <xsl:variable name="thisId" select="."/>
                <xsl:if test="count($ids[. = $thisId]) gt 1">
                    <xsl:variable name="dups"
                        select="
                        for $d in ($dataDocs/descendant::tei:*[@xml:id = $thisId])
                        return
                        $d/ancestor-or-self::TEI/@xml:id"/>
                    <list>
                        <item><xsl:value-of select="$thisId"/>
                        <list>
                            <xsl:for-each select="$dups">
                                <item><xsl:value-of select="."/> (<xsl:value-of select="document-uri(root(.))"/>)</item>
                            </xsl:for-each>
                        </list>
                        </item>
                    </list>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <div type="diagnostic">
            <head n="{count($errors)}">Duplicate <att>xml:id</att>s</head>
            <p>All <att>xml:id</att>s in the project must be unique.</p>
            <xsl:choose>
                <xsl:when test="not(empty($errors))">
                    <table>
                        <row role="label">
                            <cell>Id</cell>
                            <cell>Documents</cell>
                        </row>
                        <xsl:for-each select="$errors">
                            <xsl:sort select="normalize-space(*:item[1]/text())"/>
                            <row>
                                <cell><xsl:value-of select="normalize-space(*:item[1]/text())"/></cell>
                                <cell><xsl:copy-of select="*:item[1]/*:list[1]"/></cell>
                            </row>
                        </xsl:for-each>
                        
                    </table>
                    
                </xsl:when>
                <xsl:otherwise>
                    <p>None found!</p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    

    
    <xsl:template name="documentsAwaitingMC">
        <xsl:variable name="waitingDocs" select="$dataDocs//TEI[descendant::revisionDesc/@status='readyForProof']"/>
        <div type="diagnostic">
            <head n="{count($waitingDocs)}">Documents Ready for Proofing</head>
            <p>Documents with the <att>status</att> value of <val>readyForProof</val> need to be reviewed by the Project Director before they can moved to published. If the Project Director has proofed these documents (i.e. they have been checked off as <q>Done</q> in the Google Drive spreadsheet), then the status should be changed to <val>published</val> with a corresponding new <gi>change</gi> element with a <att>status</att> value of <val>published</val> that gives who changed it and the date that it was published (using the <att>who</att> and <att>when</att> attributes, respectively).</p>
            <xsl:choose>
                <xsl:when test="not(empty($waitingDocs))">
                    <table>
                        <row role="label">
                            <cell role="label">
                                Document ID
                            </cell>
                            <cell role="label">
                                Document Name
                            </cell>
                        </row>
                        <xsl:for-each select="$waitingDocs">
                            <xsl:sort select="@xml:id"/>
                            <row>
                                <cell><xsl:value-of select="@xml:id"/></cell>
                                <cell><ref target="https://jenkins.hcmc.uvic.ca/job/WEA/lastSuccessfulBuild/artifact/products/site/{@xml:id}.html"><xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[1]"/></ref></cell>
                            </row>
                        </xsl:for-each>
                    </table>
                </xsl:when>
            </xsl:choose>
        </div>
        
    </xsl:template>
    
    
    <xsl:template name="documentsWithoutFacs">
        <xsl:variable name="errors" select="$dataDocs//TEI[descendant::catRef[contains(@target,'Primary')]][not(descendant::text/@facs)]"/>
        <div type="diagnostic">
            <head n="{count($errors)}">Documents without facsimiles</head>
            <p>All primary source documents should be associated with a facsimile. These are the ones currently
            missing facsimiles.</p>
         
            <xsl:choose>
                <xsl:when test="not(empty($errors))">
                    <table>
                        <row role="label">
                            <cell role="label">
                                Document ID
                            </cell>
                            <cell role="label">
                                Document Name
                            </cell>
                        </row>
                        <xsl:for-each select="$errors">
                            <xsl:sort select="@xml:id"/>
                            <row>
                                <cell><xsl:value-of select="@xml:id"/></cell>
                                <cell><ref target="https://jenkins.hcmc.uvic.ca/job/WEA/lastSuccessfulBuild/artifact/products/site/{@xml:id}.html"><xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[1]"/></ref></cell>
                            </row>
                        </xsl:for-each>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p>None found! </p>
                </xsl:otherwise>
            </xsl:choose>
           
        </div>
    </xsl:template>
    
    <xsl:template name="documentsWithoutGenre">
        <xsl:variable name="errors" select="$dataDocs//TEI[descendant::catRef[contains(@target,'Primary')]][not(descendant::catRef[@scheme='wdt:genre'])]"/>
        <div type="diagnostic">
            <head n="{count($errors)}">Documents without genre <gi>catRef</gi></head>
            <p>All primary source documents should have a <gi>catRef</gi> element with a genre:
                <egXML xmlns="http://www.tei-c.org/ns/Examples">
                    <catRef scheme="wdt:genre" target="wdt:genreShortStory"/>
                </egXML>
            </p>
            
            <xsl:choose>
                <xsl:when test="not(empty($errors))">
                    <table>
                        <row role="label">
                            <cell role="label">
                                Document ID
                            </cell>
                            <cell role="label">
                                Document Name
                            </cell>
                        </row>
                        <xsl:for-each select="$errors">
                            <xsl:sort select="@xml:id"/>
                            <row>
                                <cell><xsl:value-of select="@xml:id"/></cell>
                                <cell><ref target="https://jenkins.hcmc.uvic.ca/job/WEA/lastSuccessfulBuild/artifact/products/site/{@xml:id}.html"><xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[1]"/></ref></cell>
                            </row>
                        </xsl:for-each>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p>None found! </p>
                </xsl:otherwise>
            </xsl:choose>
            
        </div>
    </xsl:template>
    
    <xsl:template name="documentsWithoutExhibit">
        <xsl:variable name="errors" select="$dataDocs//TEI[descendant::catRef[contains(@target,'Primary')]][not(descendant::catRef[@scheme='wdt:exhibit'])]"/>
        <div type="diagnostic">
            <head n="{count($errors)}">Documents without exhibit <gi>catRef</gi></head>
            <p>All primary source documents should have a <gi>catRef</gi> element with an exhibit:
                <egXML xmlns="http://www.tei-c.org/ns/Examples">
                    <catRef scheme="wdt:exhibit" target="wdt:EarlyExperiment"/>
                </egXML>
            </p>
            
            <xsl:choose>
                <xsl:when test="not(empty($errors))">
                    <table>
                        <row role="label">
                            <cell role="label">
                                Document ID
                            </cell>
                            <cell role="label">
                                Document Name
                            </cell>
                        </row>
                        <xsl:for-each select="$errors">
                            <xsl:sort select="@xml:id"/>
                            <row>
                                <cell><xsl:value-of select="@xml:id"/></cell>
                                <cell><ref target="https://jenkins.hcmc.uvic.ca/job/WEA/lastSuccessfulBuild/artifact/products/site/{@xml:id}.html"><xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[1]"/></ref></cell>
                            </row>
                        </xsl:for-each>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p>None found! </p>
                </xsl:otherwise>
            </xsl:choose>
            
        </div>
    </xsl:template>
    
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    
</xsl:stylesheet>