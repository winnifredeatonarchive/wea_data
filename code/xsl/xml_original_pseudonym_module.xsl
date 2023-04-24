<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:json="http://www.w3.org/2005/xpath-functions"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: July 6, 2019</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This module, called from the xml_original_master.xsl, creates a table of pseudonyms for WE.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:variable name="pseudoMap" as="map(xs:string, item()*)">
        <xsl:map>
            <xsl:for-each-group select="$sourceXml[//catRef[contains(@target,'docPrimarySource')]]//text//name[@ref='pers:WE1'][not(ancestor::note[@type='editorial'])]" group-by="wea:makePseudo(.)">
                <xsl:map-entry key="xs:string(wea:namecase(current-grouping-key()))">
                    <xsl:map>
                        <xsl:for-each-group select="current-group()" group-by="wea:getYearFromBibl(.)">
                            <xsl:sort select="exists(wea:getYearFromBibl(.))" order="descending"/>
                            <xsl:sort select="wea:getYearFromBibl(.)" order="ascending"/>
                            <xsl:map-entry key="if (current-grouping-key() castable as xs:integer) then current-grouping-key() else 'Undated'">
                                <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                                    <xsl:value-of select="xs:string(current-grouping-key())"/>
                                </xsl:for-each-group>
                            </xsl:map-entry>
                        </xsl:for-each-group>
                    </xsl:map>
                </xsl:map-entry>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:variable>
    
    <xsl:variable name="allPseudoNames" select="map:keys($pseudoMap)" as="xs:string+"/>
    
    <xsl:template name="createPseudonymsTimeline">
        <div xml:id="pseudonyms_timeline">
            <p>Content to be replaced by timeline.</p>
        </div>
        <xsl:variable name="jsonMap" as="element(json:map)">
            <map xmlns="http://www.w3.org/2005/xpath-functions">
                <map key="title">
                    <map key="text">
                        <string key="headline">Winnifred Eaton's Pseudonyms</string>
                    </map>
                </map>
                <array key="events">
                    <xsl:for-each select="$allPseudoNames">
                        <xsl:variable name="key" as="xs:string" select="."/>
                        <xsl:variable name="thisEntry" select="$pseudoMap(.)"/>
                        <xsl:variable name="theseDocs" select="for $year in map:keys($thisEntry)[not(. = 'Undated')] return $thisEntry($year)" as="xs:string+"/>
                        <xsl:for-each select="$theseDocs">
                            <xsl:variable name="docId" select="."/>
                            <xsl:variable name="thisDoc" select="$sourceXml//TEI[@xml:id=$docId]"/>
                            <xsl:variable name="facs" select="$thisDoc//text/@facs"/>
                            <map>
                                <xsl:if test="exists($facs)">
                                    <map key="media">
                                        <string key="url"><xsl:value-of select="replace($facs,'facs:','facsimiles/') || '.jpg'"/></string>
                                        <string key="caption">First page of <xsl:value-of select="wea:getDocTitle($docId)"/></string>
                                    </map>
                                </xsl:if>
                                <string key="group"><xsl:value-of select="$key"/></string>
                                <map key="start_date">
                                    <xsl:for-each select="tokenize(wea:getDateFromBibl($thisDoc),'-')">
                                        <xsl:variable name="pos" select="position()"/>
                                        <xsl:variable name="type" select="if ($pos = 1) then 'year' else if ($pos = 2) then 'month' else 'day'"/>
                                        <string key="{$type}"><xsl:value-of select="."/></string>
                                    </xsl:for-each>
                                </map>
                                <map key="text">
                                    <string key="headline"><xsl:value-of select="wea:getDocTitle($docId)"/></string>
                                </map>
                            </map>
                        </xsl:for-each>
                        
                    </xsl:for-each>
                </array>
            </map>
        </xsl:variable>
        <xsl:result-document href="{$outDir}/js/pseudonymsTimeline.json" method="text">
            <xsl:value-of select="xml-to-json($jsonMap)"/>
        </xsl:result-document>
    </xsl:template>
    

    
    <xsl:template name="createPseudonymsTable">
        <div >
            <table>
                <row role="label">
                    <cell>Pseudonym</cell>
                    <cell role="sortkey">Uses</cell>
                    <cell>Documents by Date</cell>
                </row>
                <xsl:for-each select="map:keys($pseudoMap)">
                    <xsl:sort select="wea:getDocCount(.)" order="ascending"/>
                    <xsl:variable name="thisPMap" select="$pseudoMap(.)"/>
                    <row>
                        <cell><xsl:value-of select="."/></cell>
                        <cell><xsl:value-of select="wea:getDocCount(.)"/></cell>
                        <cell>
                            <list>
                                <!--Dates-->
                                <xsl:for-each select="map:keys($thisPMap)">
                                    <xsl:sort select=". = 'Undated'" order="descending"/>
                                    <xsl:sort select="." order="ascending"/>
                                    <xsl:variable name="date" select="."/>
                                    <xsl:variable name="docIds" select="$thisPMap($date)"/>
                                    <item>
                                        <xsl:value-of select="."/>
                                        <list>
                                            <xsl:for-each select="$docIds">
                                                <xsl:sort select="."/>
                                                <xsl:variable name="docId" select="."/>
                                                <item><ref target="doc:{.}"><xsl:sequence select="wea:getDocTitle($docId)"/></ref></item>
                                            </xsl:for-each>
                                        </list>
                                    </item>
                                </xsl:for-each>
                            </list>
                        </cell>
                    </row>
                </xsl:for-each>
            </table>
           
        </div>
    </xsl:template>
    
    
    <xsl:function name="wea:getDocTitle" as="node()*" new-each-time="no">
        <xsl:param name="docId" as="xs:string"/>
        <xsl:sequence select="$sourceXml//TEI[@xml:id=$docId]/teiHeader/fileDesc/titleStmt/title[1]/node()"/>
    </xsl:function>
    
    <xsl:function name="wea:getDocCount" as="xs:integer" new-each-time="no">
        <xsl:param name="key" as="xs:string"/>
        <xsl:variable name="thisPseudoMap" select="$pseudoMap($key)"/>
        <xsl:variable name="years" select="map:keys($thisPseudoMap)"/>
        <xsl:sequence select="sum(for $year in $years return count($thisPseudoMap($year)))"/>
    </xsl:function>
    
    <xsl:function name="wea:getYearFromBibl" as="xs:string?" new-each-time="no">
        <xsl:param name="node"/>
        <xsl:variable name="date" select="wea:getDateFromBibl($node)" as="xs:string?"/>
        <xsl:variable name="year" select="tokenize($date,'-')[1]" as="xs:string?"/>
        <xsl:value-of select=" if ($year ne '') then $year else ()"/>
    </xsl:function>
            
   <xsl:function name="wea:getDateFromBibl" as="xs:string?" new-each-time="no">
       <xsl:param name="node"/>
       <xsl:variable name="bibls" select="root($node)//bibl[ancestor::msContents]" as="element(bibl)+"/>
       <xsl:variable name="date" select="$bibls/date/(@when|@notBefore)[1]"/>
       <xsl:value-of select="$date"/>
   </xsl:function>
    

    
</xsl:stylesheet>