<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet creates the index page(s) for the WEA project.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:include href="xhtml_templates_module.xsl"/>
    <xsl:include href="globals.xsl"/>
    
   <xsl:template match="/">
       <xsl:call-template name="createIndexPage"/>
       
   </xsl:template> 
    
    
   <xsl:template name="createIndexPage">
       <xsl:variable name="temp">
           <tei:TEI xml:id="index">
               <xsl:copy-of select="wea:createTeiHeader('Index')"/>
               <tei:text>
                   <tei:body>
                       <tei:div>
                           <tei:table>
                               <tei:row role="label">
                                   <tei:cell>Title</tei:cell>
                                   <tei:cell>ID</tei:cell>
                               </tei:row>
                               <tei:row>
                                   <tei:cell><ref target="documentation.html">Documentation</ref></tei:cell>
                                   <tei:cell>documentation</tei:cell>
                               </tei:row>
                               <xsl:for-each select="$xmlDocs">
                                   <tei:row>
                                       <tei:cell><tei:ref target="{//TEI/@xml:id}.html"><xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[1]"/></tei:ref></tei:cell>
                                       <tei:cell><xsl:value-of select="//TEI/@xml:id"/></tei:cell>
                                   </tei:row>
                               </xsl:for-each>
                           </tei:table>
                       </tei:div>
                   </tei:body>
               </tei:text>
           </tei:TEI>
       </xsl:variable>
       <xsl:apply-templates mode="tei" select="$temp"/>
   </xsl:template>
    
    <xsl:function name="wea:createTeiHeader">
        <xsl:param name="title"/>
        <tei:teiHeader>
            <tei:fileDesc>
                <tei:titleStmt>
                    <tei:title><xsl:value-of select="$title"/></tei:title>
                </tei:titleStmt>
                <tei:publicationStmt>
                    <tei:p>Publication Information</tei:p>
                </tei:publicationStmt>
                <tei:sourceDesc>
                    <tei:p>Information about the source</tei:p>
                </tei:sourceDesc>
            </tei:fileDesc>
        </tei:teiHeader>
    </xsl:function>
    
    
</xsl:stylesheet>