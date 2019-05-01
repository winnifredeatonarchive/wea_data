<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/winnifredeatonarchive"
    version="3.0">
    
    
    <xsl:include href="../../sch/weaQuickFixTemplates.xsl"/>
    <!--Default parameters-->
    
    <xsl:param name="documentId"/>
    <xsl:param name="yourId"/>
    <xsl:param name="encoderId"/>
    <xsl:param name="proofreaderId"/>
    <xsl:param name="transcriberId"/>
    
    
    <xsl:variable name="xhDocs" select="collection(concat('../../temp/',$documentId,'_files/GoogleDoc/?select=*.xhtml'))"/>
    <xsl:variable name="xhtmlDoc" select="for $x in $xhDocs return if (not(matches(document-uri($x),'/nav.xhtml'))) then $x else ()" as="document-node()+"/>
    <xsl:variable name="teiDoc" select="document(concat('../../data/texts/',$documentId,'.xml'))"/>
    <xsl:variable name="people" select="document('../../data/people.xml')"/>
    
    <xsl:output indent="yes" suppress-indentation="p hi seg q"/>
    
    <xsl:template name="createDoc">
        <xsl:message>NOTHING YET EXCEPT <xsl:value-of select="document-uri($xhtmlDoc)"/> and <xsl:value-of select="document-uri($teiDoc)"/></xsl:message>
        <xsl:message>Creating <xsl:value-of select="resolve-uri(concat('../../temp/',$documentId,'.xml'))"/></xsl:message>
        <xsl:variable name="pass1">
            <xsl:apply-templates select="$teiDoc" mode="tei"/>
        </xsl:variable>
        <xsl:result-document href="{concat('temp/',$documentId,'.xml')}">
           <xsl:apply-templates mode="pass2" select="$pass1"/>

        </xsl:result-document>
     
    </xsl:template>
    
    <xsl:template match="TEI" mode="pass2">
        <xsl:text>
        </xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="p/text()" mode="pass2">
        <xsl:variable name="norm">
            <xsl:value-of select="replace(.,'(^\s+|\s+$)','')"/>
        </xsl:variable>
 
            <xsl:variable name="doubleQuotes" as="xs:string">
                <xsl:variable name="temp">
                    <xsl:for-each select="$norm">
                        <xsl:call-template name="replaceApos">
                            <xsl:with-param name="useDq" select="true()"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:variable>
              <xsl:value-of select="string-join($temp,'')"/>
            </xsl:variable>
        
        <xsl:variable name="singleQuotes" as="xs:string">
           <xsl:variable name="temp">
               <xsl:for-each select="$doubleQuotes">
                <xsl:call-template name="replaceApos">
                    <xsl:with-param name="useDq" select="false()"/>
                </xsl:call-template>
            </xsl:for-each>
           </xsl:variable>
            <xsl:value-of select="string-join($temp,'')"/>
        </xsl:variable>
        
        
        <xsl:for-each select="$singleQuotes">
            <xsl:call-template name="tagQuote">
                <xsl:with-param name="left">“</xsl:with-param>
                <xsl:with-param name="right">”</xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:template match="text/body/div" mode="tei">
        <xsl:copy>
            <xsl:apply-templates select="$xhtmlDoc//xh:body" mode="xh"/>
            <xsl:message>What is XHTML DOC <xsl:copy-of select="$xhtmlDoc"/></xsl:message>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="xh:p[normalize-space(string-join(descendant::text(),'')) ne '']" mode="xh">
        <p>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    
    
    <xsl:template match="xh:head" mode="xh"/>
    
    <xsl:template match="xh:body" mode="xh">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="xh:span" mode="xh">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <!--ADD RESP STMTS-->
    <xsl:template match="titleStmt[not(respStmt)]" mode="tei">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <respStmt>
                <resp>Transcriber</resp>
                <xsl:copy-of select="wea:getName($transcriberId)"/>
            </respStmt>
            <respStmt>
                <resp>Proofreader</resp>
                <xsl:copy-of select="wea:getName($proofreaderId)"/>
            </respStmt>
            <respStmt>
                <resp>Encoder</resp>
                <xsl:copy-of select="wea:getName($encoderId)"/>
            </respStmt>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="revisionDesc" mode="tei">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <change who="pers:{$yourId}" when="{format-date(current-date(),'[Y0001]-[M01]-[D01]')}" status="inProgress">Downloaded document from Google Drive and converted to TEI.</change>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="revisionDesc/@status" mode="tei">
        <xsl:attribute name="status" select="'inProgress'"/>
    </xsl:template>
    
    <xsl:function name="wea:getName">
        <xsl:param name="id"/>
        <name ref="pers:{$id}"><xsl:value-of select="$people//person[@xml:id=$id]/persName/reg"/></name>
    </xsl:function>
    
    <xsl:template match="@*|node()" mode="tei pass2" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>