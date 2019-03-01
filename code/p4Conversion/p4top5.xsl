<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    version="3.0">
    
    <!--This stylesheet takes the P4 files for the WEA project
        and converts them to P5. We also process the files to clean
        them up and make the encoding a bit more sensible-->
    
    <xsl:variable name="uri" select="document-uri(.)"/>
    <xsl:variable name="oldId" select="//TEI.2/@id"/>
    
    <xsl:variable name="id" select="replace(substring-before(tokenize($uri,'/')[last()],'.xml'),'(\s|%20)+','_')"/>
    <xsl:output method="xml" indent="yes"/>
    
    <!--Root template-->
    <xsl:template match="TEI.2">
        <xsl:message>Converting <xsl:value-of select="$uri"/> to <xsl:value-of select="$id"/></xsl:message>
    <!--    <xsl:result-document href="{$id}.xml" method="xml" indent="yes">-->
           <xsl:variable name="pass1">
               <TEI>
                   <xsl:apply-templates select="@*|node()" mode="#current"/>
               </TEI>
           </xsl:variable>
           <xsl:apply-templates select="$pass1" mode="pass2"/>
  
        <!--</xsl:result-document>-->
       
    </xsl:template>
    
    <!--Some standard templates-->
    
    <!--Convert @id to @xml:id-->
    <xsl:template match="@id" mode="pass1">
        <xsl:attribute name="xml:id" select="if (parent::TEI.2) then $id else concat(.,'_',$id)"/>
    </xsl:template>
    
    <!--And similarly lang-->
    <xsl:template match="@lang" mode="pass1">
        <xsl:attribute name="xml:lang" select="."/>
    </xsl:template>
    
   <!--This is slightly tricker; the respStmts had multiply nested resp/name combos
       that needed to be split-->
   <xsl:template match="respStmt[count(resp) gt 1]" mode="pass1">
       <xsl:for-each-group select="*" group-ending-with="name">
           <respStmt>
               <xsl:apply-templates select="current-group()" mode="#current"/>
           </respStmt>
       </xsl:for-each-group>
       <!--Add myself-->
       <respStmt>
           <resp>Conversion to P5 conformant markup:</resp>
           <name>Joey Takeda</name>
       </respStmt>
   </xsl:template>
    
    <!--To retain the structural information from the Google Drive folders, we add a quick text class-->
  
   
   <!--Switch @value to @when-->
    <xsl:template match="date/@value" mode="pass1">
        <xsl:attribute name="when" select="."/>
    </xsl:template>
    
    <!--Begone, numbered divs!-->
    <xsl:template match="*[matches(local-name(.),'^div\d+$')]" mode="pass1">
        <div>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </div>
    </xsl:template>
    
    <!--Get rid of unnecessary div ids-->
    <xsl:template match="*[matches(local-name(.),'^div\d+$')]/@id | text/@id | body/@id" mode="pass1"/>
    
    
    <!--Change the status value of available to unknown-->
    <xsl:template match="availability/@status" mode="pass1">
        <xsl:attribute name="status">unknown</xsl:attribute>
    </xsl:template>
    
    <!--Have to fix the completely borked revisionDesc-->
    <xsl:template match="revisionDesc[change[respStmt]]" mode="pass1">
        <revisionDesc>
            <xsl:apply-templates select="@*" mode="#current"/>
            <!--Add myself and add some extra info for backwards compatibility-->
            <change when="{format-date(current-date(),'[Y0001]-[M01]-[D01]')}">Joey Takeda: Converted document from P4 (old <att>xml:id</att>: <xsl:value-of select="$oldId"/>. Old filename: <xsl:value-of select="tokenize($uri,'/')[last()]"/>.)</change>
            <!--Now apply templates to change and order them-->
            <xsl:for-each select="change">
                <xsl:sort select="date/@value/." order="descending"/>
                <!--And apply templates-->
                <xsl:apply-templates select="." mode="#current"/>
            </xsl:for-each>
        </revisionDesc>
    </xsl:template>
    
    <!--Delete lb elements-->
    <xsl:template match="lb" mode="pass1"/>
    
    
    
    <!--A change with a respStmt needs to be fixed, since respStmts aren't allowed-->
    <xsl:template match="change[respStmt]" mode="pass1">
        <change>
            <xsl:attribute name="when" select="date/@value"/>
            <!--Change all the respStmt things to name resp combos.-->
            <xsl:value-of select="respStmt/name"/>: <xsl:value-of select="respStmt/resp"/>. <xsl:value-of select="item"/>
        </change>
    </xsl:template>
    
    
    <xsl:template match="sourceDesc" mode="pass1">
        <sourceDesc>
            <bibl/>
            <xsl:comment>
                <xsl:apply-templates mode="#current"/>
            </xsl:comment>
        </sourceDesc>
    </xsl:template>
    
    
    <!--Delete for now-->
    <xsl:template match="encodingDesc" mode="pass1"/>
    
    <xsl:template match="publicationStmt" mode="pass1">
        <publicationStmt>
            <p>Publication information</p>
            <xsl:comment>
                <xsl:copy-of select="node()"/>
            </xsl:comment>
        </publicationStmt>
    </xsl:template>
    
    
    <xsl:template match="*[matches(local-name(),'div\d+')]/@type" mode="pass1"/>
    
    <xsl:template match="profileDesc" mode="pass1">
       <profileDesc>
           <textClass>
               <!--Now create the catRefs-->
               <catRef scheme="wdt:docType"
                   target="wdt:docPrimarySourcePublished"/>
               <catRef scheme="wdt:category"
                   target="wdt:cat{translate(wea:cleanLoc(tokenize(substring-after($uri,'p4Temp/'),'/')[1]),' ','')}"/>
           </textClass>
           
       </profileDesc>
          
           
        
    </xsl:template>
    
    
    <!--Delete series statement-->
    <xsl:template match="fileDesc/seriesStmt" mode="pass1"/>
    
    
    <!--And fix series stmt p-->
    <xsl:template match="seriesStmt/p" mode="pass1">
        <title><xsl:apply-templates mode="#current"/></title>
    </xsl:template>
    
    <!--Have to fix publicationStmt since the content model is much stricter-->
    <xsl:template match="publicationStmt[count(*)=1][idno[@type='callNo']]/idno" mode="pass1">
        <p><xsl:apply-templates mode="#current"/></p>
    </xsl:template>
    
    <!--Delete these things (as handled above)-->
    <xsl:template match="change/respStmt | change/date | change/item" mode="pass1"/>
    
    <!--Delete old dlps processing instructions-->
    <xsl:template match="processing-instruction('dlps')" mode="pass1"/>  
 
    <!--Have to deal with janus elements-->
    
    <xsl:template match="orig[@reg][pb]" mode="pass1">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="orig[pb]/text()[following-sibling::pb]" mode="pass1">
        <xsl:analyze-string regex="-" select=".">
            <xsl:matching-substring>
                <pc force="weak">-</pc>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <!--We need to embed notes-->
    
    <xsl:template match="ref" mode="pass1">
        <xsl:variable name="thisTarg" select="@target"/>
        <xsl:variable name="thisNote" select="ancestor::TEI.2//note[@id=$thisTarg]"/>
        <note type="editorial"><xsl:apply-templates select="$thisNote/p" mode="#current"/></note>
        
    </xsl:template>
    
    <xsl:template match="note/p" mode="pass1">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
   
    <!--Just delete the note since we deal wiht it-->
    <xsl:template match="note[@id] | note/seg" mode="pass1"/>
    
    <!--Get rid of unnecessary sorting title-->
    <xsl:template match="title[@type='sort']" mode="pass1"/>
    
    <!--No longer need extent-->
    <xsl:template match="extent" mode="pass1"/>
    
    <!--We won't deal with bad spacing this way just yet; we'll likely have another clean up transformation-->
    
    <xsl:template match="p[matches(text()[1],'^\s+')]/text()[1]" mode="pass1">
        <xsl:value-of select="replace(.,'^\s+','')"/>
    </xsl:template>
    
    <!--This is the easiest way to deal with namespaces-->
    <xsl:template match="*" priority="-1" mode="pass1">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <!--And then priority number 2-->
    <xsl:template match="node()" priority="-2" mode="pass1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <!--And attributes-->
    <xsl:template match="@*" priority="-1" mode="pass1">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <!--Get rid of these-->
    <xsl:template match="teiHeader/@type | teiHeader/@creator" mode="pass1"/>
        
    <!--FUNCTIONS-->
    
    <!--A small utility fn to clean up the "location"
        identifier found within the directory name of the Google Drive-->
    <xsl:function name="wea:cleanLoc">
        <xsl:param name="in"/>
        <xsl:variable name="tokens" select="tokenize($in,'\s+')"/>
        <xsl:variable name="cleaned" select="for $n in $tokens return concat(upper-case(substring($n,1,1)),lower-case(substring($n,2,string-length($n))))"/>
        <xsl:value-of select="string-join($cleaned,' ')"/>
    </xsl:function>

    
</xsl:stylesheet>