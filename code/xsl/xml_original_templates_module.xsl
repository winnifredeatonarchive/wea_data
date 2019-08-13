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
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet is the master stylesheet for the WEA project's conversion
                from TEI P5 to XHTML5. It may load in other modules, if the complexity of the project
                necessitiates it.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template match="divGen[@xml:id='pseudonyms_table']" mode="original">
        <xsl:call-template name="createPseudonymsTable"/>
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='we_bibliography_content']" mode="original">
        <xsl:call-template name="createWEBibl"/>
    </xsl:template>
    
    <xsl:template match="divGen[@xml:id='resources_content']" mode="original">
        <xsl:call-template name="createResourcesBibl"/>
    </xsl:template>
    
    
    <!--Clean up empty names in the respStmts-->
    <xsl:template match="respStmt/name[@ref][normalize-space(text())='']" mode="original">
        <xsl:variable name="thisRef" select="@ref"/>
        <xsl:variable name="thisPerson" select="wea:getPerson($thisRef)"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="$thisPerson/persName/reg"/>
        </xsl:copy>
    </xsl:template>
    
    <!--Get the content from the copyOf bibl...-->
    <xsl:template match="bibl[@copyOf]" mode="original">
        <xsl:variable name="thisBiblPointer" select="substring-after(@copyOf,'bibl:')"/>
        <xsl:variable name="thisBiblId" select="concat('bibl',$thisBiblPointer)"/>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:variable name="thisBibl" select="$sourceXml[//TEI/@xml:id='bibliography']//bibl[@xml:id=$thisBiblId]" as="item()+"/>
            <xsl:sequence select="$thisBibl/node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="item[@corresp]" mode="original">
        <xsl:variable name="thisCorresp" select="@corresp"/>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="original"/>
            <xsl:choose>
                <!--We're pointing to a category reference-->
                <xsl:when test="starts-with($thisCorresp,'wdt:')">
                    <xsl:variable name="catId" select="substring-after($thisCorresp,'wdt:')"/>
                    <ref target="{$catId}.xml"><xsl:sequence select="$sourceXml//category[@xml:id=$catId]/catDesc/term/node()"/></ref>
                </xsl:when>
                <xsl:when test="starts-with($thisCorresp,'doc:')">
                    <xsl:variable name="docId" select="substring-after($thisCorresp,'doc:')"/>
                    <xsl:variable name="thisDoc" select="$sourceXml//TEI[@xml:id=$docId]"/>
                    <ref target="doc:{$docId}">
                        <graphic url="{$thisDoc//text/@facs}"/>
                    </ref>

                    <label><ref target="{$thisCorresp}"><xsl:sequence select="$thisDoc//teiHeader/fileDesc/titleStmt/title[1]/node()"/></ref></label>
                    <note>
                        <xsl:if test="$thisDoc//abstract">
                            <xsl:apply-templates select="$thisDoc//abstract/p/node()"/>
                            <ptr type="readMore" target="{$thisCorresp}"/>
                            <!--Now add the abstract respbyline-->
                            <xsl:copy-of select="wea:returnHeadnoteByline($thisDoc//abstract)"/>
                        </xsl:if>
                      
                    </note>
                </xsl:when>
            </xsl:choose>
            
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="notesStmt[not(ancestor::biblFull)]" mode="original">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <xsl:if test="ancestor::TEI/descendant::sourceDesc[biblFull]">
                <xsl:call-template name="addSourceDescNote"/>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="publicationStmt[not(ancestor::biblFull)][not(following-sibling::notesStmt)]" mode="original">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
        <xsl:if test="ancestor::TEI/descendant::sourceDesc[biblFull]">
            <notesStmt>
                <xsl:call-template name="addSourceDescNote"/>
            </notesStmt>
        </xsl:if>

    </xsl:template>
    
    
    <xsl:template name="addSourceDescNote">
        <note>This document is a remediation of an earlier TEI encoded file, generously provided by <xsl:value-of select="ancestor::TEI/descendant::sourceDesc/biblFull/descendant::publisher[1]"/>. Please see the source <ref target="xml/original/{ancestor::TEI/@xml:id}.xml">XML</ref> for full licensing and source details.</note>
        
    </xsl:template>
    
    
    <!--Now some additional hadnling for respStmts-->
    
    <xsl:template match="titleStmt[ancestor::TEI/descendant::abstract[@resp]]" mode="original">
        <xsl:variable name="abstract" select="ancestor::TEI/descendant::abstract" as="element(abstract)"/>
        <xsl:variable name="respPtrs" select="$abstract/@resp => tokenize('\s+') => distinct-values()" as="xs:string+"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <xsl:for-each select="$respPtrs">
                <xsl:variable name="thisPtr" select="."/>
                <xsl:variable name="thisPerson" select="wea:getPerson(.)"/>
                <respStmt>
                    <xsl:attribute name="xml:id" select="$abstract/ancestor::TEI/@xml:id || '_abstractResp_' || substring-after($thisPtr,'pers:')"/>
                    <resp>Author of Abstract</resp>
                    <name ref="{.}"><xsl:value-of select="$thisPerson/persName/reg"/></name>
                </respStmt>
            </xsl:for-each>
          
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="abstract/@resp" mode="original">
        <xsl:variable name="root" select="ancestor::TEI"/>
        <xsl:variable name="ptrs" select="tokenize(.,'\s+') => distinct-values()"/>
        <xsl:attribute name="resp" 
            select="
            for $p
            in $ptrs 
            return concat('#',$root/@xml:id,'_abstractResp_',substring-after($p,'pers:')) 
            => string-join(' ')"/>
    </xsl:template>
    
    <!--This function gets a person from the personography from our encoding-->
    <xsl:function name="wea:getPerson">
        <xsl:param name="ptr"/>
        <xsl:variable name="id" select="replace($ptr,'^pers:','')" as="xs:string"/>
        <xsl:sequence select="$sourceXml//TEI[@xml:id='people']/descendant::person[@xml:id=$id]"/>
    </xsl:function>
    
    
    <xsl:template match="@*|node()" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>