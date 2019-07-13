<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: July 6, 2019</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This module, called from the xml_original_master.xsl, creates a table of pseudonyms for WE.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:template name="createPseudonymsTable">
        <xsl:variable name="tempDivs" as="element(div)*">
            <xsl:for-each-group select="$sourceXml[//catRef[contains(@target,'docPrimarySource')]][//sourceDesc/bibl[@copyOf]]//text" group-by="wea:getYearFromBibl(.)">
                <xsl:sort select="current-grouping-key()" order="ascending"/>
                    <div>
                        <head><xsl:value-of select="if (current-grouping-key() ne '') then current-grouping-key() else 'Undated'"/></head>
                        <xsl:variable name="year" select="current-grouping-key()"/>
                        <list>
                            <xsl:for-each-group select="current-group()//name[@ref='pers:WE1'][not(ancestor::note[@type='editorial'])]" group-by="lower-case(normalize-space(string-join(descendant::text(),'')))">
                                <xsl:if test="not(empty(current-grouping-key()))">
                                    <item>
                                        <xsl:value-of select="wea:namecase(current-grouping-key())"/> (<xsl:value-of select="count(current-group())"/>)
                                        <list>
                                            <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                                                <xsl:sort select="count(current-group())"/>
                                                <item><ref target="doc:{current-grouping-key()}"><xsl:value-of select="current-grouping-key()"/></ref></item>
                                            </xsl:for-each-group>
                                        </list>
                                    </item>
                                </xsl:if>
                                
                            </xsl:for-each-group>
                        </list>
                        
                    </div>
                
            </xsl:for-each-group>
        </xsl:variable>
        <xsl:sequence select="$tempDivs/self::div[descendant::item]"/>
        
        
        
        <!--<xsl:for-each-group select="" group-by="lower-case(normalize-space(string-join(descendant::text(),'')))">
            <xsl:sort select="count(current-group())" order="descending"/>
            <div>
                <cell><xsl:value-of select="wea:namecase(current-grouping-key())"/></cell>
                <cell><xsl:value-of select="count(current-group())"/></cell>
                <cell>
                    <list>
                        <xsl:for-each-group select="current-group()" 
                            group-by="wea:getYearFromBibl(.)">
                            <xsl:sort select="exists(wea:getYearFromBibl(.))" order="descending"/>
                            <xsl:sort select="wea:getYearFromBibl(.)" order="ascending"/>
                            
                            <item>
                                <xsl:value-of select="if (current-grouping-key() castable as xs:integer) then current-grouping-key() else 'Undated'"/> (<xsl:value-of select="count(current-group())"/>)
                                <list>
                                    <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                                        <item>
                                            <ref target="doc:{current-grouping-key()}"><xsl:sequence select="current-group()[1]/ancestor::TEI/teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref>
                                        </item>
                                    </xsl:for-each-group>
                                </list>
                                
                            </item>
                        </xsl:for-each-group> 
                    </list>
                    
                </cell>
            </div>
        </xsl:for-each-group>
        -->
        <!--<div>
            <table>
                <row role="label">
                    <cell>Pseudonym</cell>
                    <cell role="sortkey">Uses</cell>
                    <cell>Documents by Date</cell>
                <!-\-    <cell>Documents by Exhibit</cell>-\->
                </row>
                <xsl:for-each-group select="$sourceXml[//catRef[contains(@target,'docPrimarySource')]]//text//name[@ref='pers:WE1'][not(ancestor::note[@type='editorial'])]" group-by="lower-case(normalize-space(string-join(descendant::text(),'')))">
                    <xsl:sort select="count(current-group())" order="descending"/>
                    <row>
                        <cell><xsl:value-of select="wea:namecase(current-grouping-key())"/></cell>
                        <cell><xsl:value-of select="count(current-group())"/></cell>
                        <cell>
                            <list>
                                <xsl:for-each-group select="current-group()" 
                                    group-by="wea:getYearFromBibl(.)">
                                    <xsl:sort select="exists(wea:getYearFromBibl(.))" order="descending"/>
                                    <xsl:sort select="wea:getYearFromBibl(.)" order="ascending"/>
                                  
                                    <item>
                                        <xsl:value-of select="if (current-grouping-key() castable as xs:integer) then current-grouping-key() else 'Undated'"/> (<xsl:value-of select="count(current-group())"/>)
                                        <list>
                                            <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                                                <item>
                                                    <ref target="doc:{current-grouping-key()}"><xsl:sequence select="current-group()[1]/ancestor::TEI/teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref>
                                                </item>
                                            </xsl:for-each-group>
                                        </list>
                                     
                                    </item>
                                </xsl:for-each-group> 
                            </list>
                           
                        </cell>
                        <!-\-Probably don't need by exhibit, since that's arbitrary anyway-\->
  <!-\-                      <cell>
                            <list>
                                <xsl:for-each-group select="current-group()" group-by="ancestor::TEI//catRef[@scheme='wdt:exhibit']/@target/substring-after(.,'wdt:')">
                                    <xsl:sort select="$sourceXml//category[@xml:id=current-grouping-key()]/@n"/>
                                    <xsl:variable name="thisCat" select="$sourceXml//category[@xml:id=current-grouping-key()]"/>
                                    <item>
                                        <ref target="doc:{current-grouping-key()}"><xsl:sequence select="$thisCat/catDesc/term/node()"/></ref>
                                         <list>
                                             <xsl:for-each-group select="current-group()" group-by="ancestor::TEI/@xml:id">
                                                 <xsl:variable name="thisDocTitle" select="$sourceXml[//TEI/@xml:id=current-grouping-key()]/TEI/teiHeader/fileDesc/titleStmt/title[1]"/>
                                                 <item><ref target="doc:{current-grouping-key()}"><xsl:sequence select="$thisDocTitle/node()"/></ref></item>
                                             </xsl:for-each-group>
                                         </list>
                                    </item>
                
                                </xsl:for-each-group>
                            </list>
                        </cell>-\->
                    </row>
                </xsl:for-each-group>
            </table>
           
        </div>-->
    </xsl:template>
    
    <xsl:function name="wea:getYearFromBibl" as="xs:string?">
        <xsl:param name="node"/>
        <xsl:variable name="biblPtr" select="$node/ancestor::TEI//sourceDesc/bibl[@copyOf][1]/translate(@copyOf,':','')"/>
        <xsl:variable name="bibls" select="$sourceXml//TEI[@xml:id='bibliography']//bibl[date]" as="element(bibl)+"/>
        <xsl:variable name="year" select="normalize-space($bibls[@xml:id=$biblPtr]/date/(@when|@notBefore)/tokenize(.,'-')[1])" as="xs:string?"/>
        <xsl:value-of select=" if ($year ne '') then $year else ()"/>
    </xsl:function>
    
    <xsl:function name="wea:namecase">
        <xsl:param name="name"/>
        <xsl:value-of select="for $r in tokenize($name,'\s+') return concat(upper-case(substring($r,1,1)),substring($r,2))" separator=" "/>
    </xsl:function>
    
</xsl:stylesheet>