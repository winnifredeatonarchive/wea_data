<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 13, 2019</xd:p>
            <xd:p><xd:b>Author:</xd:b> joeytakeda</xd:p>
            <xd:p>This utility transform converts a TEI representation of the Google Drive WEA spreadsheet
                  (exported as Excel, fixed up, and then converted into TEI via 
                <xd:a href="https://oxgarage.tei-c.org/#">OxGarage</xd:a>. It then turns that converted TEI
            table to a CSV using the CSV conversion by James Cummings for the TEI (.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="text"/>
    
    <!--Just a parameter to create a subset-->
    <xsl:param name="subset" select="false()"/>
    
    <xsl:variable name="dq">"</xsl:variable>
    <xsl:variable name="qdq">""</xsl:variable>
    
    <xsl:template match="/">
        <xsl:call-template name="csv">
            <xsl:with-param name="context">
                <xsl:apply-templates mode="#current"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    
    <xsl:template match="TEI | text | body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--We want to add 3 more cells, but get rid of the rest-->
    <xsl:template match="row[@n='1']">
        <row>
            <xsl:copy-of select="cell[1] | cell[2] "/>
            <cell>Description</cell>
            <cell>Subtask Of</cell>
            <cell>Due Date</cell>
            <cell>Assignee</cell>
        </row>
    </xsl:template>
    
    <!--WHAT IT LOOKS LIKE
        Category | Task Name | Description | Subtask Of | Due Date-->
   <xsl:template match="row[not(@n='1')]">
       <table>
           <xsl:variable name="currRow" select="."/>
           <xsl:variable name="hasLink" select="contains(cell[2],'https://drive.google.com/')"/>
           <xsl:variable name="tokens" select="normalize-space(cell[2]) => replace($dq,'') => tokenize('\s*,\s*')"/>
           <xsl:variable name="link" select="if ($hasLink) then ('Google Drive: ' || $tokens[1]) else ()"/>
           <xsl:variable name="name" select="if ($hasLink) then ($tokens[2]) else normalize-space(cell[2])"/>
           <xsl:variable name="fullName" select="concat($name,if (cell[3] ne '') then concat(' (', cell[3], ')') else ())"/>
           <row>
               <xsl:copy-of select="cell[1]"/>
               <cell><xsl:value-of select="$fullName"/></cell>
               <cell><xsl:value-of select="$link"/>
                   <xsl:if test="cell[3] ne ''">
                       <xsl:text>; </xsl:text>
                       Beta site: https://jenkins.hcmc.uvic.ca/job/WEA/lastSuccessfulBuild/artifact/products/site/<xsl:value-of select="normalize-space(cell[3])"/>.html
                   </xsl:if>
               </cell>
               <cell/>
               <cell/>
               <cell/>
           </row>
           <xsl:if test="cell[3] = ''">
               <row>
                   <cell><xsl:value-of select="$currRow/cell[1]"/></cell>
                   <cell>Add to bibliography and generate TEI shell</cell>
                   <cell/>
                   <cell><xsl:value-of select="$fullName"/></cell>
                   <cell/>
               </row>
           </xsl:if>
           <xsl:for-each select="cell[position() gt 3]">
               <xsl:variable name="currPos" select="count(preceding-sibling::cell)"/>
               <row>
                   <cell><xsl:value-of select="$currRow/cell[1]"/></cell>
                   <cell><xsl:value-of select="ancestor::table/row[1]/cell[count(preceding-sibling::cell) = $currPos]"/></cell>
                   <cell/>
                   <cell><xsl:value-of select="$fullName"/></cell>
                   <xsl:choose>
                       <xsl:when test="normalize-space(.) = ('X', '1')">
                           <cell>
                               <xsl:text>04/08/2019</xsl:text>
                           </cell>
                           <cell>joey.takeda@gmail.com</cell>
            
                       </xsl:when>
                       <xsl:otherwise>
                           <cell/>
                           <cell/>
                       </xsl:otherwise>
                   </xsl:choose>
               </row>
           </xsl:for-each>
       </table>
       
       
   </xsl:template> 
    

    
    
    <xsl:template match="teiHeader | body/head"/>
    
    
    
    <!--This is taken near verbatim from James Cummings' implementation here: 
        https://raw.githubusercontent.com/TEIC/Stylesheets/250263a363b033b62b3f00a5f99c5319eac3dbd1/profiles/default/csv/to.xsl-->
    
    <xsl:template name="csv">
        <xsl:param name="context"/>
        <xsl:message>Found <xsl:value-of select="count($context/table)"/> texts with a total of <xsl:value-of select="count($context/table/row)"/> tasks!</xsl:message>
        <xsl:for-each select="$context/tei:row">
            <xsl:call-template name="makeRow"/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
        <xsl:for-each select="$context/tei:table[wea:test(.)]">
            <xsl:for-each select="tei:row">
                <xsl:call-template name="makeRow"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="makeRow">
        <xsl:for-each select="tei:cell">
            <xsl:value-of select="concat($dq,replace(normalize-space(.),$dq,$qdq),$dq)"/>
            <xsl:if test="following-sibling::tei:cell[1]">,</xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:function name="wea:test" as="xs:boolean">
        <xsl:param name="row"/>
        <xsl:variable name="pos" select="count($row/preceding-sibling::table)" as="xs:integer"/>
        <xsl:choose>
            <xsl:when test="$subset">
                <xsl:value-of select="xs:boolean(($pos mod 59) =0)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="true()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    
    
</xsl:stylesheet>