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
    
    
    <!--Clean up empty names in the respStmts-->
    <xsl:template match="respStmt/name[@ref][normalize-space(text())='']" mode="original">
        <xsl:variable name="thisRef" select="@ref"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="$sourceXml[//TEI/@xml:id='people']//person[@xml:id=substring-after($thisRef,'pers:')]/persName/reg"/>
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
    
    
    
    <xsl:template match="@*|node()" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>