<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:jt="http://github.com/joeytakeda"
    exclude-result-prefixes="#all"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    version="2.0">
    
    <!--This stylesheet adds values from our taxonomies to the ODD file-->
    
    <xsl:output indent="yes"/>
    
    <xsl:variable name="taxonomies" select="document('../../data/taxonomies.xml')"/>
    <xsl:variable name="people" select="document('../../data/people.xml')"/>
    <xsl:variable name="sq">'</xsl:variable>
    
    
    <!--         <constraintSpec scheme="schematron" ident="catRef.occurence">
                     <desc>An XsLT generated co-occurence constraint</desc>
                     <constraint>
                        
                     </constraint>
                                           <sch:pattern>
                           <sch:rule 
                        </sch:pattern>
                  </constraintSpec>-->
    <xsl:template match="constraintSpec[@ident='catRef.occurence']/constraint">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <sch:pattern>
                <xsl:for-each select="$taxonomies//taxonomy[@xml:id='docClassTaxonomies']/taxonomy">
                    <xsl:variable name="catRegex" select="concat('''',jt:makeRegex(descendant::category/@xml:id/concat('wdt:',.)),'''')"/>
                    <sch:rule context="tei:catRef[@scheme='wdt:{@xml:id}']">
                        <sch:assert test="matches(@target,{$catRegex})">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
                        </sch:assert>
                    </sch:rule>
                </xsl:for-each>
            </sch:pattern>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="elementSpec[@ident=('name','rs')]/attList/attDef[@ident='ref']/valList | classSpec[@ident='att.global.responsibility']/attList/attDef[@ident='resp']/valList">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each select="$people//person[@xml:id]">
                <valItem mode="add" ident="pers:{@xml:id}">
                    <desc><xsl:value-of select="@xml:id"/></desc>
                    <gloss><xsl:value-of select="persName/reg"/></gloss>
                </valItem>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
   <!-- <xsl:template match="constraintSpec[@ident='textClass.oneofEach']/constraint">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <sch:pattern>
                <xsl:for-each select="$taxonomies//taxonomy[@xml:id='docClassTaxonomies']/taxonomy">
                    <xsl:variable name="str" select="concat('wdt:',@xml:id)"/>
                    <sch:rule context="tei:textClass">
                        <sch:assert test="tei:catRef[@scheme='wdt:{@xml:id}']">
                            ERROR: Missing category reference <xsl:value-of select="@xml:id"/>.
                        </sch:assert>
                    </sch:rule>
                </xsl:for-each>
            </sch:pattern>
        </xsl:copy>
    </xsl:template>-->
    
    <xsl:function name="jt:makeRegex">
        <xsl:param name="seq"/>
        <xsl:value-of select="concat('^(',string-join(for $s in $seq return concat('(',$s,')'),'|'),')$')"/>
    </xsl:function>
    
    <xsl:template match="elementSpec[@ident='catRef']/attList/attDef[@ident='scheme']/valList">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each select="$taxonomies//taxonomy[@xml:id='docClassTaxonomies']/taxonomy">
                <valItem mode="add" ident="wdt:{@xml:id}">
                   <desc><xsl:value-of select="bibl"/></desc>
                </valItem>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="elementSpec[@ident='publisher']/attList/attDef[@ident='ref']/valList">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each select="document('../../data/organizations.xml')//listOrg/org[@xml:id]">
                <valItem mode="add" ident="org:{@xml:id}">
                    <desc><xsl:value-of select="normalize-space(string-join(descendant::text()[not(ancestor::note)],''))"/></desc>
                </valItem>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="elementSpec[@ident='catRef']/attList/attDef[@ident='target']/valList">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each select="$taxonomies//taxonomy[@xml:id='docClassTaxonomies']//category[@xml:id]">
                <valItem mode="add" ident="wdt:{@xml:id}">
                    <desc><xsl:value-of select="catDesc/term"/></desc>
                </valItem>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    

    <xsl:template match="table[@xml:id='codeTemplates_table']">
        
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <row role="label">
                <cell>Name</cell>
                <cell>Description</cell>
                <cell>Result</cell>
                <cell>Keystroke</cell>
            </row>
            <xsl:for-each select="document('../../data/wea_data.xpr')//*:codeTemplateItem[matches(*:field[@name='renderString'], 'WEA:')]">
                <xsl:sort select="lower-case(normalize-space(*:field[@name='renderString']))"/>
                <row>
                    <cell><xsl:value-of select="substring-after(normalize-space(*:field[@name='renderString']), 'WEA: ')"/></cell>
                    <cell><xsl:value-of select="normalize-space(*:field[@name='descriptionString'])"/></cell>
                    <cell><code><xsl:value-of select="normalize-space(*:field[@name='unparsedInsertString'])"/></code></cell>
                    <cell><xsl:value-of select="normalize-space(*:field[@name='accelerator'])"/></cell>
                </row>
            </xsl:for-each>
            
        </xsl:copy>
    </xsl:template>
   
    
    <!--Identity transform-->
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>