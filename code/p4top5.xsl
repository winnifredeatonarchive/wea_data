<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <!--This stylesheet takes the P4 files for the WEA project
        and converts them to P5. We also process the files to clean
        them up and make the encoding a bit more sensible-->
    
    <xsl:variable name="uri" select="document-uri(.)"/>
    <xsl:variable name="oldId" select="//TEI.2/@id"/>
    
    <xsl:variable name="id" select="replace(substring-before(tokenize($uri,'/')[last()],'.xml'),'(\s|%20)+','_')"/>
    
    
    <!--Root template-->
    <xsl:template match="TEI.2">
        <xsl:message>Converting <xsl:value-of select="@id"/> to <xsl:value-of select="$id"/></xsl:message>
        <xsl:result-document href="{$id}.xml" method="xml" indent="yes">
            <TEI>
                <xsl:apply-templates select="@*|node()"/>
            </TEI>
        </xsl:result-document>
       
    </xsl:template>
    
    <!--Some standard templates-->
    
    <!--Convert @id to @xml:id-->
    <xsl:template match="@id">
        <xsl:attribute name="xml:id" select="if (parent::TEI.2) then $id else concat(.,'_',$id)"/>
    </xsl:template>
    
    <!--And similarly lang-->
    <xsl:template match="@lang">
        <xsl:attribute name="xml:lang" select="."/>
    </xsl:template>
    
   <!--This is slightly tricker; the respStmts had multiply nested resp/name combos
       that needed to be split-->
   <xsl:template match="respStmt[count(resp) gt 1]">
       <xsl:for-each-group select="*" group-ending-with="name">
           <respStmt>
               <xsl:apply-templates select="current-group()"/>
           </respStmt>
       </xsl:for-each-group>
       <!--Add myself-->
       <respStmt>
           <resp>Conversion to P5 conformant markup:</resp>
           <name>Joey Takeda</name>
       </respStmt>
   </xsl:template>
   
   <!--Switch @value to @when-->
    <xsl:template match="date/@value">
        <xsl:attribute name="when" select="."/>
    </xsl:template>
    
    <!--Begone, numbered divs!-->
    <xsl:template match="*[matches(local-name(.),'^div\d+$')]">
        <div>
            <xsl:apply-templates select="@*|node()"/>
        </div>
    </xsl:template>
    
    <!--Get rid of unnecessary div ids-->
    <xsl:template match="*[matches(local-name(.),'^div\d+$')]/@id | text/@id | body/@id"/>
    
    
    <!--Change the status value of available to unknown-->
    <xsl:template match="availability/@status">
        <xsl:attribute name="status">unknown</xsl:attribute>
    </xsl:template>
    
    <!--Have to fix the completely borked revisionDesc-->
    <xsl:template match="revisionDesc[change[respStmt]]">
        <revisionDesc>
            <xsl:apply-templates select="@*"/>
            <!--Add myself and add some extra info for backwards compatibility-->
            <change when="{format-date(current-date(),'[Y0001]-[M01]-[D01]')}">Joey Takeda: Converted document from P4 (old <att>xml:id</att>=<xsl:value-of select="$oldId"/>; old filename=<xsl:value-of select="tokenize($uri,'/')[last()]"/>.</change>
            <!--Now apply templates to change and order them-->
            <xsl:for-each select="change">
                <xsl:sort select="date/@value/." order="descending"/>
                <!--And apply templates-->
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </revisionDesc>
    </xsl:template>
    
    <!--A change with a respStmt needs to be fixed, since respStmts aren't allowed-->
    <xsl:template match="change[respStmt]">
        <change>
            <xsl:attribute name="when" select="date/@value"/>
            <!--Change all the respStmt things to name resp combos.-->
            <xsl:value-of select="respStmt/name"/>: <xsl:value-of select="respStmt/resp"/>. <xsl:value-of select="item"/>
        </change>
    </xsl:template>
    
    <!--Switch language/@id to @ident (tho we probably don't even need this)-->
    <xsl:template match="langUsage/language/@id">
            <xsl:attribute name="ident"><xsl:value-of select="."/></xsl:attribute>
    </xsl:template>
    
    <!--Change usage to an integer-->
    <xsl:template match="language/@usage">
        <xsl:attribute name="usage"><xsl:value-of select="count(parent::language/preceding-sibling::language)+1"/></xsl:attribute>
    </xsl:template>
    
    <!--Now fix series stmt-->
    <xsl:template match="fileDesc/seriesStmt">
        <xsl:choose>
            <xsl:when test="preceding-sibling::seriesStmt"/>
            <xsl:otherwise>
                <seriesStmt>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="following-sibling::seriesStmt/node()"/>                
                    <xsl:apply-templates select="node()"/>
                </seriesStmt>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--And fix series stmt p-->
    <xsl:template match="seriesStmt/p">
        <title><xsl:apply-templates/></title>
    </xsl:template>
    
    <!--Have to fix publicationStmt since the content model is much stricter-->
    <xsl:template match="publicationStmt[count(*)=1][idno[@type='callNo']]/idno">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <!--Delete these things (as handled above)-->
    <xsl:template match="change/respStmt | change/date | change/item"/>
    
    <!--Delete old dlps processing instructions-->
    <xsl:template match="processing-instruction('dlps')"/>  
 
    <!--Have to deal with janus elements-->
    
    <xsl:template match="orig[@reg]">
        <choice>
            <orig><xsl:apply-templates/></orig>
            <reg><xsl:value-of select="@reg"/></reg>
        </choice>
    </xsl:template>
    
    <!--This is the easiest way to deal with namespaces-->
    <xsl:template match="*" priority="-1">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    
    <!--And then priority number 2-->
    <xsl:template match="node()" priority="-2">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--And attributes-->
    <xsl:template match="@*" priority="-1">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <!--Get rid of these-->
    <xsl:template match="teiHeader/@type | teiHeader/@creator"/>
        
    

    
</xsl:stylesheet>