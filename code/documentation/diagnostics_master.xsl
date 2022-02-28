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
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    
    <!--This diagnostics is slightly different from the implementations described in
        Holmes and Takeda 2019; instead, these are created within the ODD itself, generated only
        at build time as part of the documentation.-->
    
    <!--The directory that contains all of the old versions-->
    <xsl:param name="oldDir" as="xs:string"/>
   
    <!--All of the URIs-->
    <xsl:variable name="oldDocsURIs" select="uri-collection($oldDir || '?select=*.xml;recurse=yes')"/>
     
    <xsl:variable name="dataDocs" select="collection('../../data/?select=*.xml;recurse=yes')"/>
    
    <xsl:variable name="redirectsDoc" select="$dataDocs//TEI[@xml:id='redirects']" as="element(TEI)"/>
    
    <xsl:variable name="docsByTag" as="map(xs:string, document-node()+)">
        <xsl:map>
            <!--Get by their directory name-->
            <xsl:for-each-group select="$oldDocsURIs" group-by="tokenize(.,'/')[last() - 2]">
                
                <xsl:map-entry 
                    key="current-grouping-key()"
                    select="current-group() ! document(.)"/>
            </xsl:for-each-group>
            <xsl:map-entry key="normalize-space(unparsed-text('../../VERSION'))" select="$dataDocs[matches(document-uri(.),'/texts/')]"/>
        </xsl:map>
    </xsl:variable>
    
    <xsl:variable name="versionsMap" as="map(*)">
        <xsl:map>
            <xsl:for-each select="map:keys($docsByTag)">
                <xsl:map-entry key=".">
                    <xsl:map>
                        <xsl:for-each select="$docsByTag(.)">
                            <xsl:map-entry key="string(//TEI/@xml:id)">
                                <xsl:map>
                                    <xsl:map-entry key="'hasTranscription'" select="matches(string-join(//body),'\S')"/>
                                    <xsl:map-entry key="'hasHeadnote'" select="matches(string-join(//abstract),'\S')"/>
                                </xsl:map>
                            </xsl:map-entry>
                        </xsl:for-each>
                    </xsl:map>
                </xsl:map-entry>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <xsl:variable name="sortedTags" select="map:keys($docsByTag) => sort() => reverse()" as="xs:string+"/>
    
    <xsl:variable name="ids" select="$dataDocs//*/@xml:id"/>
    
    <xsl:template match="divGen[@xml:id='versions_content']">
        <xsl:for-each select="$sortedTags">
            <xsl:call-template name="createVersions"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="createVersions">
        <xsl:variable name="currData" select="$versionsMap(.)" as="map(*)"/>
        <div xml:id="version_{.}">
            <head><xsl:value-of select="."/></head>
            <table>
                <row>
                    <cell role="label">Total Documents</cell>
                    <cell><xsl:value-of select="map:size($currData)"/></cell>
                    <cell/>
                </row>
                <xsl:if test="not(position() = count($sortedTags))">
                    <xsl:call-template name="compareVersions"/>
                </xsl:if>
            </table>
        </div>
    </xsl:template>
    
    <xsl:template name="compareVersions">
        <xsl:variable name="tag" as="xs:string" select="."/>
        <xsl:variable name="pos" select="index-of($sortedTags, .)" as="xs:integer"/>
        <xsl:variable name="currData" select="$versionsMap(.)" as="map(*)"/>
        <xsl:variable name="prev" select="$sortedTags[$pos + 1]" as="xs:string"/>
        <xsl:variable name="prevData" select="$versionsMap($prev)" as="map(*)?"/>
        <xsl:variable name="docIds" select="map:keys($currData)" as="xs:string+"/>
        <xsl:variable name="newDocs"
            select="for $id in $docIds return if (map:contains($prevData, $id)) then () else $id"
            as="xs:string*"/>
        
        <xsl:variable name="deletedDocs" select="for $id in map:keys($prevData) return if (map:contains($currData, $id)) then () else $id"/>
        
        <xsl:variable name="newTranscriptions" as="xs:string*" 
            select="for $id in $docIds return 
                if ($currData($id)?hasTranscription and (not(map:contains($prevData, $id)) or not($prevData($id)?hasTranscription))) 
                then $id else ()"/>
        
        <xsl:variable name="newHeadnotes" as="xs:string*" 
            select="for $id in $docIds return 
            if ($currData($id)?hasHeadnote and (not(map:contains($prevData, $id)) or not($prevData($id)?hasHeadnote))) 
            then $id else ()"/>
        
        <row>
            <cell role="label">Documents Added</cell>
            <cell>
                <xsl:value-of select="count($newDocs)"/>
            </cell>
            <cell>
                <xsl:where-populated>
                    <list>
                        <xsl:for-each select="$newDocs">
                            <item><xsl:sequence select="wea:docTitleLink(., $docsByTag($tag))"/></item>
                        </xsl:for-each>
                    </list>
                </xsl:where-populated>
            </cell>
        </row>
        <row>
            <cell role="label">Transcriptions Added</cell>
            <cell>
                <xsl:value-of select="count($newTranscriptions)"/>
            </cell>
            <cell>
                <xsl:where-populated>
                    <list>
                        <xsl:for-each select="$newTranscriptions">
                            <item><xsl:sequence select="wea:docTitleLink(., $docsByTag($tag))"/></item>
                        </xsl:for-each>
                    </list>
                </xsl:where-populated>
            </cell>
        </row>
        <row>
            <cell role="label">Headnotes Added</cell>
            <cell>
                <xsl:value-of select="count($newHeadnotes)"/>
            </cell>
            <cell>
                <xsl:where-populated>
                    <list>
                        <xsl:for-each select="$newHeadnotes">
                            <item><xsl:sequence select="wea:docTitleLink(., $docsByTag($tag))"/></item>
                        </xsl:for-each>
                    </list>
                </xsl:where-populated>
            </cell>
        </row>
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='diagnostics_content']">
        <xsl:call-template name="createDiagnostics"/>
    </xsl:template>
    
    
    
    
    <xsl:template name="createDiagnostics">
        <div xml:id="diagnostics_content">
            <head>WEA Site Diagnostics</head>
            <div>
                <head>Checks</head>
                <xsl:call-template name="createChecks"/>
            </div>
        </div>
    </xsl:template>

    
    
    <xsl:template name="createChecks">

