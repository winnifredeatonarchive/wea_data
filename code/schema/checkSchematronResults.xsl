<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:hcmc="http://hcmc.uvic.ca/ns"
    xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:schold="http://www.ascc.net/xml/schematron"
    xmlns:iso="http://purl.oclc.org/dsdl/schematron"
    xmlns:lemdo="http://hcmc.uvic.ca/lemdo/ns"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Source file created on:</xd:b> Feb 21, 2018</xd:p>
            <xd:p><xd:b>Copied over and modified from the Keats project by jtakeda on May 6, 2018.</xd:b></xd:p>
            <xd:p><xd:b>Author:</xd:b> mholmes for the Keats project; jtakeda for LEMDO.</xd:p>
            <xd:p>This file is designed to process the results output from 
                a Schematron process; the output is in Schematron Validation
                Report Language (SVRL). We're only really interested in finding
                straight-up errors, and terminating with a message so that the
                site build process fails.</xd:p>
            <xd:p>This file deviates from the originally slight as it expects a collection,
                not individual documents. We do this for the case that a collection has more than
                one document that contain errors. Rather than failing at the first instance
                of an error, this code reports all of the errors at once in the final message.</xd:p>
        </xd:desc>
        <xd:param name="tempDir">
            <xd:p>The temporary directory that contains the SVRL files.</xd:p>
        </xd:param>
    </xd:doc>
    
    <!--Temporary directory-->
    <xsl:param name="tempDir"/>
    
    <!--Output in text-->
    <xsl:output method="text" encoding="UTF-8" indent="no"/>
    
    <!--Get the collection of documents to validate-->
    <xsl:variable name="docsToValidate" select="collection(concat($tempDir,'?select=*.xml&amp;recurse=yes'))"/>
    
    <!--Count of all documents for fun-->
    <xsl:variable name="docCount" select="count($docsToValidate)"/>
    
    <!--All the documents that have errors-->
    <xsl:variable name="invalidDocs" select="$docsToValidate[descendant::svrl:failed-assert]"/>
    
    <!--Count of invalid documents-->
    <xsl:variable name="invalidDocsCount" select="count($invalidDocs)"/>
    
    <!--New line variable-->
    <xsl:variable name="newline" select="'&#x0a;'"/>
    
    <!--Separator-->
    <xsl:variable name="separator" select="concat($newline,'******************************************',$newline)"/>
    
    <xd:doc scope="component">
        <xd:desc>Root template to iterate through documents.</xd:desc>
    </xd:doc>
    
    <xsl:template match="/">
        
        <xsl:message>Validating <xsl:value-of select="$docCount"/> documents found in <xsl:value-of select="$tempDir"/>...</xsl:message>
        <xsl:choose>
            <xsl:when test="$invalidDocsCount = 0">
                <xsl:message>All documents valid!</xsl:message>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>Found <xsl:value-of select="$invalidDocsCount"/> invalid documents. Messages will be provided below:</xsl:message>
                <xsl:variable name="errors" as="xs:string*">
                    
                    <!--Iterate through each of the documents; we only care about the documents
            that contain a failed-assert.-->
                    <xsl:for-each select="$docsToValidate[descendant::svrl:failed-assert]">
                        
                        <!--The current document URI-->
                        <xsl:variable name="currDoc" select="document-uri(/)"/>
                        
                        <!--Get the errors-->
                        <xsl:value-of select="concat(
                            $separator,
                            $currDoc,': ', $newline,
                            string-join(for $n in descendant::svrl:failed-assert return normalize-space($n),'&#x0a;'),
                            $separator)
                            "/>
                    </xsl:for-each>
                </xsl:variable>
                
                <xsl:if test="string-length(normalize-space(string-join($errors))) gt 0">
                    <xsl:variable name="output" as="xs:string">
                        <xsl:value-of select="concat(
                            $separator,
                            'SCHEMATRON VALIDATION FAILED',
                            string-join($errors,$newline),
                            $separator)"/>
                    </xsl:variable>
                    <xsl:result-document href="{$tempDir}/results.txt">
                        <xsl:value-of select="$output"/>
                    </xsl:result-document>
                    <xsl:message terminate="yes">
                        <xsl:value-of select="$output"/>
                    </xsl:message>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <!--We store the output text as a variable-->
        
    </xsl:template>
    
    <!--   <xd:doc scope="component">
        <xd:desc>This is the important template, which catches an
            error, reports it and fails the process.</xd:desc>
        <xd:param name="currDoc">The current document URI.</xd:param>
    </xd:doc>
    <xsl:template match="svrl:failed-assert" mode="#all">
        <xsl:param name="currDoc" tunnel="yes"/>
        <xsl:variable name="outputMessage" select="normalize-space(svrl:text)"/>
        <xsl:value-of select="$outputMessage"/>
    </xsl:template>-->
    
    
    
    <!--<xd:doc scope="component">
        <xd:desc>This is the default template, which does nothing
            except allow processing to continue.</xd:desc>
    </xd:doc>
    <xsl:template match="@* | node()" priority="-1" mode="#all">
        <xsl:apply-templates select="@* | node()" mode="#current"/>
    </xsl:template>-->
    
    
    
</xsl:stylesheet>