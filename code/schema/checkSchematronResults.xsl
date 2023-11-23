<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="#all"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
    xmlns:jt="https://github.com/joeytakeda/xsl-schematron"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> 2019-10-26</xd:p>
            <xd:p><xd:b>Author:</xd:b> jtakeda</xd:p>
            <xd:p>Created by Joey Takeda (https://github.io/joeytakeda/). It is free for any purpose,
                but acknowledgement is very much appreciated.</xd:p>
            <xd:p>This code provides a validator for Schematron, which can be in the form of either an RelaxNG with embedded schematron
                , Schematron, or schematron compiled into XSLT. Note that this code does NOT validate source XML files against the RelaxNG
                contstraints of an RNG schema; it only validates against the embedded schematron.
                It relies on a collection of schematron conversion files created by James Clark.</xd:p>
            <xd:p>It MUST be run using Saxon 9.8 or later.</xd:p>
            <xd:p>The way it works is thus:</xd:p>
            <xd:ul>
                <xd:li>
                    <xd:b>Step 1:</xd:b>
                    <xd:ul>
                        <xd:li>If the file is a RelaxNG file, it converts the RelaxNG file into a Schematron file, which is then converted into an XSLT.</xd:li>
                        <xd:li>If the file is a Schematron file, it converts it into an XSLT.</xd:li>
                        <xd:li>If the file is an XSLT already, then it just leaves it.</xd:li>
                    </xd:ul>
                </xd:li>
                <xd:li>
                    <xd:b>Step 2:</xd:b>
                    <xd:ul>
                        <xd:li>Iterating over the document collection, passed as a parameter, the makeErrorsMap template 
                            uses the XSLT 3.0 function transform() to transform the source node using the compiled XSLT
                            from Step 1.</xd:li>
                        <xd:li>If there is a svrl:failed-assert in the result of the transform, it adds an entry to a xsl:map with the
                        document-uri as the key and the contents of the failed assert as the value.</xd:li>
                    </xd:ul>
                </xd:li>
                <xd:li>
                    <xd:b>Step 3:</xd:b>
                    <xd:ul>
                        <xd:li>The validate template takes the result of the map and if the map has any entries
                        (i.e. has a size greater than 0), then it iterates over the map entries and provides validation
                        error messages, terminating if specified.</xd:li>
                    </xd:ul>
                </xd:li>
              
            </xd:ul>
        </xd:desc>
        <xd:param name="rng">
            <xd:ul>
                <xd:li>Description:The path to a RelaxNG schema with embedded schematron.</xd:li>
                <xd:li>Default value: empty</xd:li>
                <xd:li>Legal value: anyURI</xd:li>
                <xd:li>Note: Cannot be combined with the <xd:ref name="sch" type="parameter">sch</xd:ref>
                or <xd:ref name="xsl" type="parameter">xsl</xd:ref> parameters.</xd:li>
            </xd:ul>
        </xd:param>
        <xd:param name="sch">
            <xd:ul>
                <xd:li>Description:The path to a schematron schema.</xd:li>
                <xd:li>Default value: empty</xd:li>
                <xd:li>Legal value: anyURI</xd:li>
                <xd:li>Note: Cannot be combined with the <xd:ref name="rng" type="parameter">rng</xd:ref>
                    or <xd:ref name="xsl" type="parameter">xsl</xd:ref> parameters.</xd:li>
            </xd:ul>
        </xd:param>
        <xd:param name="xsl">
            <xd:ul>
                <xd:li>Description:The path to an schematron schema compiled into XSLT.</xd:li>
                <xd:li>Default value: empty</xd:li>
                <xd:li>Legal value: anyURI</xd:li>
                <xd:li>Note: Cannot be combined with the <xd:ref name="rng" type="parameter">rng</xd:ref>
                    or <xd:ref name="sch" type="parameter">sch</xd:ref> parameters.</xd:li>
            </xd:ul>
        </xd:param>
        <xd:param name="file">
            <xd:ul>
                <xd:li>Description: The path to the file to validate.</xd:li>
                <xd:li>Default value: empty</xd:li>
                <xd:li>Legal value: anyURI</xd:li>
                <xd:li>Note: Cannot be combined with the <xd:ref name="dir" type="parameter">dir</xd:ref>
                    parameter.</xd:li>
            </xd:ul>
        </xd:param>
        <xd:param name="dir">
            <xd:ul>
                <xd:li>Description: The path to the directory to validate.</xd:li>
                <xd:li>Default value: empty</xd:li>
                <xd:li>Legal value: anyURI</xd:li>
                <xd:li>Note: Cannot be combined with the <xd:ref name="file" type="parameter">file</xd:ref>
                    parameter.</xd:li>
            </xd:ul>
        </xd:param>
        <xd:param name="failOnError">
            <xd:ul>
                <xd:li>Description: Whether or not the process should terminate on error.</xd:li>
                <xd:li>Default value: "yes"</xd:li>
                <xd:li>Legal values: "yes" or "no".</xd:li>
                <xd:li>Note: The name "failOnError" stems from the standard attribute name for the Ant java task.
                    This is also compiled as a static parameter, using XSLT 3.0 shadow attributes.</xd:li>
            </xd:ul>
        </xd:param>
            <xd:param name="verbose">
                <xd:ul>
                <xd:li>Description: Whether or not to produce verbose output (i.e. explaining every step of the process).</xd:li>
                <xd:li>Default value: "no"</xd:li>
                <xd:li>Legal values: string?.</xd:li>
                <xd:li>Note: While this accepts any string, it will also be "true" (i.e. produce output) if the value is one of
                    "true","yes","verbose", or 0.</xd:li>
            </xd:ul>
            </xd:param>
        <xd:param name="pattern">
            <xd:ul>
                <xd:li>Description: The glob file pattern for selecting files from the directory.</xd:li>
                <xd:li>Default value: *.xml</xd:li>
                <xd:li>Legal values: Any glob file pattern.</xd:li>
                <xd:li>Note: This parameter only has effect if combined with the <xd:ref name="dir" type="param">dir</xd:ref>
                    param.</xd:li>
            </xd:ul>
        </xd:param>
        <xd:param name="recurse">
            <xd:ul>
                <xd:li>Description: Whether or not to recurse in the directory.</xd:li>
                <xd:li>Default value: yes</xd:li>
                <xd:li>Legal values: "yes" or "no".</xd:li>
                <xd:li>Note: This parameter only has effect if combined with the <xd:ref name="dir" type="param">dir</xd:ref>
                    param.</xd:li>
            </xd:ul>
        </xd:param>
    </xd:doc>
    
    
    
    <xsl:param name="rng" as="xs:string?"/>
    <xsl:param name="sch" as="xs:string?"/>
    <xsl:param name="xsl" as="xs:string?"/>
    <xsl:param name="file" as="xs:string?"/>
    <xsl:param name="dir" as="xs:string?"/>
    <xsl:param name="failOnError" select="'yes'" static="yes" as="xs:string?"/>
    <xsl:param name="verbose" select="'no'" as="xs:string" static="yes"/>
    <xsl:param name="pattern">*.xml</xsl:param>
    <xsl:param name="recurse">yes</xsl:param>
    <xsl:param name="exclude" as="xs:string?"/>
    <xsl:output method="text"/>
    
    <xsl:variable name="useVerbose" static="yes"
        select="$verbose=('True','true','yes','y','verbose','0')"
        as="xs:boolean"/>
    
    <xsl:variable name="resolvedFile" select="resolve-uri($file)"/>
    
    <xsl:variable name="extract.rng">schematron/ExtractSchFromRNG-2.xsl</xsl:variable>
    <xsl:variable name="iso.dsdl.include">schematron/iso_dsdl_include.xsl</xsl:variable>
    <xsl:variable name="iso.abstract.expand">schematron/iso_abstract_expand.xsl</xsl:variable>
    <xsl:variable name="iso.svrl">schematron/iso_svrl_for_xslt2.xsl</xsl:variable>
    
    <xsl:variable name="resolvedDir" 
        select="if (jt:noVal($dir)) then () else resolve-uri($dir, document-uri(/))"
        as="xs:anyURI?"/>
    
    <xsl:variable name="query"
        as="xs:string" 
        select="'?select='|| $pattern || ';recurse=' || $recurse || ';on-error=ignore'"/>
    
    <xsl:variable name="collectionStr" select="$resolvedDir || $query"/>
    
    <xsl:variable name="collection"
        as="xs:anyURI*"
        select="uri-collection($collectionStr)[not(exists($exclude) and matches(.,$exclude))]"/>
    
    <xsl:variable name="docs" 
        select="if (not(jt:noVal($dir))) 
                then $collection
                else $resolvedFile" 
                as="xs:anyURI*"/>
    
   
    
    <xsl:template match="/">
        <xsl:call-template name="echoParams"/>
        <xsl:call-template name="checkParams"/>
        <xsl:call-template name="validate"/>
    </xsl:template>
    
    
    <xsl:template name="validate">
        <xsl:variable name="errors" as="map(xs:anyURI, xs:string*)">
            <xsl:call-template name="makeErrorsMap"/>
        </xsl:variable>
        <xsl:variable name="size" select="map:size($errors)"/>
        <xsl:choose>
            <xsl:when test="$size gt 0">
                <xsl:for-each select="map:keys($errors)">
                    <xsl:variable name="key" select="."/>
                    <xsl:variable name="entry" select="$errors($key)"/>
                    <xsl:for-each select="$entry">
                        <xsl:message><xsl:value-of select="$key || ': ' || ."/></xsl:message>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:message _terminate="{$failOnError}">Validation failed.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message><xsl:value-of select="count($docs)"/> document<xsl:if test="count($docs) gt 1">s</xsl:if> have been successfully validated.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>  
    </xsl:template>
    
    
    <xsl:template name="makeErrorsMap">
        <xsl:variable name="schemaXsl" select="jt:makeSchemaXsl()"/>
        <xsl:map>
            <xsl:for-each select="$docs">
                <xsl:variable name="currDoc" select="document(.)"/>
                <xsl:variable name="uri" select="."/>
                <xsl:if test="$useVerbose">
                    <xsl:message>Validating <xsl:value-of select="$uri"/></xsl:message>
                </xsl:if>
                <xsl:variable name="errors" as="xs:string*">
                    <xsl:sequence>
                        <xsl:apply-templates select="transform(
                            map{'stylesheet-node': $schemaXsl,
                                'cache': true(), 
                                'source-node': $currDoc,
                                'stylesheet-base-uri': $uri
                                })?output/descendant::svrl:text" mode="errors"/>
                    </xsl:sequence>
                </xsl:variable>
                <xsl:if test="not(empty($errors))">
                    <xsl:map-entry key="$uri" select="$errors"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:map>
    </xsl:template>
    
    <xsl:mode name="errors" on-no-match="shallow-skip"/>
   
    <xsl:template match="svrl:failed-assert/svrl:text  | svrl:successful-report/svrl:text" mode="errors">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    <xsl:function name="jt:makeSchemaXsl" new-each-time="no">
        <xsl:if test="$useVerbose">
            <xsl:message>Making schema XSLT...</xsl:message>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="not(jt:noVal($xsl)) and doc-available($xsl)">
                <xsl:if test="$useVerbose">
                    <xsl:message>XSLT supplied; using that.</xsl:message>
                </xsl:if>
                <xsl:sequence select="$xsl"/>
            </xsl:when>
            <xsl:when test="not(jt:noVal($sch)) and doc-available($sch)">
                <xsl:if test="$useVerbose">
                    <xsl:message>Found schematron. Converting to XSL.</xsl:message>
                </xsl:if>
                <xsl:copy-of select="jt:schematronToXsl(doc($sch))"/>
            </xsl:when>
            <xsl:when test="not(jt:noVal($rng)) and doc-available($rng)">
                <xsl:if test="$useVerbose">
                    <xsl:message>Found RNG with embedded Schematron.</xsl:message>
                </xsl:if>
                <xsl:if test="$useVerbose">
                    <xsl:message>Extracting embedded schematron from RNG using <xsl:value-of select="resolve-uri($extract.rng)"/></xsl:message>
                </xsl:if>
                <xsl:copy-of select="jt:transform($extract.rng, doc($rng))?output => jt:schematronToXsl()"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="jt:schematronToXsl" new-each-time="no">
        <xsl:param name="sch"/>
        <xsl:variable name="first" select="if ($sch//*[self::*:include | self::*:extends]) then jt:transform($iso.dsdl.include,$sch)?output else $sch"/>
        
        <xsl:variable name="second" 
            select="if ($sch//*[self::*:pattern]) 
                    then jt:transform($iso.abstract.expand, $first)?output 
                    else $first"/>
        
        <xsl:copy-of select="jt:transform($iso.svrl, $second)?output"/>
    </xsl:function>
    
    
    <xsl:function name="jt:transform">
        <xsl:param name="stylesheet-location" as="xs:string"/>
        <xsl:param name="source-node" as="node()"/>
        <xsl:copy-of 
            select="transform(map{'stylesheet-location': $stylesheet-location, 'cache': true(), 'source-node': $source-node})"/>
    </xsl:function>
    
    
    
    
    
    
    <xsl:template name="echoParams">
        <xsl:if test="$useVerbose"><xsl:message>$rng: <xsl:value-of select="$rng"/></xsl:message></xsl:if>
        <xsl:if test="$useVerbose"><xsl:message>$sch: <xsl:value-of select="$sch"/></xsl:message></xsl:if>
        <xsl:if test="$useVerbose"><xsl:message>$xsl: <xsl:value-of select="$xsl"/></xsl:message></xsl:if>
        <xsl:if test="$useVerbose"><xsl:message>$file: <xsl:value-of select="$file"/></xsl:message></xsl:if>
        <xsl:if test="$useVerbose"><xsl:message>$dir: <xsl:value-of select="$dir"/></xsl:message></xsl:if>
        <xsl:if test="$useVerbose"><xsl:message>$verbose: <xsl:value-of select="$verbose"/></xsl:message></xsl:if>
        <xsl:if test="$useVerbose"><xsl:message>$resolvedFile: <xsl:value-of select="$resolvedFile"/></xsl:message></xsl:if>
    </xsl:template>
    
    <xsl:template name="checkParams">
        <xsl:choose>
            <xsl:when test="not(jt:noVal($rng)) and not(jt:noVal($sch)) and not(jt:noVal($xsl))">
                <xsl:message terminate="yes">ERROR: One of rng, sch, and xsl should be supplied. Choose one.</xsl:message>
            </xsl:when>
            <xsl:when test="jt:noVal($rng) and jt:noVal($sch) and jt:noVal($xsl)">
                <xsl:message terminate="yes">ERROR: No schema specified.</xsl:message>
            </xsl:when>
            <xsl:when test="not(jt:noVal($file)) and not(jt:noVal($dir))">
                <xsl:message terminate="yes">ERROR: Both file and dir supplied. Choose one.</xsl:message>
            </xsl:when>
            <xsl:when test="jt:noVal($file) and jt:noVal($dir)">
                <xsl:message terminate="yes">ERROR: No file or directory specified.</xsl:message>
            </xsl:when>
            <xsl:when test="empty($docs)">
                <xsl:message terminate="yes">ERROR: No documents specified. Check your paths.</xsl:message>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:function name="jt:noVal" as="xs:boolean" new-each-time="no">
        <xsl:param name="string" as="xs:string?"/>
        <xsl:sequence select="string-length(normalize-space($string)) = 0"/>
    </xsl:function>
    
    
    
</xsl:stylesheet>
