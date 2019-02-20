<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
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
    
    
    
    <xsl:variable name="people">
        <xsl:call-template name="getPeople"/>
    </xsl:variable>
    
    <xsl:template match="TEI" mode="tei">
        <xsl:message>Processing <xsl:value-of select="@xml:id"/></xsl:message>
        <xsl:result-document href="{concat($outDir,'/',@xml:id)}.html" method="xhtml" encoding="UTF-8" indent="yes" normalization-form="NFC" exclude-result-prefixes="#all" omit-xml-declaration="yes" html-version="5.0">
            <html lang="en">
                <xsl:call-template name="processAtts"/>
                <xsl:apply-templates mode="#current"/>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!--TODO: METADATA STUFF-->
    <xsl:template match="teiHeader" mode="tei">
        <head>
            <title><xsl:value-of select="fileDesc/titleStmt/title[1]"/></title>
            <xsl:call-template name="addScripts"/>
        </head>
    </xsl:template>
    
    <xsl:template match="text" mode="tei">
        <body>
            <xsl:call-template name="processAtts"/>
            <div id="mainBody">
                <xsl:apply-templates mode="#current"/>
            </div>
            <xsl:call-template name="createAppendix"/>
        </body>
    </xsl:template>
    
    <!--Generic block level element templates-->
    <xsl:template match="body | div | p | note | lg | l | q" mode="tei">
        <div>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    

    
    <xsl:template match="head" mode="tei">
        <xsl:variable name="nestLevel" select="count(ancestor::div)+1"/>
        <xsl:element name="{concat('h',$nestLevel)}">
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <!--Generic inline-->
    <xsl:template match="hi | seg" mode="tei">
        <span>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="table" mode="tei">
        <table>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </table>
    </xsl:template>
    
    <xsl:template match="row" mode="tei">
        <tr>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </tr>
    </xsl:template>
    
    <xsl:template match="cell" mode="tei">
        <td>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </td>
    </xsl:template>
    
    <xsl:template match="supplied | gap" mode="tei">
        <span>
            <xsl:if test="@reason | @cert | @resp">
                <xsl:attribute name="title">
                    <xsl:variable name="title">
                        <xsl:if test="@reason">Reason: <xsl:value-of select="@reason"/>.</xsl:if>
                        <xsl:if test="@cert">Certainty: <xsl:value-of select="@cert"/>.</xsl:if>
                        <xsl:if test="@resp">Supplied by: <xsl:value-of select="@resp"/>.</xsl:if>
                    </xsl:variable>
                    <xsl:value-of select="string-join($title,' ')"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    
    
    <xsl:template match="ref" mode="tei">
        <a href="{@target}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </a>
    </xsl:template>
    
    <xsl:template match="pb" mode="tei">
        <hr>
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </hr>
    </xsl:template>
    
    <xsl:template match="lb" mode="tei">
        <br>
            <xsl:call-template name="processAtts"/>
        </br>
    </xsl:template>
    
    <!--Now janus elements-->
    
    <xsl:template match="choice" mode="tei">
        <span title="{normalize-space(orig)}">
            <xsl:call-template name="processAtts"/>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <xsl:template match="choice/orig" mode="tei"/>
    
    <xsl:template match="choice/reg" mode="tei">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    
    <!--NOTES-->
    
    <xsl:template match="note[@type='editorial']" mode="tei">
        <xsl:variable name="noteId" select="wea:getNoteId(.)"/>
        <xsl:variable name="noteNum" select="tokenize($noteId,'_')[last()]"/>
        <a href="#{$noteId}"  id="noteMarker_{$noteNum}" class="noteMarker" title="{normalize-space(string-join(descendant::text(),''))}"><xsl:value-of select="$noteNum"/></a>
    </xsl:template>
    
    
    <xsl:template match="note[@type='editorial']" mode="appendix">
        <xsl:variable name="noteId" select="wea:getNoteId(.)"/>
        <xsl:variable name="noteNum" select="tokenize($noteId,'_')[last()]"/>
        <div data-notenum="{$noteNum}">
            <xsl:call-template name="processAtts">
                <xsl:with-param name="id" select="$noteId"/>
            </xsl:call-template>
            <xsl:apply-templates mode="tei"/>
            <a class="returnToNote" href="#noteMarker_{$noteNum}">↑</a>
        </div>
    </xsl:template>
    
    
    <!--Repoint the src in graphics-->
    <xsl:template match="img/@src" mode="tei">
        <xsl:attribute name="src" select="concat('graphics/',tokenize(.,'/')[last()])"/>
    </xsl:template>
    
    <xsl:template match="divGen[@type='searchBox']" mode="tei">
        <input type="text" name="search" placeholder="Search.."/>
    </xsl:template>
    
    
    <!--**************************************************************
       *                                                            * 
       *                   ATTRIBUTES                               *
       *                                                            *
       **************************************************************-->
    
    <xsl:template match="@xml:id" mode="tei">
        <xsl:attribute name="id" select="."/>
    </xsl:template>
    
    <xsl:template match="@xml:lang" mode="tei">
        <xsl:attribute name="lang" select="."/>
    </xsl:template>
    
    <xsl:template match="@rendition" mode="tei">
        <xsl:param name="classes" as="xs:string*" tunnel="yes"/>
        <xsl:variable name="theseVals" select="translate(.,'#','')"/>
        <xsl:attribute name="class" select="string-join(($classes,$theseVals),' ')"/>
    </xsl:template>
    
    <!--Just copy out style-->
    <xsl:template match="@style" mode="tei">
        <xsl:attribute name="style" select="."/>
    </xsl:template>
    
    <!--We have to handle this for now, but these should probably be @rendition-->
    <xsl:template match="@rend" mode="tei">
        <xsl:variable name="value" as="xs:string?">
            <xsl:choose>
                <xsl:when test=".='center'">text-align:center;</xsl:when>
                <xsl:when test=".='italic'">font-style: italic;</xsl:when>
                <xsl:when test=".='bold'">font-weight: bold;</xsl:when>
                <xsl:when test=".='underline'">text-decoration:underline;</xsl:when>
                <xsl:otherwise>
                    <xsl:message>Rend value <xsl:value-of select="."/> not found.</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="not(empty($value))">
            <xsl:attribute name="style" select="$value"/>
        </xsl:if>
    </xsl:template>
    
    
    <!--By default, delete all attributes from being processed
    as text.-->
    <xsl:template match="@*" priority="-1" mode="tei"/>
    
    <!--**************************************************************
       *                                                            * 
       *                    NAMED TEMPLATE                          *
       *                                                            *
       **************************************************************-->
    
    
    <!--This template is taken from the LEMDO processing model-->
    <xsl:template name="processAtts">
        <xsl:param name="classes" as="xs:string*"/>
        <xsl:param name="id" as="xs:string?"/>
        
        <!--First, create the data-el attribute-->
        <xsl:attribute name="data-el" select="local-name(.)"/>
        
        <!--Now fork and give some warnings (if desired)-->
        <xsl:choose>
            <!--If the class parameter is supplied-->
            <xsl:when test="not(empty($classes))">
                <xsl:if test="$verbose='true'">
                    <xsl:message>Added classes detected: <xsl:value-of select="$classes"/></xsl:message>
                </xsl:if>
                <xsl:choose>
                    <!--They'll be added if there's a rendition declared, so leave it-->
                    <xsl:when test="@rendition">
                        <xsl:if test="$verbose='true'">
                            <xsl:message>Classes to be added to element alongside pre-existing rendition: <xsl:value-of select="@rendition"/></xsl:message>
                        </xsl:if>
                        
                    </xsl:when>
                    <!--Otherwise, create a class attribute-->
                    <xsl:otherwise>
                        <xsl:if test="$verbose='true'">
                            <xsl:message>Classes added to create new class</xsl:message>
                        </xsl:if>
                        
                        <xsl:attribute name="class" select="$classes"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            
            <!--If the id parameter is supplied-->
            <xsl:when test="not(empty($id) or normalize-space($id)='')">
                <xsl:if test="$verbose='true'">
                    <xsl:message>Added id detected: <xsl:value-of select="$id"/></xsl:message>
                </xsl:if>
                
                <!--Break right away if the @xml:id is badly formed-->
                <xsl:if test="matches(normalize-space($id),'^\d+|:|\s+')">
                    <xsl:message terminate="yes">BAD ID: <xsl:value-of select="$id"/></xsl:message>
                </xsl:if>
                <!--If it's fine, then see if there's already an @xml:id on this object-->
                <xsl:choose>
                    <xsl:when test="not(@xml:id)">
                        <!--If there isn't an xml:id, then create an @id-->
                        <xsl:attribute name="id" select="normalize-space($id)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        
                        <xsl:message>ERROR: Element <xsl:value-of select="local-name(.)"/> already has declared id <xsl:value-of select="@xml:id"/>. Added
                            <xsl:value-of select="$id"/> will have no effect.</xsl:message>
                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
        
        <!--Iterate through each @attribute and add it as a data-att-->
        <xsl:for-each select="@*[not(local-name()=('xml:id','id','lang','xml:lang'))]">
            <xsl:attribute name="{concat('data-',local-name())}" select="."/>
        </xsl:for-each>
        
        <!--And now apply templates to the attributes in mode tei-->
        <xsl:apply-templates select="@*" mode="tei">
            <xsl:with-param name="classes" select="$classes" tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template name="addScripts">
        <link rel="stylesheet" type="text/css" href="css/wea.css"/>
        <script src="js/wea.js"/>
    </xsl:template>
    
    
    <xsl:template name="createAppendix">
        <div id="appendix">
            <xsl:call-template name="createNotes"/>
        </div>
    </xsl:template>
    
    <xsl:template name="createNotes">
        <xsl:if test="//note[@type='editorial']">
            <div id="notes">
                <h3>Notes</h3>
                <xsl:apply-templates select="//note[@type='editorial']" mode="appendix"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    
    
    
    
    
    <xsl:template name="getPeople">
        <xsl:variable name="who" select="//*/@who"/>
        <xsl:variable name="resp" select="//*/@resp"/>
        <xsl:variable name="ref" select="//*/name/@ref | //*/persName/@ref | //*/docAuthor/@ref"/>
        <xsl:variable name="distinct" select="
            distinct-values(for $q in (for $p in ($who, $resp, $ref) return tokenize($p,'\s+')) return if (starts-with($q,'pers:')) then substring-after($q,'pers:') else ())"/>
        <xsl:copy-of select="$personography//person[@xml:id=$distinct]"/>
    </xsl:template>
    <!--FUNCTIONS-->
    
    <xsl:function name="wea:getNoteId">
        <xsl:param name="note"/>
        <xsl:value-of select="concat('note_',count($note/preceding::note[@type='editorial'])+1)"/>
    </xsl:function>
    
</xsl:stylesheet>