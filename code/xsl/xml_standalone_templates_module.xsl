<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.tei-c.org/ns/1.0"
    
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
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="prefixes" type="variable">$prefixes</xd:ref> is a sequence of all
            of the @ident attributes in the global prefixDef found in taxonomies.xml.</xd:desc>
    </xd:doc>
    <xsl:variable name="prefixes" select="$originalXml[//TEI/@xml:id='taxonomies']//prefixDef/@ident" as="attribute(ident)*"/>
    
    <xd:doc scope="component">
        <xd:desc><xd:ref name="prefixRegex" type="variable">$prefixRegex</xd:ref> is a Regular
            Expression that matches all of the prefixes used on the site--in the form:
            '^(prefix1|prefix2|...|prefixn):'</xd:desc>
    </xd:doc>
    <xsl:variable name="prefixRegex" 
        select="concat('^(',string-join(for $n in $prefixes return concat('(',$n,')'),'|'),'):')" as="xs:string"/>
    
    
    
    <xsl:template name="createStandalone">
        <xsl:variable name="pass1" as="element(TEI)">
            <xsl:apply-templates select="." mode="pass1"/>
        </xsl:variable>
        <xsl:apply-templates select="$pass1" mode="pass2">
            <xsl:with-param name="localRegex" select="wea:createLocalRegex($pass1)" tunnel="yes" as="xs:string"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="text" mode="pass1">
        <!--We create the standoff text, waiting for the TEI standoff element..-->
        <xsl:call-template name="createStandoff"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    
    <xsl:template match="tei:*/@active | tei:*/@adj | tei:*/@adjFrom | tei:*/@adjTo | tei:*/@ana |
        tei:*/@calendar | tei:*/@change | tei:*/@children | tei:*/@class |
        tei:*/@code | tei:*[not(ancestor::text[@type='standoff'])][not(ancestor-or-self::taxonomy)][not(ancestor-or-self::charDecl)]/@copyOf | tei:*/@corresp | tei:*/@datcat | tei:*/@datingMethod |
        tei:*/@datingPoint | tei:*/@decls | tei:*/@domains | tei:*/@edRef | tei:*/@end |
        tei:*/@exclude | tei:*/@facs | tei:*/@feats | tei:*/@filter | tei:*/@follow | 
        tei:*/@from | tei:*/@fVal | tei:*/@given | tei:*/@hand | tei:*/@inst | tei:*/@lemmaRef |
        tei:*/@location | tei:*/@mergedIn | tei:*/@mutual | tei:*/@new | tei:*/@next | tei:*/@nymRef |
        tei:*/@origin | tei:*/@parent | tei:*/@parts | tei:*/@passive | tei:*/@perf | tei:*/@period | 
        tei:*/@prev | tei:*/@ref | tei:*/@rendition | tei:*/@require | tei:*/@resp | tei:*/@sameAs |
        tei:*/@scheme | tei:*/@scribeRef | tei:*/@scriptRef | tei:*/@select | tei:*/@since |
        tei:*/@source | tei:*/@spanTo | tei:*/@start | tei:*/@start | tei:*/@synch | tei:*/@target |
        tei:*/@targetEnd | tei:*/@to | tei:*/@uri | tei:*/@url | tei:*/@value | tei:*/@valueDatcat |
        tei:*/@where | tei:*/@who | tei:*/@wit" mode="pass1">
        
        <xsl:variable name="tokens" select="tokenize(.,'\s+')"/>
        <xsl:attribute name="{local-name()}" select="string-join(for $t in $tokens return (wea:resolvePrefix($t,ancestor::TEI/@xml:id)),' ')"/>
    </xsl:template>
    
    
    <xsl:template name="createStandoff">
        <!--We only have people right now, but this can be added to-->
        <xsl:variable name="potentialPeoplePtrs" select="distinct-values(for $t in (for $p in (//tei:*/@*[contains(.,'pers:')]) return tokenize($p,'\s+')) return if (starts-with($t,'pers:')) then substring-after($t,'pers:') else ())"/>
        
        <xsl:variable name="peoplePtrs" select="for $p in $potentialPeoplePtrs return if (ancestor::TEI[descendant-or-self::tei:*[@xml:id=$p]]) then () else $p"/>
        
        <xsl:variable name="potentialOrgPtrs" select="distinct-values(for $t in (for $p in (//tei:*/@*[contains(.,'org:')]) return tokenize($p,'\s+')) return if (starts-with($t,'org:')) then substring-after($t,'org:') else ())"/>
        
        <xsl:variable name="orgPtrs" select="for $p in $potentialOrgPtrs return if (ancestor::TEI[descendant-or-self::tei:*[@xml:id=$p]]) then () else $p"/>
        
        <xsl:variable name="citationPtrs" select="//ref[@type='bibl'][contains(@target,'cite:')]/substring-after(@target,'cite:')" as="xs:string*"/>
        
        
        <xsl:if test="not(empty(($peoplePtrs,$orgPtrs)))">
            <text type="standoff">
                <body>
                    <xsl:if test="not(empty($peoplePtrs))">
                        <listPerson>
                            <xsl:for-each select="$peoplePtrs">
                                <xsl:variable name="thisPtr" select="."/>
                                <xsl:variable name="thisPerson" select="$originalXml[//TEI/@xml:id='people']//person[@xml:id=$thisPtr]"/>
                                <person>
                                    <xsl:copy-of select="$thisPerson/@*"/>
                                    <xsl:attribute name="copyOf" select="concat($thisPerson/ancestor::TEI/@xml:id,'.xml#',$thisPtr)"/>
                                    <xsl:copy-of select="$thisPerson/node()"/>
                                </person>
                            </xsl:for-each>
                        </listPerson>
                    </xsl:if>
                    <xsl:if test="not(empty($orgPtrs))">
                        <listOrg>
                            <xsl:for-each select="$orgPtrs">
                                <xsl:variable name="thisPtr" select="."/>
                                <xsl:variable name="thisOrg" select="$originalXml[//TEI/@xml:id='organizations']//org[@xml:id=$thisPtr]"/>
                                <org>
                                    <xsl:copy-of select="$thisOrg/@*"/>
                                    <xsl:attribute name="copyOf" select="concat($thisOrg/ancestor::TEI/@xml:id,'.xml#',$thisPtr)"/>
                                    <xsl:copy-of select="$thisOrg/node()"/>
                                </org>
                            </xsl:for-each>
                        </listOrg>
                    </xsl:if>
                    <xsl:if test="not(empty($citationPtrs))">
                        <listBibl>
                            <xsl:for-each select="$citationPtrs">
                                <xsl:variable name="thisPtr" select="."/>
                                <xsl:variable name="thisBibl" select="$originalXml[/TEI[@xml:id='bibliography']]//bibl[@xml:id=$thisPtr]"/>
                                <bibl>
                                    <xsl:copy-of select="$thisBibl/@*"/>
                                    <xsl:attribute name="copyOf" select="concat($thisBibl/ancestor::TEI/@xml:id,'.xml#',$thisPtr)"/>
                                    <xsl:copy-of select="$thisBibl/node()"/>
                                </bibl>
                            </xsl:for-each>
                        </listBibl>
                    </xsl:if>
                </body>
                
            </text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="publicationStmt[not(ancestor::sourceDesc)]" mode="pass1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
            <xsl:call-template name="createCitations"/>
        </xsl:copy>
    </xsl:template>
    
   
    
    <xsl:template name="createCitations">
        <xsl:variable name="root" select="ancestor::TEI"/>
        <xsl:variable name="bornDigital" select="$root/descendant::catRef[matches(@target,'BornDigital')]"/>
        <xsl:variable name="citationBibls">
            <listBibl>
                <xsl:choose>
                    <xsl:when test="$bornDigital">
                        <xsl:variable name="names" select="$root/descendant::respStmt[not(ancestor::sourceDesc)][resp/text()='Author']/name"/>
                        <xsl:variable name="authors" as="element(author)*">
                            <xsl:for-each select="$names">
                                <xsl:variable name="currName" select="."/>
                                <xsl:variable name="thisAuthor" select="$originalXml[//TEI/@xml:id='people']/descendant::person[@xml:id=$currName/@ref/substring-after(.,'pers:')]" as="element(person)"/>
                                <xsl:variable name="pos" select="position()"/>
                                <author>
                                    <xsl:copy>
                                        <xsl:copy-of select="@ref"/>
                                        <xsl:choose>
                                            <xsl:when test="$pos = 1">
                                                <xsl:value-of select="$thisAuthor/persName/surname || ', ' || $thisAuthor/persName/forename"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="$thisAuthor/persName/forename || ' ' || $thisAuthor/persName/surname"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:copy>
                                </author>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="authString" as="item()*">
                            <xsl:for-each select="$authors">
                                <xsl:variable name="pos" select="position()"/>
                                <xsl:message>This Pos: <xsl:value-of select="$pos"/></xsl:message>
                                <xsl:choose>
                                    <xsl:when test="$pos = 1"/>
                                    <xsl:when test="$pos gt 1">
                                        <xsl:text>, </xsl:text>
                                        <xsl:if test="$pos = count($authors)">
                                            <xsl:text>and </xsl:text>
                                        </xsl:if>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:copy-of select="."/>
                                <xsl:if test="$pos = last()">
                                    <xsl:text>. </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <bibl type="mla" n="MLA" xml:id="{$root/@xml:id || '_' || 'citation_MLA'}">
                            <xsl:sequence select="$authString"/>
                            <title level="a"><xsl:value-of select="$root/teiHeader/fileDesc/titleStmt/title[1]"/></title><xsl:text>.</xsl:text>
                            <xsl:sequence select="wea:appendMLA($root)"/>
                        </bibl>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <bibl type="mla" n="MLA" xml:id="{$root/@xml:id || '_' || 'citation_MLA'}">
                            <xsl:copy-of select="$root/descendant::sourceDesc/bibl[1]/node()"/>
                            <xsl:sequence select="wea:appendMLA($root)"/>
                        </bibl>
                    </xsl:otherwise>
                </xsl:choose>
            </listBibl>
        </xsl:variable>
         <xsl:choose>
             <xsl:when test="p | ab">
                 <ab type="citations">
                     <xsl:copy-of select="$citationBibls"/>
                 </ab>
             </xsl:when>
             <xsl:otherwise>
                 <availability status="unknown">
                     <ab type="citations">
                         <xsl:copy-of select="$citationBibls"/>
                     </ab>
                 </availability>
             </xsl:otherwise>
         </xsl:choose>
        
    </xsl:template>
    
    <xsl:function name="wea:appendMLA" as="item()+">
        <xsl:param name="doc"/>
        <xsl:variable name="uri" select="$siteUrl || '/' ||$doc/@xml:id || '.html'"/>
        <xsl:text> </xsl:text><title level="m">The Winnifred Eaton Archive</title>, edited by Mary Chapman and Jean Lee Cole, v. <xsl:value-of select="$version"/>, <xsl:value-of select="format-date(current-date(),'[D01] [MNn] [Y0001]')"/>, <ref target="{$uri}"><xsl:value-of select="$uri"/></ref><xsl:text>.</xsl:text>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Matches all pointer attributes that could now be made into local links; the localRegex
            determines whether or not this id exists in the document, and, if it does, then makes it local;
            otherwise, keep it as it was resolved before</xd:desc>
        <xd:param name="localRegex">A regular expression based off of all of the ids in the document. We use a
            regular expression as a tunnelled parameter so that we don't have to re-create it every time; a key could be used instead,
            but a regex is *much* faster.</xd:param>
        <xd:return>The same attribute, but with the pointers ratiaonlized.</xd:return>
    </xd:doc>
    <xsl:template match="tei:*/@active | tei:*/@adj | tei:*/@adjFrom | tei:*/@adjTo | tei:*/@ana |
        tei:*/@calendar | tei:*/@change | tei:*/@children | tei:*/@class |
        tei:*/@code | tei:*[not(ancestor::text[@type='standoff'])][not(self::bibl/ancestor::sourceDesc)][not(ancestor-or-self::taxonomy)][not(ancestor-or-self::charDecl)]/@copyOf | tei:*/@corresp | tei:*/@datcat | tei:*/@datingMethod |
        tei:*/@datingPoint | tei:*/@decls | tei:*/@domains | tei:*/@edRef | tei:*/@end |
        tei:*/@exclude | tei:*/@facs | tei:*/@feats | tei:*/@filter | tei:*/@follow | 
        tei:*/@from | tei:*/@fVal | tei:*/@given | tei:*/@hand | tei:*/@inst | tei:*/@lemmaRef |
        tei:*/@location | tei:*/@mergedIn | tei:*/@mutual | tei:*/@new | tei:*/@next | tei:*/@nymRef |
        tei:*/@origin | tei:*/@parent | tei:*/@parts | tei:*/@passive | tei:*/@perf | tei:*/@period | 
        tei:*/@prev | tei:*/@ref | tei:*/@rendition | tei:*/@require | tei:*/@resp | tei:*/@sameAs |
        tei:*/@scheme | tei:*/@scribeRef | tei:*/@scriptRef | tei:*/@select | tei:*/@since |
        tei:*/@source | tei:*/@spanTo | tei:*/@start | tei:*/@start | tei:*/@synch | tei:*[not(self::catRef)]/@target |
        tei:*/@targetEnd | tei:*/@to | tei:*/@uri | tei:*/@url | tei:*/@value | tei:*/@valueDatcat |
        tei:*/@where | tei:*/@who | tei:*/@wit" mode="pass2">
        <xsl:param name="localRegex" tunnel="yes" as="xs:string"/>
        <xsl:variable name="currVal" select="." as="attribute()"/>
        <xsl:variable name="attName" select="local-name(.)" as="xs:string"/>
        <xsl:variable name="sourceDoc" select="ancestor::TEI" as="element()"/>
        <xsl:variable name="sourceId" select="$sourceDoc/@xml:id" as="attribute(xml:id)"/>
        <xsl:variable name="tokens" select="tokenize(normalize-space($currVal),'\s+')" as="xs:string+"/>
        <xsl:variable name="out" as="xs:string+">
            <xsl:for-each select="$tokens">
                
                <xsl:variable name="thisToken" select="." as="xs:string"/>
                <xsl:choose>
                    <xsl:when test="$localRegex = '^$'">
                        <xsl:value-of select="$thisToken"/>
                    </xsl:when>
                    <!--If this token is declared within this file,
                        then convert it to a local link-->
                    <xsl:when test="matches($thisToken,$localRegex)">
                        <xsl:value-of select="concat('#',substring-after($thisToken,'#'))"/>
                    </xsl:when>
                    
                    <!--If this token pointed to the document it is now imported in,
                        fix it-->
                    <xsl:when test="matches($thisToken,concat('^',$sourceId,'\.xml#'))">
                        <xsl:value-of select="concat('#',substring-after($thisToken,'#'))"/>
                    </xsl:when>
                    
                    <!--Already local, so don't worry about it-->
                    <xsl:when test="starts-with($thisToken,'#')">
                        <xsl:value-of select="$thisToken"/>
                    </xsl:when>
                    
                    <!--A regular link-->
                    <xsl:when test="matches($thisToken,'^https?:')">
                        <xsl:value-of select="$thisToken"/>
                    </xsl:when>
                    
                    <!--A mailto thing-->
                    <xsl:when test="matches($thisToken,'mailto:')">
                        <xsl:value-of select="$thisToken"/>
                    </xsl:when>
                    
                    <!--This is a defined prefix; we might have to resolve again, since
                        things have been imported-->
                    <xsl:when test="matches($thisToken,$prefixRegex)">
                        <xsl:value-of select="wea:resolvePrefix($thisToken, $sourceId)"/>
                    </xsl:when>
                    
                    <!--Otherwise, flag it and spit it back out-->
                    <xsl:otherwise>
                        <xsl:value-of select="$thisToken"/>
                    </xsl:otherwise>
                </xsl:choose>         
            </xsl:for-each>  
        </xsl:variable>
        
        <xsl:attribute name="{$attName}" select="string-join($out,' ')"/>      
    </xsl:template>
    
    
    
    
    <xd:doc>
        <xd:desc>The <xd:ref name="wea:resolvePrefix" type="function">hcmc:resolvePrefix</xd:ref> functions
            resolves a prefixDef; we're extra careful here that we
            do have a prefix that matches it</xd:desc>
        <xd:param name="token">The input token (pointer) to resolve.</xd:param>
        <xd:param name="sourceId">The source id of the document.</xd:param>
        <xd:return>A resolve token, in the form of a string.</xd:return>
    </xd:doc>
    <xsl:function name="wea:resolvePrefix" as="xs:string">
        <xsl:param name="token" as="xs:string"/>
        <xsl:param name="sourceId" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="contains($token,':')">
                <xsl:choose>
                    <xsl:when test="matches($token,$prefixRegex)">
                        <xsl:variable name="thisPrefix" select="substring-before($token,':')" as="xs:string"/>
                        <!--Prefix from delared prefixDef-->
                        <!--We may want to switch this so that it looks at the local header
                            and not the global taxonomies header-->
                        <xsl:variable name="thisPrefixDef" select="$originalXml[//TEI/@xml:id='taxonomies']//prefixDef[@ident=$thisPrefix]" as="element(prefixDef)*"/>
                        <xsl:variable name="thisPointer" select="substring-after($token,concat($thisPrefix,':'))" as="xs:string"/>
                        <xsl:variable name="match" select="$thisPrefixDef[1]/@matchPattern" as="attribute(matchPattern)?"/>
                        <xsl:variable name="replacement" select="$thisPrefixDef[1]/@replacementPattern" as="attribute(replacementPattern)?"/>
                        
                        <!--$match and $replacement should be regexes-->
                        <xsl:variable name="resolved" select="replace($thisPointer,$match,$replacement)" as="xs:string"/>
                        
                        <!--If this is a local link, make it local-->
                        <xsl:variable name="localized" 
                            select="if (matches($resolved, concat('^',$sourceId,'.xml#'))) 
                            then substring-after($resolved,concat($sourceId,'.xml'))
                            else $resolved" as="xs:string"/>
                        <xsl:value-of select="$localized"/>
                    </xsl:when>
                    <!--If it doesn't match the local prefix regex,
                then just spit the token back out, unresolved-->
                    <xsl:otherwise>
                        <xsl:if test="not(matches($token,'^(https?|mailto)'))">
                            <xsl:message>Couldn't resolve token: <xsl:value-of select="$token"/></xsl:message>
                        </xsl:if>
     
                        <xsl:value-of select="$token"/>
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$token"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>The <xd:ref name="wea:createLocalRegex" type="function">hcmc:createLocalRegex</xd:ref> functions
            creates the "localRegex", which is a long regular expression
            of all items that are local to the document</xd:desc>
        <xd:param name="doc">The document from which to derive the pointers.</xd:param>
        <xd:return>A regular expression that contains all of the items local to the document.</xd:return>
    </xd:doc>
    <xsl:function name="wea:createLocalRegex" as="xs:string">
        <xsl:param name="doc" as="element()"/>
        <xsl:variable name="pointers" select="$doc//*[@copyOf]/@copyOf" as="attribute(copyOf)*"/>
        <xsl:variable name="distinct" select="distinct-values($pointers)" as="xs:string*"/>
        <xsl:variable name="regex" select="concat('^',string-join(for $n in $distinct return concat('(',$n,')'),'|'),'$')" as="xs:string"/>
        <xsl:value-of select="$regex"/>
    </xsl:function>
    
    <xsl:template match="@*|node()" priority="-1" mode="#all" >
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>