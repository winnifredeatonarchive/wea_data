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
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    
    <!--This diagnostics is slightly different from the implementations described in
        Holmes and Takeda 2019; instead, these are created within the ODD itself, generated only
        at build time as part of the documentation.-->
    
    <!--The directory that contains all of the old versions-->
    <xsl:param name="oldDir" as="xs:string"/>
    <xsl:param name="outDir" as="xs:string"/>
   
    <!--All of the URIs-->
    <xsl:variable name="oldDocsURIs" select="uri-collection($oldDir || '?select=*.xml;recurse=yes')"/>
     
    <xsl:variable name="dataDocs" select="collection('../../data/?select=*.xml;recurse=yes')"/>
    
    <xsl:variable name="taxonomyDoc" select="$dataDocs//TEI[@xml:id = 'taxonomies']" as="element(TEI)"/>
    
    <xsl:variable name="redirectsDoc" select="$dataDocs//TEI[@xml:id='redirects']" as="element(TEI)"/>
        
    <xsl:variable name="docsByTag" as="map(xs:string, document-node()+)">
        <xsl:map>
            <!--Group these by tag (which we can derive from the directory) -->
            <xsl:for-each-group select="$oldDocsURIs" group-by="tokenize(substring-before(.,'/data/texts/'),'/')[last()]">
                
                <xsl:map-entry 
                    key="current-grouping-key()"
                    select="current-group() ! document(.)"/>
            </xsl:for-each-group>
            <xsl:map-entry key="normalize-space(unparsed-text('../../VERSION'))"
                select="$dataDocs[matches(document-uri(.),'/texts/')]"/>
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
                                    <xsl:map-entry key="'hasTranscription'" 
                                        select="matches(string-join(//body),'\S') and //revisionDesc/@status  = 'published'"/>
                                    <xsl:map-entry key="'wc'" select="wea:getWordCount(//text)"/>
                                    <xsl:map-entry key="'hasHeadnote'" select="matches(string-join(//abstract),'\S')"/>
                                    <xsl:map-entry key="'hasFacsimile'" select="exists(//text/@facs)"/>
                                    <xsl:map-entry key="'exhibit'" 
                                        select="replace(descendant::catRef[@scheme='wdt:exhibit']/@target,'wdt:','')"/>
                                    <xsl:map-entry key="'doctype'" select="string-join(descendant::catRef[@scheme='wdt:docType'] ! replace(@target,'wdt:',''),'; ')"/>
                                    <xsl:map-entry key="'genre'" select="array{descendant::catRef[@scheme='wdt:genre']/@target ! substring-after(.,'wdt:')}"/>
                                    
                                </xsl:map>
                            </xsl:map-entry>
                        </xsl:for-each>
                    </xsl:map>
                </xsl:map-entry>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <xsl:variable name="sortedTags" select="map:keys($docsByTag) => sort() => reverse()" as="xs:string+"/>
    
    <xsl:variable name="idMap" as="map(xs:string, xs:string+)?">
        <xsl:map>
            <xsl:for-each-group select="$dataDocs//*[@xml:id]/@xml:id" group-by="string(.)">
                <xsl:map-entry key="current-grouping-key()">
                    <xsl:for-each-group select="current-group()" group-by="ancestor-or-self::TEI/@xml:id">
                        <xsl:sequence select="string(current-grouping-key())"/>
                    </xsl:for-each-group>
                </xsl:map-entry>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:variable>
    
    
    <xsl:template match="divGen[@xml:id='versions_content']">
        <xsl:message>Generating version stats...</xsl:message>
        <xsl:call-template name="createJSONStats"/>
        <xsl:for-each select="$sortedTags">
            <xsl:call-template name="createVersions"/>
        </xsl:for-each>

    </xsl:template>
    
    <xsl:template name="createJSONStats">
        <xsl:result-document href="{$outDir}/json/versions.json" method="json">
            <xsl:sequence select="$versionsMap"/>
        </xsl:result-document>
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
        <xsl:message>Comparing <xsl:value-of select="$tag"/> against <xsl:value-of select="$prev"/>...</xsl:message>
        
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
        
        <xsl:variable name="newFacsimiles" as="xs:string*"
            select="for $id in $docIds return
            if ($currData($id)?hasFacsimile and (not(map:contains($prevData, $id)) or not($prevData($id)?hasFacsimile)))
            then $id else ()"/>
        
        <row>
            <cell role="label">Documents Added</cell>
            <cell>
                <xsl:value-of select="count($newDocs)"/>
            </cell>
            <cell>
                <xsl:call-template name="createDocListForVersions">
                    <xsl:with-param name="ids" select="$newDocs"/>
                    <xsl:with-param name="collection" select="$docsByTag($tag)"/>
                    <xsl:with-param name="currData" select="$currData"/>
                </xsl:call-template>
            </cell>
        </row>
        <row>
            <cell role="label">Transcriptions Added</cell>
            <cell>
                <xsl:value-of select="count($newTranscriptions)"/>
            </cell>
            <cell>
                <xsl:call-template name="createDocListForVersions">
                    <xsl:with-param name="ids" select="$newTranscriptions"/>
                    <xsl:with-param name="collection" select="$docsByTag($tag)"/>
                    <xsl:with-param name="currData" select="$currData"/>
                </xsl:call-template>
            </cell>
        </row>
        <row>
            <cell role="label">Headnotes Added</cell>
            <cell>
                <xsl:value-of select="count($newHeadnotes)"/>
            </cell>
            <cell>
                <xsl:call-template name="createDocListForVersions">
                    <xsl:with-param name="ids" select="$newHeadnotes"/>
                    <xsl:with-param name="collection" select="$docsByTag($tag)"/>
                    <xsl:with-param name="currData" select="$currData"/>
                </xsl:call-template>
            </cell>
        </row>
        <row>
            <cell role="label">Facsimiles Added</cell>
            <cell>
                <xsl:value-of select="count($newFacsimiles)"/>
            </cell>
            <cell>
                <xsl:call-template name="createDocListForVersions">
                    <xsl:with-param name="ids" select="$newFacsimiles"/>
                    <xsl:with-param name="collection" select="$docsByTag($tag)"/>
                    <xsl:with-param name="currData" select="$currData"/>
                </xsl:call-template>
            </cell>
        </row>
    </xsl:template>
  
    <xsl:template name="createDocListForVersions">
        <xsl:param name="ids"/>
        <xsl:param name="currData"/>
        <xsl:param name="collection"/>
        <xsl:variable name="taxCats" select="$taxonomyDoc//category" as="element(category)+"/>
        
        <xsl:for-each-group select="$ids" group-by="$currData(.)?exhibit">
            <xsl:sort select="($taxCats[@xml:id = current-grouping-key()]/@n, 10)[1] => xs:integer()"/>
            <xsl:variable name="thisTax" select="$taxCats[@xml:id = current-grouping-key()]" as="element(category)?"/>
            <list>
                <label> 
                    <xsl:choose>
                        <xsl:when test="current-grouping-key() = ''">Uncategorized</xsl:when>
                        <xsl:otherwise>
                            <ref target="../{current-grouping-key()}.html">
                                <xsl:value-of select="normalize-space(string-join($thisTax/catDesc/term/text()))"/>
                            </ref>
                        </xsl:otherwise>
                    </xsl:choose>
                </label>
                <xsl:for-each select="current-group()">
                    <xsl:sort select="wea:docTitle(., $collection)"/>
                    <item>
                        <xsl:sequence select="wea:docTitleLink(., $collection)"/>
                        <xsl:if test="$currData(.)?doctype">
                            <xsl:value-of select="' [' || $currData(.)?doctype || ']'"/>
                        </xsl:if>
                    </item>
                </xsl:for-each>
            </list>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='diagnostics_content']">
        <xsl:call-template name="createDiagnostics"/>
    </xsl:template>
    
    
    
    
    <xsl:template name="createDiagnostics">
        <xsl:message>Generating diagnostics...</xsl:message>
        <div xml:id="diagnostics_content">
            <head>WEA Site Diagnostics</head>
            <div>
                <head>Checks</head>
                <xsl:call-template name="createChecks"/>
            </div>
        </div>
    </xsl:template>

    
    
    <xsl:template name="createChecks">
        <!--Initial checks that fail on error-->
        <xsl:call-template name="duplicateIds"/>
        <xsl:call-template name="badRedirects"/>
        <xsl:call-template name="checkNextPrevs"/>

        <!--Diagnostic checks-->
        <xsl:call-template name="documentsAwaitingMC"/>
        <xsl:call-template name="documentsWithoutFacs"/>
        <xsl:call-template name="documentsWithoutGenre"/>
        <xsl:call-template name="documentsWithoutExhibit"/>
        <xsl:call-template name="facsWithoutNotes"/>
        <xsl:call-template name="japaneseWordsWithoutTerm"/>
    </xsl:template>
    
    
    <xsl:template name="duplicateIds">
        <xsl:message>Checking for duplicate ids...</xsl:message>
        <xsl:variable name="errors"
            select="for $id in map:keys($idMap) return if (count($idMap($id)) gt 1) then $id else ()"
            as="xs:string*"/>
        <xsl:if test="count($errors) gt 0">
            <xsl:for-each select="$errors">
                <xsl:message>ERROR: Duplicate id: <xsl:value-of select="."/> (<xsl:value-of select="string-join($idMap(.),', ')"/>)</xsl:message>
            </xsl:for-each>
            <xsl:message terminate="yes"/>
        </xsl:if>    
    </xsl:template>
    
    <xsl:template name="badRedirects">
        <xsl:message>Checking for bad redirects...</xsl:message>
        <!--Get the most recent-->
        <xsl:variable name="deletedDocs" select="for $id in map:keys($versionsMap($sortedTags[2])) return if (map:contains($versionsMap($sortedTags[1]), $id)) then () else $id" as="xs:string*"/>
        <xsl:variable name="redirectedDocs" select="$redirectsDoc//link/@target ! replace(tokenize(.)[1],'^.+:','')" as="xs:string+"/>
        <xsl:variable name="notRedirected" select="$deletedDocs[not(. = $redirectedDocs)]" as="xs:string*"/>
        <xsl:if test="exists($notRedirected)">
            <xsl:message terminate="yes">ERROR: Documents <xsl:value-of select="string-join($notRedirected, ', ')"/> have been
            deleted but not redirected.</xsl:message>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="checkNextPrevs">
        <xsl:variable name="instalments" select="$dataDocs//TEI[descendant::text[@next or @prev]]" as="element(TEI)+"/>
        <xsl:message>Checking for bad instalment sequencing in <xsl:value-of select="count($instalments)"/> docs...</xsl:message>
        <!--First, compile all of the documents into a map to make the sequence checking a bit faster-->
        <xsl:variable name="instalmentMap" as="map(*)">
            <xsl:map>
                <xsl:for-each select="$instalments">
                    <xsl:map-entry key="string(@xml:id)">
                        <xsl:map>
                            <xsl:for-each select="descendant::text/(@next | @prev)">
                                <xsl:map-entry key="local-name()"
                                    select="replace(string(.),'^doc:','')"/>
                            </xsl:for-each>
                        </xsl:map>
                    </xsl:map-entry>
                </xsl:for-each>
            </xsl:map>
        </xsl:variable>
        <!--Now iterate through all of the keys and gather the errors-->
        <xsl:iterate select="map:keys($instalmentMap)">
            <xsl:param name="errors" as="xs:string*"/>  
            <xsl:on-completion>
                <!--If there are errors, output the message and fail the build-->
                <xsl:if test="not(empty($errors))">
                    <xsl:message terminate="yes">
                        <xsl:for-each select="$errors">
                            <xsl:message><xsl:value-of select="."/></xsl:message>
                        </xsl:for-each>
                    </xsl:message>
                </xsl:if>
            </xsl:on-completion>
            <xsl:variable name="curr" select="."/>
            <xsl:variable name="currMap" select="$instalmentMap(.)" as="map(*)"/>
            <xsl:next-iteration>
                <xsl:with-param name="errors" as="xs:string*">
                    <xsl:sequence select="$errors"/>
                    <!--Now iterate through the next/prev values on the current document,
                    and see if the inverse value is correct; in other words,
                    if Doc2 has prev=Doc1 and next=Doc3,
                    make sure that Doc1 has next = Doc2
                    and Doc3 has prev = Doc2
                    -->
                    <xsl:for-each select="map:keys($currMap)">
                        <xsl:variable name="key" select="." as="xs:string"/>
                        <xsl:variable name="inv" select="if ($key = 'next') then 'prev' else 'next'"/>
                        <xsl:variable name="val" select="$currMap($key)" as="xs:string"/>
                        <xsl:variable name="docExists" select="exists($dataDocs//TEI[@xml:id = $val])" as="xs:boolean"/>
                        <xsl:variable name="hasInv" 
                            select="if ($docExists) 
                            then (map:contains($instalmentMap, $val) and map:contains($instalmentMap($val), $inv))
                            else false()"
                            as="xs:boolean"/>
                        <xsl:variable name="hasCorrectVal" 
                            select="if ($hasInv)
                            then map:get($instalmentMap($val), $inv) = $curr 
                            else false()" 
                            as="xs:boolean"/>
                        <xsl:if test="not($docExists and $hasInv and $hasCorrectVal)">
                            <xsl:value-of>
                                <xsl:value-of 
                                    expand-text="yes">ERROR: {$curr} has {$key}="doc:{$val}", but </xsl:value-of>
                                <xsl:choose>
                                    <xsl:when test="not($docExists)">
                                        <xsl:value-of 
                                            expand-text="yes">{$val} doesn't exist</xsl:value-of>
                                    </xsl:when>
                                    <xsl:when test="not($hasInv)">
                                        <xsl:value-of
                                            expand-text="yes">{$val} has no {$inv} value</xsl:value-of>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of 
                                            expand-text="yes">{$val} has {$inv}="doc:{map:get($instalmentMap($val), $inv)}"</xsl:value-of>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:value-of>                            
                        </xsl:if>
                    </xsl:for-each>
                </xsl:with-param>
            </xsl:next-iteration>
        </xsl:iterate>
    </xsl:template>
   
    
    <xsl:template name="documentsAwaitingMC">
        <xsl:variable name="waitingDocs" select="$dataDocs//TEI[descendant::revisionDesc/@status='readyForProof']"/>
        <xsl:variable name="inProgressDocs" select="$dataDocs//TEI[descendant::revisionDesc/@status = 'inProgress']"/>
        
        <xsl:call-template name="makeDiv">
            <xsl:with-param name="heading">Documents Ready for Proofing</xsl:with-param>
            <xsl:with-param name="description">
                <p>Documents with the <att>status</att> value of <val>readyForProof</val> need to be reviewed by the Project Director before they can moved to published. If the Project Director has proofed these documents (i.e. they have been checked off as <q>Done</q> in the Google Drive spreadsheet), then the status should be changed to <val>published</val> with a corresponding new <gi>change</gi> element with a <att>status</att> value of <val>published</val> that gives who changed it and the date that it was published (using the <att>who</att> and <att>when</att> attributes, respectively).</p>
            </xsl:with-param>
            <xsl:with-param name="labels" select="('Document ID', 'Document Name')"/>
            <xsl:with-param name="errors" select="wea:makeErrorSeq($waitingDocs)"/>
        </xsl:call-template>
        
        <xsl:call-template name="makeDiv">
            <xsl:with-param name="heading">Documents In Progress</xsl:with-param>
            <xsl:with-param name="description">
                <p>Documents with the <att>status</att> value of <val>inProgress</val> are documents currently being encoded; these should be moved to readyForProof once ready to be reviewed.</p>
            </xsl:with-param>
            <xsl:with-param name="labels" select="('Document ID', 'Document Name')"/>
            <xsl:with-param name="errors" select="wea:makeErrorSeq($inProgressDocs)"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="documentsWithoutFacs">
        <xsl:variable name="errors" select="$dataDocs//TEI[descendant::catRef[contains(@target,'Primary')]][not(descendant::text/@facs)]"/>
        <xsl:call-template name="makeDiv">
            <xsl:with-param name="heading">Documents without Facsimiles</xsl:with-param>
            <xsl:with-param name="description">
                <p>All primary source documents should be associated with a facsimile. These are the ones currently
                    missing facsimiles.</p>
            </xsl:with-param>
            <xsl:with-param name="labels" select="('Document ID', 'Document Name')"/>
            <xsl:with-param name="errors" select="wea:makeErrorSeq($errors)"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="facsWithoutNotes">
        <xsl:variable name="errors" select="$dataDocs//TEI[not(descendant::notesStmt/note)][descendant::text[@facs]]" as="element(TEI)*"/>
        <xsl:call-template name="makeDiv">
            <xsl:with-param name="heading">Documents with facsimiles without a note</xsl:with-param>
            <xsl:with-param name="description">
                <p>All documents with facsimiles should have a note describing the open-access source of the facsimile.</p>
            </xsl:with-param>
            <xsl:with-param name="labels" select="'ID', 'Document'"/>
            <xsl:with-param name="errors" select="wea:sortByDocId($errors) ! array{./@xml:id, wea:docTitleLink(@xml:id)}"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="documentsWithoutGenre">
        <xsl:variable name="errors" select="$dataDocs//TEI[descendant::catRef[contains(@target,'Primary')]][not(descendant::catRef[@scheme='wdt:genre'])]"/>
        <xsl:call-template name="makeDiv">
            <xsl:with-param name="heading">Documents without genre <gi>catRef</gi></xsl:with-param>
            <xsl:with-param name="description">
                <p>All primary source documents should have a <gi>catRef</gi> element with a genre:
                    <egXML xmlns="http://www.tei-c.org/ns/Examples">
                        <catRef scheme="wdt:genre" target="wdt:genreShortStory"/>
                    </egXML>
                </p>
            </xsl:with-param>
            <xsl:with-param name="labels" select="('Document ID', 'Document Name')"/>
            <xsl:with-param name="errors" select="wea:makeErrorSeq($errors)"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="documentsWithoutExhibit">
        <xsl:variable name="errors" select="$dataDocs//TEI[descendant::catRef[contains(@target,'Primary')]][not(descendant::catRef[@scheme='wdt:exhibit'])]"/>
        <xsl:call-template name="makeDiv">
            <xsl:with-param name="heading">Documents without exhibit <gi>catRef</gi></xsl:with-param>
            <xsl:with-param name="description">
                <p>All primary source documents should have a <gi>catRef</gi> element with an exhibit:
                    <egXML xmlns="http://www.tei-c.org/ns/Examples">
                        <catRef scheme="wdt:exhibit" target="wdt:EarlyExperiment"/>
                    </egXML>
                </p>
            </xsl:with-param>
            <xsl:with-param name="labels" select="('Document ID', 'Document Name')"/>
            <xsl:with-param name="errors" select="wea:makeErrorSeq($errors)"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="japaneseWordsWithoutTerm">
        <xsl:variable name="errors" select="$dataDocs//foreign[@xml:lang='ja'][not(ancestor::term[@ref])]" as="element(foreign)*"/>
        <xsl:call-template name="makeDiv">
            <xsl:with-param name="heading">Japanese terms without a glossary entry</xsl:with-param>
            <xsl:with-param name="description">
                <p>All Japanese terms (i.e. terms tagged with <gi>foreign</gi>/<att>xml:lang</att>=<val>ja</val>) should be associated with a 
                    term in the glossary.
                </p>
                <p>Note that this diagnostic is meant to evaluate the list of terms we will need for the glossary IN FUTURE. We do not currently have the mechanism set up to tag these terms.</p>
            </xsl:with-param>
            <xsl:with-param name="labels" select="('Term', 'Documents')"/>
            <xsl:with-param name="errors" as="array(item()*)*">
                <xsl:for-each-group select="$errors" group-by="lower-case(string(.))">
                    <xsl:sort select="lower-case(current-grouping-key())"/>
                    <xsl:variable name="term" select="current-grouping-key()"/>
                    <xsl:variable name="docs" as="item()*">
                        <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                            <xsl:sequence select="wea:docTitleLink(current-grouping-key())"/>
                            <xsl:if test="position() ne last()"><xsl:text> | </xsl:text></xsl:if>
                        </xsl:for-each-group>               
                    </xsl:variable>
                    <xsl:sequence select="array{$term, array{$docs}}"/>
                </xsl:for-each-group>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="makeDiv">
        <xsl:param name="errors"/>
        <xsl:param name="heading"/>
        <xsl:param name="description"/>
        <xsl:param name="labels"/>
        <xsl:message>Running diagnostic: <xsl:value-of select="$heading"/></xsl:message>
        <div type="diagnostic">
            <head n="{count($errors)}"><xsl:sequence select="$heading"/></head>
            <xsl:sequence select="$description"/>
            <xsl:choose>
                <xsl:when test="count($errors) = 0">
                    <p>None found!</p>
                </xsl:when>
                <xsl:otherwise>
                    <table>
                        <row role="label">
                            <xsl:for-each select="$labels">
                                <cell><xsl:value-of select="."/></cell>
                            </xsl:for-each>
                        </row>
                        <xsl:for-each select="$errors">
                            <xsl:variable name="array" select="." as="array(*)"/>
                            <row>
                                <xsl:for-each select="1 to array:size($array)">
                                    <cell><xsl:sequence select="array:flatten(array:get($array, .))"/></cell>
                                </xsl:for-each>
                            </row>
                        </xsl:for-each>
                    </table>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:function name="wea:docTitleLink" as="element(ref)" new-each-time="no">
        <xsl:param name="id" as="xs:string"/>
        <xsl:sequence select="wea:docTitleLink($id, $dataDocs)"/>
    </xsl:function>
    
    <xsl:function name="wea:sortByDocId" as="element(TEI)*" new-each-time="no">
        <xsl:param name="docs" as="element(TEI)*"/>
        <xsl:sequence select="sort($docs, (), function($doc){$doc/@xml:id})"/>
    </xsl:function>
    
    <xsl:function name="wea:makeErrorSeq" as="array(*)*">
        <xsl:param name="errors" as="element(TEI)*"/>
        <xsl:sequence select="wea:sortByDocId($errors) ! array{string(./@xml:id), wea:docTitleLink(./@xml:id)}"/>
    </xsl:function>
    
    <xsl:function name="wea:docTitleLink" as="element(ref)" new-each-time="no">
        <xsl:param name="id" as="xs:string"/>
        <xsl:param name="docs" as="document-node()+"/>
        <ref target="../{$id}.html">
            <xsl:value-of select="wea:docTitle($id, $docs)"/>
        </ref>
    </xsl:function>
    
    <xsl:function name="wea:docTitle" as="xs:string" new-each-time="no">
        <xsl:param name="id" as="xs:string"/>
        <xsl:value-of select="wea:docTitle($id, $dataDocs)"/>
    </xsl:function>
    
    <xsl:function name="wea:docTitle" as="xs:string" new-each-time="no">
        <xsl:param name="id" as="xs:string"/>
        <xsl:param name="docs" as="document-node()+"/>
        <xsl:value-of select="$docs//TEI[@xml:id=$id]/teiHeader/fileDesc/titleStmt/title[1]"/>
    </xsl:function>
    
    <xsl:function name="wea:getWordCount" as="xs:integer">
        <xsl:param name="node" as="node()"/>
        <xsl:choose>
            <!--If there's a gap, then just skip the thing-->
            <xsl:when test="$node[descendant::tei:gap[@reason='noTranscriptionAvailable']]">
                <xsl:sequence select="0"/>
            </xsl:when>
            <xsl:otherwise>
                <!--Retrieve all relevant text nodes-->
                <xsl:variable name="text" select="$node/descendant::text()[not(ancestor-or-self::tei:note[@type='editorial'] or ancestor-or-self::tei:corr)][matches(.,'\S')]" as="text()*"/>
                
                <!--Count them up by analyze the string, finding all matches for non-space characters, and then counting them-->
                <xsl:variable name="wc" select="count(analyze-string(string-join($text),'\S+')//*:match)" as="xs:integer"/>
                <xsl:sequence select="$wc"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    
</xsl:stylesheet>