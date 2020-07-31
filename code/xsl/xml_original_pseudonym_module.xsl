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

        
  
        <div>
            <table>
                <row role="label">
                    <cell>Pseudonym</cell>
                    <cell role="sortkey">Uses</cell>
                    <cell>Documents by Date</cell>
                </row>
                <xsl:for-each-group select="$sourceXml[//catRef[contains(@target,'docPrimarySource')]]//text//name[@ref='pers:WE1'][not(ancestor::note[@type='editorial'])]" group-by="wea:makePseudo(.)">
                    <xsl:sort select="count(current-group())" order="ascending"/>
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
                    </row>
                </xsl:for-each-group>
            </table>
           
        </div>
    </xsl:template>
    
    <xsl:function name="wea:getYearFromBibl" as="xs:string?" new-each-time="no">
        <xsl:param name="node"/>
        <xsl:variable name="biblPtr" select="$node/ancestor::TEI//sourceDesc/bibl[@copyOf][1]/translate(@copyOf,':','')"/>
        <xsl:variable name="bibls" select="$sourceXml//TEI[@xml:id='bibliography']//bibl[date]" as="element(bibl)+"/>
        <xsl:variable name="year" select="normalize-space($bibls[@xml:id=$biblPtr]/date/(@when|@notBefore)/tokenize(.,'-')[1])" as="xs:string?"/>
        <xsl:value-of select=" if ($year ne '') then $year else ()"/>
    </xsl:function>
    

    
</xsl:stylesheet>