<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: January 5, 2018</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet contains all of the templates for creating the "appendix" content (bibliographies, editorial notes, lists of people, et cetera). Many of these templates end up calling the templates in mode="tei," which are in the main templates module.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template match="note[@type='editorial']" mode="appendix">
        <xsl:variable name="noteId" select="wea:getNoteId(.)"/>
        <xsl:variable name="noteNum" select="tokenize($noteId,'_')[last()]"/>
        <div>

            <xsl:call-template name="processAtts">
                <xsl:with-param name="id" select="$noteId"/>
            </xsl:call-template>
            <a class="returnToNote" href="#noteMarker_{$noteNum}" title="Return to note {$noteNum}."><xsl:value-of select="$noteNum"/></a>
            <div>
                <xsl:apply-templates mode="tei"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="createAppendix">
        <div id="appendix">
            <xsl:call-template name="createNotes"/>
            <xsl:apply-templates select="ancestor::TEI/text[@type='standoff']" mode="appendix"/>
        </div>
    </xsl:template>
    
    <xsl:template match="listPerson" mode="appendix">
        <div>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="id" select="'personography'"/>
            </xsl:call-template>
            <h2>People Mentioned</h2>
            <xsl:apply-templates select="person" mode="tei"/>
        </div>
    </xsl:template>
    
    <xsl:template match="listOrg" mode="appendix">
        <div>
            <xsl:call-template name="processAtts">
                <xsl:with-param name="id" select="'organizations'"/>
            </xsl:call-template>
            <h2>Organizations Mentioned</h2>
            <xsl:apply-templates select="org" mode="tei"/>
        </div>
    </xsl:template>
    
    <xsl:template name="createNotes">
        <xsl:if test="//note[@type='editorial']">
            <div id="notes">
                <h2>Notes</h2>
                <xsl:apply-templates select="//note[@type='editorial']" mode="appendix"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="createPopup">
        <div id="popup" class="hidden">
            <div id="popup_closer">X</div>
            <div id="popup_content"/>
        </div>
    </xsl:template>
    
    <!--A simple template to create an empty div that is
        the overlay-->
    <xsl:template name="createOverlay">
        <div id="overlay" class="hidden"/>
    </xsl:template>
    
    
    
</xsl:stylesheet>