<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:l="http://hcmc.uvic.ca/lemdo/ns"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:teix="http://www.tei-c.org/ns/Examples"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> March 30, 2019</xd:p>
            <xd:p><xd:b>Author:</xd:b>jtakeda</xd:p>
            <xd:p>This code originates from the LEMDO project and was also written by jtakeda.</xd:p>
            <xd:p>This module contains the templates for processing
                egXML nodes in the TEI Examples namespace. The contents of these nodes
                are serialized and displayed in the HTML as example code blocks.</xd:p>
            <xd:p>We do not use the Saxon function:esrialize for a number of reasons, mainly since
                we want to output the nodes with the elements, attributes, and comments highlighted with
                different colours. As well, we are able to better control the spacing and indentation using
                our own templates.</xd:p>
            <xd:p>Most of the work happens in the text() template, which attempts to normalize the indentation
                to preserve the intentional whitespace.</xd:p>
            <xd:p>This file is based off of mholmes' previous work for The Map of Early Modern London, particularly
                the analyze-string functions.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    
    
    <!--**************************************************************
       *                                                            * 
       *                     Templates: tei                         *
       *                                                            *
       **************************************************************-->
    
    <!--Let's deal with the simplest case-->
    <xd:doc>
        <xd:desc>This template matches the outermost egXML element that's in the regular flow
            of a TEI document.</xd:desc>
    </xd:doc>
    <xsl:template match="teix:egXML[not(ancestor::teix:egXML)]" mode="tei">
        <!--The initial space variable is the calculated maximum space that can be trimmmed
            from the leftmost side of all components of the egXML block.-->
        <xsl:variable name="initialSpace" select="wea:returnInitialSpace(.)" as="xs:integer"/>
        
        <!--If there is a validity status on the egXML, then add that as a class-->
        <div class="egXML {if (@valid) then @valid else 'true'}">
            <xsl:apply-templates mode="eg">
                <!--Pass the initialSpace as a tunneled parameter-->
                <xsl:with-param name="initialSpace" tunnel="yes" select="$initialSpace" as="xs:integer"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    
    <!--**************************************************************
       *                                                            * 
       *                     Templates: eg                         *
       *                                                            *
       **************************************************************-->
    
    <xd:doc>
        <xd:desc>This template matches the descendant text elements in the egXML and attempts to rationalize and preserve
            the whitespace.</xd:desc>
        <xd:param name="initialSpace">Passed from the root template above, the initialSpace parameter
            is the maximum amount of space that can be trimmed from the leftmost side of all the nodes.
            In other words, it is the number of spaces that would make at least one element have no preceding spaces.</xd:param>
    </xd:doc>
    <xsl:template match="teix:*/descendant::text()" mode="eg">
        <xsl:param name="initialSpace" tunnel="yes" as="xs:integer"/>
        <!--The context node-->
        <xsl:variable name="thisNode" select="."/>
        
        <!--The id for this node-->
        <xsl:variable name="thisNodeId" select="generate-id($thisNode)"/>
        
        <!--The id for the initial text node (which might be this one)-->
        <xsl:variable name="initialTextNode" select="ancestor::teix:egXML/generate-id(text()[1])"/>
        
        <!--THe id for the final text node (which might be this one)-->
        <xsl:variable name="finalTextNode" select="ancestor::teix:egXML/generate-id(text()[last()])"/>
        
        <!--Create a span element with class space-->
        <span class="space">
            
            <!--Analyze this string against the \r\n regex,
                    which is a safer bet for tokenize against line breaks
                    and returns-->
            <xsl:analyze-string select="." regex="[\r\n]">
                <!--If there is a linebreak of some sort-->
                <xsl:matching-substring>
                    <xsl:choose>
                        <!--Test whether this text is a direct child of the egXML; if it is, then see if it's the final
                                or intiial text node.-->
                        <!--If it is, then don't make a <br/>-->
                        <xsl:when test="$thisNode/parent::teix:egXML and ($thisNodeId = ($initialTextNode, $finalTextNode))"/>
                        
                        <!--Otherwise, make a break-->
                        <xsl:otherwise>
                            <br/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:matching-substring>
                
                <!--Now for the rest of the string-->
                <xsl:non-matching-substring>
                    
                    <!--How many spaces lead up to this thing?-->
                    <xsl:variable name="spacesCount" select="wea:countLeadingSpace(.)"/>
                    
                    <!--How many spaces can we indent by?-->
                    <xsl:variable name="spacesToInsert" as="xs:integer">
                        <xsl:choose>
                            <!--If this text's leading spaces is greater than the initial space
                                    (this is what happens in most cases for nested elements-->
                            <xsl:when test="$spacesCount gt $initialSpace">
                                <!--Then the number of spaces to insert is equal to the number of leading
                                        spaces minus the initial space-->
                                <xsl:value-of select="$spacesCount - $initialSpace"/>
                            </xsl:when>
                            <!--If this text's leading spaces is the same as initial space (likely
                                    these are sibling elements)-->
                            <xsl:when test="$spacesCount = $initialSpace">
                                <!--Then don't add spaces-->
                                <xsl:value-of select="0"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!--Otherwise, there are somehow fewer spaces than what was declared
                                        at the start; that happens if someone is trying to demonstrate
                                        some oddly spaced feature-->
                                <xsl:value-of select="$spacesCount"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <!--Now iterate $spacesToInsert amount of times and output that many &nbsp; characters (which are equivalent
                            to $#160;-->
                    <xsl:for-each select="if ($spacesToInsert gt 0) then (1 to $spacesToInsert) else ()">
                        <xsl:text>&#160;</xsl:text>
                    </xsl:for-each>
                    <!--Now analyze the non-matching string from above
                        (which is still prefaced with [ \t] characters)-->
                    <xsl:analyze-string select="." regex="^\s\s+">
                        <!--And trim the leading whitespace-->
                        <xsl:non-matching-substring>
                            <!--And now change all space characters to &nbsp
                                    to be sure that whitespace is retained-->
                            <xsl:value-of select="replace(.,'[\t ]','&#160;')"/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </span>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>This template creates an element tag and its attributes. Note that it does not
            bring in namespaces.</xd:desc>
    </xd:doc>
    <xsl:template match="*" mode="eg">
        <!--The start tag-->
        <span class="xmlTag">&lt;<xsl:value-of select="name()"/></span>
        <!--Attributes-->
        <xsl:for-each select="@*">
            <span class="xmlAttName"><xsl:text> </xsl:text><xsl:value-of select="name()"/>=</span>
            <span class="xmlAttVal">"<xsl:value-of select="."/>"</span>
        </xsl:for-each>
        <!--Fork on whether or not the element is self closing-->
        <xsl:choose>
            <!--If it, then close the tag-->
            <xsl:when test="wea:isSelfClosed(.)">
                <span class="xmlTag">/&gt;</span>
            </xsl:when>
            <xsl:otherwise>
                <!--Otherwise, create the end of the start tag-->
                <span class="xmlTag">&gt;</span>
                <!--Call templates-->
                <xsl:apply-templates select="* | text() | comment() | processing-instruction()" mode="#current"/>
                <!--And close the tag-->
                <span class="xmlTag">&lt;/<xsl:value-of select="name()"/>&gt;</span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xd:doc>
        <xd:desc>Simple template to escape XML comments.</xd:desc>
    </xd:doc>
    <xsl:template match="comment()" mode="eg">
        <span class="xmlComment">&lt;!-- <xsl:value-of select="."/> --&gt;</span>
    </xsl:template>
    
    
    <xd:doc>
        <xd:desc>Simple template to escape XML processing instructions</xd:desc>
    </xd:doc>
    <xsl:template match="teix:*//processing-instruction()" mode="eg">
        <span class="xmlProcessingInstruction">&lt;?<xsl:value-of select="name()"/><xsl:text>&#160;</xsl:text><xsl:value-of select="."/>?&gt;</span>
    </xsl:template>
    
    
    
    <!--**************************************************************
       *                                                            * 
       *                     Functions                              *
       *                                                            *
       **************************************************************-->
    
    
    <!--Special functions for egXML processing-->
    <xd:doc>
        <xd:desc>This function takes in an egXML node and calculates the maximum
            amount of space that can be trimmed from the leading whitespace of any node
            in the egXML.</xd:desc>
        <xd:param name="egNode">The egXML element</xd:param>
    </xd:doc>
    <xsl:function name="wea:returnInitialSpace" as="xs:integer">
        <xsl:param name="egNode" as="element(teix:egXML)"/>
        <xsl:variable name="lastLines" as="xs:string*">
            <!--Iterate through all child text elements-->
            <xsl:for-each select="$egNode/text()">
                <!--So long as it doesn't equal the last one (which gives a bad result. For example:
                    <egXML>
                        <lb/>
                     </egXML>
                While the leading space before the <lb/> is x spaces, the leading space before the closing
                tag for the <egXML> is approximately x-4.-->
                <xsl:if test="position() ne last()">
                    <!--Tokenize against linebreaks-->
                    <xsl:variable name="tokens" select="tokenize(.,'(\r\n|\r|\n)')"/>
                    <!--Now return the last token (we don't care about the leading ones)-->
                    <xsl:value-of select="$tokens[last()]"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <!--For all of the ls in $lastLines return the count of the leading spaces (see function below)-->
        <xsl:variable name="spaces" select="for $l in $lastLines return wea:countLeadingSpace($l)" as="xs:integer*"/>
        
        <!--If there are spaces (i.e. there were text child of the egXML, then find the minimum number
            of spaces; otherwise, just return 0-->
        <xsl:value-of select="if (not(empty($spaces))) then min($spaces) else 0"/>
    </xsl:function>
    
    
    <xd:doc>
        <xd:desc>This function analyzes a string, returns the initial sequence of
            leading whitespace, and then provides the character count of that whitespace. Note
            that by whitespace here, we mean spaces and tabs and not the generic whitespace '\s',
            which is equivalent to [\n\r\t ].</xd:desc>
        <xd:param name="line">The line (as a string) to analyze.</xd:param>
    </xd:doc>
    <xsl:function name="wea:countLeadingSpace" as="xs:integer">
        <xsl:param name="line" as="xs:string"/>
        <xsl:variable name="leading">
            <!--Regex: at the beginning of the string, there is
                a sequence of one or more space or tab characters. Following that
                the string either ends OR there's something else that isn't a word character
                (i.e. ' hello' would not be matched here, since we don't want to use that space-->
            <xsl:analyze-string regex="^([ \t]+)($|[^\w])" select="$line">
                <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:value-of select="string-length($leading)"/>
    </xsl:function>
    
    
    <xd:doc>
        <xd:desc>A simple utility function, derived from mholmes' wea:shouldBeSelfClosed function,
            takes in a tag and returns a boolean value whether or not the element should be
            self closed or not. Note that this function is not as sophisticated as mholmes'; it assumes
            that if you use an element and you do not put any text or comments within it, it should
            be self-closing.</xd:desc>
        <xd:param name="tag">The element to analyze.</xd:param>
    </xd:doc>
    <xsl:function name="wea:isSelfClosed" as="xs:boolean">
        <xsl:param name="tag"/>
        <xsl:value-of select="string($tag) = '' and not($tag/child::*) and not($tag/child::comment())"/>
    </xsl:function>
    
</xsl:stylesheet>