<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns:map="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    
    <xsl:variable name="biblDoc" select="document('../bibliography.xml')"/>
    <xsl:variable name="texts" select="collection('../texts?select=*.xml')"/>
    
    
    <xsl:variable name="usedBibls" select="$texts//sourceDesc/bibl/replace(@copyOf,':','')" as="xs:string*"/>
    
    <xsl:variable name="textIdMap" as="map(xs:string,xs:integer+)">
        <xsl:map>
            <xsl:for-each-group select="$texts//TEI/@xml:id" group-by="replace(.,'\d+$','')">
                <xsl:map-entry key="current-grouping-key()" select="for $n in current-group() return xs:integer(substring-after(xs:string($n),current-grouping-key()))"/>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:variable>
    
    <xsl:template name="go">
        <xsl:variable name="newBibls" select="$biblDoc//div[@xml:id='bibliography_we']/descendant::bibl[not(@xml:id = $usedBibls)]"/>
        <xsl:message>Found <xsl:value-of select="count($newBibls)"/> shells to create....</xsl:message>
        <xsl:for-each-group select="$newBibls" group-by="parent::listBibl/@xml:id">
            <xsl:variable name="nums" select="$textIdMap(xs:string(current-grouping-key()))"/>
            <xsl:variable name="max" select="if (exists($nums)) then max($nums) else 0" as="xs:integer"/>
            <xsl:iterate select="current-group()">
                <xsl:param name="i" select="1"/>
                <xsl:variable name="id" select="current-grouping-key() || ($max + $i)"/>
                <xsl:message>Creating <xsl:value-of select="$id"/> from <xsl:value-of select="@xml:id"/></xsl:message>
                <xsl:result-document href="tmp/{$id}.xml" method="xml" indent="yes">
                    <xsl:processing-instruction name="xml-model">href="../sch/wea.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
                    <xsl:processing-instruction name="xml-model">href="../sch/wea.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
                    <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$id}">
                        <teiHeader>
                            <fileDesc>
                                <titleStmt>
                                    <title><xsl:sequence select="title[1]/node()"/></title>
                                </titleStmt>
                                <publicationStmt>
                                    <p>Publication Information</p>
                                </publicationStmt>
                                <sourceDesc>
                                    <bibl copyOf="{replace(@xml:id,'bibl','bibl:')}"/>
                                </sourceDesc>
                            </fileDesc>
                            <profileDesc>
                                <textClass>
                                </textClass>
                            </profileDesc>
                            <revisionDesc status="empty">
                            </revisionDesc>
                        </teiHeader>
                        <text>
                            <body>
                                <div>
                                    <gap reason="noTranscriptionAvailable"/>
                                </div>
                            </body>
                        </text>
                    </TEI>
                </xsl:result-document>
                <xsl:next-iteration>
                    <xsl:with-param name="i" select="$i + 1"/>
                </xsl:next-iteration>
            </xsl:iterate>
        </xsl:for-each-group>
    </xsl:template>
    
</xsl:stylesheet>