<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/winnifredeatonarchive"
    version="3.0">
    
    
    <xsl:include href="../sch/weaQuickFixTemplates.xsl"/>
    <!--Default parameters-->
    
    <xsl:param name="documentId"/>
    <xsl:param name="yourId"/>
    <xsl:param name="encoderId"/>
    <xsl:param name="proofreaderId"/>
    <xsl:param name="transcriberId"/>
    <xsl:param name="genreId"/>
    <xsl:param name="exhibitId"/>
    <xsl:param name="docTypeId"/>

    
    <xsl:variable name="xhDocs" select="collection(concat('../temp/',$documentId,'_files/GoogleDoc/?select=*.xhtml'))"/>
    <xsl:variable name="xhtmlDoc" select="for $x in $xhDocs return if (not(matches(document-uri($x),'/nav.xhtml'))) then $x else ()" as="document-node()+"/>
    <xsl:variable name="teiDoc" select="document(concat('../texts/',$documentId,'.xml'))" as="document-node()*"/>
    <xsl:variable name="people" select="document('../people.xml')" as="document-node()"/>
    <xsl:variable name="tax" select="document('../taxonomies.xml')" as="document-node()"/>
    
    <xsl:output indent="yes" suppress-indentation="p hi seg q"/>
    
    <xsl:template name="createDoc">
        <xsl:message>Creating <xsl:value-of select="resolve-uri(concat('../temp/',$documentId,'.xml'))"/></xsl:message>
        <xsl:call-template name="check"/>
        <xsl:variable name="pass1">
            <xsl:apply-templates select="$teiDoc" mode="tei"/>
        </xsl:variable>
        <xsl:result-document href="{concat('temp/',$documentId,'.xml')}">
           <xsl:apply-templates mode="pass2" select="$pass1"/>
        </xsl:result-document>
     
    </xsl:template>
    
    
    <!--This template is for checking that everything actually is input the correct way-->
    <xsl:template name="check">
        <!--First, let's chect that the documents exist-->
        
        <xsl:if test="empty($xhtmlDoc)">
            <xsl:message terminate="yes">ERROR: Google Doc not available. Check the URL and make sure the document is sharable.</xsl:message>
        </xsl:if>
        
        <xsl:if test="empty($teiDoc)">
            <xsl:message terminate="yes">ERROR: TEI document not avaiable. Make sure you've typed the @xml:id correctly.</xsl:message>
        </xsl:if>
        
        
        <xsl:if test="normalize-space(string-join($teiDoc//body,''))">
            <xsl:message terminate="yes">ERROR: <xsl:value-of select="$documentId"/> has content that would be overwritten. Check to make sure that this is the document you want.</xsl:message>
        </xsl:if>
        
        <xsl:for-each select="distinct-values(($yourId,$encoderId,$proofreaderId,$transcriberId))">
            <xsl:variable name="currId" select="."/>
            <xsl:if test="empty($people//person[@xml:id=$currId])">
                <xsl:message terminate="yes">ERROR: Person <xsl:value-of select="$currId"/> does not exist.</xsl:message>
            </xsl:if>
        </xsl:for-each>

        
        <xsl:for-each select="distinct-values(($genreId, $exhibitId, $docTypeId))">
            <xsl:variable name="currVal" select="."/>
            <xsl:if test="empty($tax//category[@xml:id=$currVal])">
                <xsl:message terminate="yes">ERROR: Document type category <xsl:value-of select="$currVal"/> does not exist.</xsl:message>
            </xsl:if>
        </xsl:for-each>
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
    
    <xsl:template match="textClass" mode="tei">
        <xsl:copy>
            <catRef scheme="wdt:genre" target="wdt:{$genreId}"/>
            <catRef scheme="wdt:exhibit" target="wdt:{$exhibitId}"/>
            <catRef scheme="wdt:docType" target="wdt:{$docTypeId}"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:function name="wea:getClass">
        <xsl:param name="id"/>
        <xsl:variable name="thisCat" select="$tax//category[@xml:id=$id]"/>
        <catRef target="wdt:{$id}" scheme="wdt:{$thisCat/ancestor::taxonomy/@xml:id}"/>
    </xsl:function>
    
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