<!--        <xsl:call-template name="badPtrs"/>-->
        <xsl:call-template name="documentsAwaitingMC"/>
        <xsl:call-template name="facsWithoutNotes"/>
        
        <xsl:call-template name="documentsWithoutFacs"/>
        <xsl:call-template name="documentsWithoutGenre"/>
        <xsl:call-template name="documentsWithoutExhibit"/>
        <xsl:call-template name="duplicateIds"/>
        <xsl:call-template name="badRedirects"/>
        <xsl:call-template name="japaneseWordsWithoutTerm"/>


    </xsl:template>
    
    <xsl:template name="badRedirects">
        <!--Get the most recent-->
        <xsl:variable name="deletedDocs" select="for $id in map:keys($versionsMap($sortedTags[2])) return if (map:contains($versionsMap($sortedTags[1]), $id)) then () else $id" as="xs:string*"/>
        <xsl:variable name="redirectedDocs" select="$redirectsDoc//link/@target ! replace(tokenize(.)[1],'^.+:','')" as="xs:string+"/>
        <xsl:variable name="notRedirected" select="$deletedDocs[not(. = $redirectedDocs)]" as="xs:string*"/>
        <xsl:if test="exists($notRedirected)">
            <xsl:message terminate="yes">ERROR: Documents <xsl:value-of select="string-join($notRedirected, ', ')"/> have been
            deleted but not redirected.</xsl:message>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="facsWithoutNotes">
        <xsl:variable name="errors" select="$dataDocs//TEI[not(descendant::notesStmt/note)][descendant::text[@facs]]" as="element(TEI)*"/>
        <div type="diagnostic">
            <head n="{count($errors)}">Documents with facsimiles without a note</head>
            <p>All documents with facsimiles should have a note describing the open-access source of the facsimile.</p>
            <xsl:choose>
                <xsl:when test="not(empty($errors))">
                    <table>
                        <row role="label">
                            <cell>ID</cell>
                            <cell>Document</cell>
                        </row>
                        <xsl:for-each select="$errors">
                            <xsl:sort select="@xml:id"/>
                            <row>
                                <cell><xsl:value-of select="@xml:id"/></cell>
                                <cell>    <xsl:sequence select="wea:docTitleLink(@xml:id)"/></cell>
                            </row>
                        </xsl:for-each>
                    </table>
                </xsl:when>
            </xsl:choose>
        </div>
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
                                <cell>    <xsl:sequence select="wea:docTitleLink(@xml:id)"/></cell>
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
                                <cell>    <xsl:sequence select="wea:docTitleLink(@xml:id)"/></cell>
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
                                <cell><xsl:sequence select="wea:docTitleLink(@xml:id)"/></cell>
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
                                <cell>    <xsl:sequence select="wea:docTitleLink(@xml:id)"/></cell>
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
    
    <xsl:template name="japaneseWordsWithoutTerm">
        <xsl:variable name="errors" select="$dataDocs//foreign[@xml:lang='ja'][not(ancestor::term[@ref])]" as="element(foreign)*"/>

            <div type="diagnostic">
                <head n="{count($errors)}">Japanese terms without a glossary entry</head>
                <p>All Japanese terms (i.e. terms tagged with <gi>foreign</gi>/<att>xml:lang</att>=<val>ja</val>) should be associated with a 
                    term in the glossary.
                </p>
                <p>Note that this diagnostic is meant to evaluate the list of terms we will need for the glossary IN FUTURE. We do not currently have the mechanism set up to tag these terms.</p>
                <xsl:choose>
                    <xsl:when test="not(empty($errors))">
                        <table>
                            <row role="label">
                                <cell role="label">
                                    Term
                                </cell>
                                <cell role="label">
                                    Documents
                                </cell>
                            </row>
                            <xsl:for-each-group select="$errors" group-by="text()">
                                <xsl:sort select="lower-case(current-grouping-key())"/>
                                <row>
                                    <cell><xsl:value-of select="current-grouping-key()"/></cell>
                                    <cell>
                                        <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                                            <xsl:sort/>
                                            <xsl:variable name="doc" select="current-group()[1]/ancestor::TEI"/>
                                            <xsl:variable name="currPos" select="position()"/>
                                            <xsl:sequence select="wea:docTitleLink(current-grouping-key())"/>
                                            <xsl:if test="$currPos ne last()"> | </xsl:if>
                                            
                                        </xsl:for-each-group>
                                    </cell>
                                </row>
                            </xsl:for-each-group>
                        </table>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>None found! </p>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
    </xsl:template>
    
    <xsl:function name="wea:docTitleLink" as="element(ref)" new-each-time="no">
        <xsl:param name="id" as="xs:string"/>
        <xsl:sequence select="wea:docTitleLink($id, $dataDocs)"/>

    </xsl:function>
    
    <xsl:function name="wea:docTitleLink" as="element(ref)" new-each-time="no">
        <xsl:param name="id" as="xs:string"/>
        <xsl:param name="docs" as="document-node()+"/>
        <ref target="../{$id}.html">
            <xsl:value-of select="$docs//TEI[@xml:id=$id]/teiHeader/fileDesc/titleStmt/title[1]" />
        </ref>
    </xsl:function>
    
    
   
    
    
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    
</xsl:stylesheet>