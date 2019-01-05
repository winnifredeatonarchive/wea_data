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
    
    <xsl:template match="@id">
        <xsl:attribute name="xml:id" select="if (parent::TEI.2) then $id else concat(.,'_',$id)"/>
    </xsl:template>
    
    <xsl:template match="@lang">
        <xsl:attribute name="xml:lang" select="."/>
    </xsl:template>
    
   
   <xsl:template match="respStmt[count(resp) gt 1]">
       <xsl:for-each-group select="*" group-ending-with="name">
           <respStmt>
               <xsl:apply-templates select="current-group()"/>
           </respStmt>
       </xsl:for-each-group>
   </xsl:template>
   
    <xsl:template match="date/@value">
        <xsl:attribute name="when" select="."/>
    </xsl:template>
    
    <xsl:template match="*[matches(local-name(.),'^div\d+$')]">
        <div>
            <xsl:apply-templates select="@*|node()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="*[matches(local-name(.),'^div\d+$')]/@id | text/@id | body/@id"/>
    
    
    <xsl:template match="availability/@status">
        <xsl:attribute name="status">unknown</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="revisionDesc[change[respStmt]]">
        <revisionDesc>
            <xsl:apply-templates select="@*"/>
            <change when="{format-date(current-date(),'[Y0001]-[M01]-[D01]')}">Joey Takeda: Converted document from P4 (old <att>xml:id</att>=<xsl:value-of select="$oldId"/>; old filename=<xsl:value-of select="tokenize($uri,'/')[last()]"/>.</change>
            <xsl:for-each select="change">
                <xsl:sort select="date/@value/." order="descending"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </revisionDesc>
    </xsl:template>
    
    <xsl:template match="change[respStmt]">
        <change>
            <xsl:attribute name="when" select="date/@value"/>
            <xsl:value-of select="respStmt/name"/>: <xsl:value-of select="respStmt/resp"/>. <xsl:value-of select="item"/>
        </change>
    </xsl:template>
    
    <xsl:template match="langUsage/language/@id">
            <xsl:attribute name="ident"><xsl:value-of select="."/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="language/@usage">
        <xsl:attribute name="usage"><xsl:value-of select="count(parent::language/preceding-sibling::language)+1"/></xsl:attribute>
    </xsl:template>
    
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
    
    <xsl:template match="seriesStmt/p">
        <title><xsl:apply-templates/></title>
    </xsl:template>
    
    <xsl:template match="publicationStmt[count(*)=1][idno[@type='callNo']]/idno">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="change/respStmt | change/date | change/item"/>
    
    <!--Delete old dlps processing instructions-->
    <xsl:template match="processing-instruction('dlps')"/>
    
    <xsl:template match="p/text()">
        <xsl:choose>
            <xsl:when test="empty(preceding-sibling::node()) and matches(.,'^\s+')">
                <xsl:analyze-string select="." regex="^\s+(.+)$">
                    <xsl:matching-substring>
                        <xsl:value-of select="regex-group(1)"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
 
    <!--Have to deal with janus elements-->
    
    <xsl:template match="orig[@reg]">
        <choice>
            <orig><xsl:apply-templates/></orig>
            <reg><xsl:value-of select="@reg"/></reg>
        </choice>
    </xsl:template>
    
    <xsl:template match="*" priority="-1">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="node()" priority="-2">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*" priority="-1">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <!--Get rid of these-->
    <xsl:template match="teiHeader/@type | teiHeader/@creator"/>
        
    

    
</xsl:stylesheet>