<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>Date: August 2020</xd:p>
            <xd:p>This stylesheet is a utility identity transformation to remove primary contributors from RespStmts.
                In the WEA project, respStmts are reserved for secondary people whereas the sourceDesc describes the primary contributors.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:variable name="allDocs" select="collection('../../data/texts?select=*.xml')"/>
    
    <!--Identity-->
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template name="go">
        <xsl:for-each select="$allDocs[descendant::resp[matches(.,'Author|Illustrator')]]">
            <xsl:result-document href="remove_primary_resps_tmp/{//TEI/@xml:id}.xml" method="xml" indent="yes" suppress-indentation="text body p foreign note title ref name">
                <xsl:message>Processing <xsl:value-of select="//TEI/@xml:id"/></xsl:message>
                <xsl:apply-templates select="."/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="respStmt">
        <xsl:choose>
            <xsl:when test="matches(resp,'Author|Illustrator')">
                <xsl:message>REMOVING:
                <xsl:copy-of select="."/>
                </xsl:message>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()" mode="#current"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="revisionDesc/change[1]">
        <change who="pers:JT1" when="2020-08-15" status="{../@status}">Removed primary source people from <gi>respStmt</gi> using XSLT.</change>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    
    
    
    
</xsl:stylesheet>