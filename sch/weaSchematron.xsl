<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
   <xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


   <!--PROLOG-->
   <xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>

   <!--XSD TYPES FOR XSLT2-->


   <!--KEYS AND FUNCTIONS-->


   <!--DEFAULT RULES-->


   <!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
   <!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
   <xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
   <xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
   <xsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="" schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
         <svrl:ns-prefix-in-attribute-values uri="http://relaxng.org/ns/structure/1.0" prefix="rng"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.datable.w3c-att-datable-w3c-when-constraint-rule-1</xsl:attribute>
            <xsl:attribute name="name">wea-att.datable.w3c-att-datable-w3c-when-constraint-rule-1</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M3"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.datable.w3c-att-datable-w3c-from-constraint-rule-2</xsl:attribute>
            <xsl:attribute name="name">wea-att.datable.w3c-att-datable-w3c-from-constraint-rule-2</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M4"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.datable.w3c-att-datable-w3c-to-constraint-rule-3</xsl:attribute>
            <xsl:attribute name="name">wea-att.datable.w3c-att-datable-w3c-to-constraint-rule-3</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.datable-calendar-calendar-constraint-rule-4</xsl:attribute>
            <xsl:attribute name="name">wea-att.datable-calendar-calendar-constraint-rule-4</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.typed-subtypeTyped-constraint-rule-5</xsl:attribute>
            <xsl:attribute name="name">wea-att.typed-subtypeTyped-constraint-rule-5</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-6</xsl:attribute>
            <xsl:attribute name="name">wea-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-6</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-p-abstractModel-structure-p-constraint-report-5</xsl:attribute>
            <xsl:attribute name="name">wea-p-abstractModel-structure-p-constraint-report-5</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-p-abstractModel-structure-l-constraint-report-6</xsl:attribute>
            <xsl:attribute name="name">wea-p-abstractModel-structure-l-constraint-report-6</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-ref-refAtts-constraint-report-7</xsl:attribute>
            <xsl:attribute name="name">wea-ref-refAtts-constraint-report-7</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-list-gloss-list-must-have-labels-constraint-rule-8</xsl:attribute>
            <xsl:attribute name="name">wea-list-gloss-list-must-have-labels-constraint-rule-8</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-relatedItem-targetorcontent1-constraint-report-8</xsl:attribute>
            <xsl:attribute name="name">wea-relatedItem-targetorcontent1-constraint-report-8</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-relatedItem-targetorcontent1-constraint-assert-8</xsl:attribute>
            <xsl:attribute name="name">wea-relatedItem-targetorcontent1-constraint-assert-8</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-l-abstractModel-structure-l-constraint-report-9</xsl:attribute>
            <xsl:attribute name="name">wea-l-abstractModel-structure-l-constraint-report-9</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-lg-atleast1oflggapl-constraint-assert-9</xsl:attribute>
            <xsl:attribute name="name">wea-lg-atleast1oflggapl-constraint-assert-9</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-lg-abstractModel-structure-l-constraint-report-10</xsl:attribute>
            <xsl:attribute name="name">wea-lg-abstractModel-structure-l-constraint-report-10</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-quotation-quotationContents-constraint-report-11</xsl:attribute>
            <xsl:attribute name="name">wea-quotation-quotationContents-constraint-report-11</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-ab-abstractModel-structure-ab-constraint-report-12</xsl:attribute>
            <xsl:attribute name="name">wea-ab-abstractModel-structure-ab-constraint-report-12</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-ab-abstractModel-structure-l-constraint-report-13</xsl:attribute>
            <xsl:attribute name="name">wea-ab-abstractModel-structure-l-constraint-report-13</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-div-abstractModel-structure-l-constraint-report-14</xsl:attribute>
            <xsl:attribute name="name">wea-div-abstractModel-structure-l-constraint-report-14</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-div-abstractModel-structure-p-constraint-report-15</xsl:attribute>
            <xsl:attribute name="name">wea-div-abstractModel-structure-p-constraint-report-15</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


   <!--PATTERN wea-att.datable.w3c-att-datable-w3c-when-constraint-rule-1-->


	  <!--RULE -->
   <xsl:template match="tei:*[@when]" priority="1000" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@when]"/>

		    <!--REPORT nonfatal-->
      <xsl:if test="@notBefore|@notAfter|@from|@to">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="@notBefore|@notAfter|@from|@to">
            <xsl:attribute name="role">nonfatal</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>The @when attribute cannot be used with any other att.datable.w3c attributes.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M3"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M3"/>
   <xsl:template match="@*|node()" priority="-2" mode="M3">
      <xsl:apply-templates select="*" mode="M3"/>
   </xsl:template>

   <!--PATTERN wea-att.datable.w3c-att-datable-w3c-from-constraint-rule-2-->


	  <!--RULE -->
   <xsl:template match="tei:*[@from]" priority="1000" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@from]"/>

		    <!--REPORT nonfatal-->
      <xsl:if test="@notBefore">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@notBefore">
            <xsl:attribute name="role">nonfatal</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>The @from and @notBefore attributes cannot be used together.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M4"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M4"/>
   <xsl:template match="@*|node()" priority="-2" mode="M4">
      <xsl:apply-templates select="*" mode="M4"/>
   </xsl:template>

   <!--PATTERN wea-att.datable.w3c-att-datable-w3c-to-constraint-rule-3-->


	  <!--RULE -->
   <xsl:template match="tei:*[@to]" priority="1000" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@to]"/>

		    <!--REPORT nonfatal-->
      <xsl:if test="@notAfter">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@notAfter">
            <xsl:attribute name="role">nonfatal</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>The @to and @notAfter attributes cannot be used together.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>

   <!--PATTERN wea-att.datable-calendar-calendar-constraint-rule-4-->


	  <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length(.) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(.) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
@calendar indicates the system or calendar to which the date represented by the content of this element
belongs, but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

   <!--PATTERN wea-att.typed-subtypeTyped-constraint-rule-5-->


	  <!--RULE -->
   <xsl:template match="tei:*[@subtype]" priority="1000" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@subtype]"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@type">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element should not be categorized in detail with @subtype unless also categorized in general with @type</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>

   <!--PATTERN wea-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-6-->


	  <!--RULE -->
   <xsl:template match="tei:*[@schemeVersion]" priority="1000" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@schemeVersion]"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@scheme and not(@scheme = 'free')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@scheme and not(@scheme = 'free')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
              @schemeVersion can only be used if @scheme is specified.
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>

   <!--PATTERN wea-p-abstractModel-structure-p-constraint-report-5-->


	  <!--RULE -->
   <xsl:template match="tei:p" priority="1000" mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:p"/>

		    <!--REPORT -->
      <xsl:if test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum                |parent::tei:item                |parent::tei:note                |parent::tei:q                |parent::tei:quote                |parent::tei:remarks                |parent::tei:said                |parent::tei:sp                |parent::tei:stage                |parent::tei:cell                |parent::tei:figure                )">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab) and not(parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure )">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>

   <!--PATTERN wea-p-abstractModel-structure-l-constraint-report-6-->


	  <!--RULE -->
   <xsl:template match="tei:p" priority="1000" mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:p"/>

		    <!--REPORT -->
      <xsl:if test="ancestor::tei:l[not(.//tei:note//tei:p[. = current()])]">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="ancestor::tei:l[not(.//tei:note//tei:p[. = current()])]">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

   <!--PATTERN wea-ref-refAtts-constraint-report-7-->


	  <!--RULE -->
   <xsl:template match="tei:ref" priority="1000" mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:ref"/>

		    <!--REPORT -->
      <xsl:if test="@target and @cRef">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@target and @cRef">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Only one of the
	attributes @target' and @cRef' may be supplied on <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>
               </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>

   <!--PATTERN wea-list-gloss-list-must-have-labels-constraint-rule-8-->


	  <!--RULE -->
   <xsl:template match="tei:list[@type='gloss']" priority="1000" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:list[@type='gloss']"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:label"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="tei:label">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:note[@type='authorial']" priority="1000" mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:note[@type='authorial']"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:q"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ancestor::tei:q">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Authorial notes should only be used within the q element.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:note[ancestor::tei:q]" priority="1000" mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:note[ancestor::tei:q]"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@type">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Notes within the q element should have a type of either authorial
                                 or editorial.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:note[@type='editorial']" priority="1000" mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:note[@type='editorial']"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@resp"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@resp">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Editorial notes should have a @resp attribute pointing to the person who authored this note.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>

   <!--PATTERN wea-relatedItem-targetorcontent1-constraint-report-8-->


	  <!--RULE -->
   <xsl:template match="tei:relatedItem" priority="1000" mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:relatedItem"/>

		    <!--REPORT -->
      <xsl:if test="@target and count( child::* ) &gt; 0">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="@target and count( child::* ) &gt; 0">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
If the @target attribute on <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> is used, the
relatedItem element must be empty</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>

   <!--PATTERN wea-relatedItem-targetorcontent1-constraint-assert-8-->


	  <!--RULE -->
   <xsl:template match="tei:relatedItem" priority="1000" mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:relatedItem"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@target or child::*"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@target or child::*">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>A relatedItem element should have either a 'target' attribute
        or a child element to indicate the related bibliographic item</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>

   <!--PATTERN wea-l-abstractModel-structure-l-constraint-report-9-->


	  <!--RULE -->
   <xsl:template match="tei:l" priority="1000" mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:l"/>

		    <!--REPORT -->
      <xsl:if test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Lines may not contain lines or lg elements.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>

   <!--PATTERN wea-lg-atleast1oflggapl-constraint-assert-9-->


	  <!--RULE -->
   <xsl:template match="tei:lg" priority="1000" mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:lg"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>An lg element
        must contain at least one child l, lg or gap element.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

   <!--PATTERN wea-lg-abstractModel-structure-l-constraint-report-10-->


	  <!--RULE -->
   <xsl:template match="tei:lg" priority="1000" mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:lg"/>

		    <!--REPORT -->
      <xsl:if test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Lines may not contain line groups.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:sourceDesc[not(tei:bibl)]" priority="1000" mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:sourceDesc[not(tei:bibl)]"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $d in $docTypes satisfies matches($d, 'BornDigital')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $d in $docTypes satisfies matches($d, 'BornDigital')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                      ERROR: All not born digital documents must use a &lt;bibl&gt; element in their
                      source descriptions.
                    </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>

   <!--PATTERN wea-quotation-quotationContents-constraint-report-11-->


	  <!--RULE -->
   <xsl:template match="tei:quotation" priority="1000" mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:quotation"/>

		    <!--REPORT -->
      <xsl:if test="not(@marks) and not (tei:p)">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(@marks) and not (tei:p)">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
On <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>, either the @marks attribute should be used, or a paragraph of description provided</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:textClass" priority="1002" mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:textClass"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:catRef[@scheme='wdt:docType']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="tei:catRef[@scheme='wdt:docType']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                            ERROR: Missing category reference docType.
                        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="tei:textClass" priority="1001" mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:textClass"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:catRef[@scheme='wdt:genre']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="tei:catRef[@scheme='wdt:genre']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                            ERROR: Missing category reference genre.
                        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="tei:textClass" priority="1000" mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:textClass"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:catRef[@scheme='wdt:category']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="tei:catRef[@scheme='wdt:category']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                            ERROR: Missing category reference category.
                        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:catRef[@scheme='wdt:docType']"
                 priority="1002"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:catRef[@scheme='wdt:docType']"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@target,'^((wdt:docPrimarySource)|(wdt:docPrimarySourceMS)|(wdt:docPrimarySourcePublished)|(wdt:docBornDigital)|(wdt:docBornDigitalCategory))$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@target,'^((wdt:docPrimarySource)|(wdt:docPrimarySourceMS)|(wdt:docPrimarySourcePublished)|(wdt:docBornDigital)|(wdt:docBornDigitalCategory))$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                            ERROR: Value <xsl:text/>
                  <xsl:value-of select="@target"/>
                  <xsl:text/> not allowed for category reference <xsl:text/>
                  <xsl:value-of select="@scheme"/>
                  <xsl:text/>
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="tei:catRef[@scheme='wdt:genre']" priority="1001" mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:catRef[@scheme='wdt:genre']"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@target,'^((wdt:genreShortStory)|(wdt:genreNF)|(wdt:genreNFAuto)|(wdt:genreNFDedication)|(wdt:genreNFInterview)|(wdt:genreNFIntroduction)|(wdt:genreNFEthnography)|(wdt:genreFilm)|(wdt:genreFilmScenario)|(wdt:genreFilmTreatment)|(wdt:genrePoem)|(wdt:genreNovel)|(wdt:genreNovelSerial))$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@target,'^((wdt:genreShortStory)|(wdt:genreNF)|(wdt:genreNFAuto)|(wdt:genreNFDedication)|(wdt:genreNFInterview)|(wdt:genreNFIntroduction)|(wdt:genreNFEthnography)|(wdt:genreFilm)|(wdt:genreFilmScenario)|(wdt:genreFilmTreatment)|(wdt:genrePoem)|(wdt:genreNovel)|(wdt:genreNovelSerial))$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                            ERROR: Value <xsl:text/>
                  <xsl:value-of select="@target"/>
                  <xsl:text/> not allowed for category reference <xsl:text/>
                  <xsl:value-of select="@scheme"/>
                  <xsl:text/>
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="tei:catRef[@scheme='wdt:category']"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:catRef[@scheme='wdt:category']"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@target,'^((wdt:Japan)|(wdt:Alberta)|(wdt:Hollywood)|(wdt:EarlyExperiment)|(wdt:NewYork))$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@target,'^((wdt:Japan)|(wdt:Alberta)|(wdt:Hollywood)|(wdt:EarlyExperiment)|(wdt:NewYork))$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                            ERROR: Value <xsl:text/>
                  <xsl:value-of select="@target"/>
                  <xsl:text/> not allowed for category reference <xsl:text/>
                  <xsl:value-of select="@scheme"/>
                  <xsl:text/>
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>

   <!--PATTERN wea-ab-abstractModel-structure-ab-constraint-report-12-->


	  <!--RULE -->
   <xsl:template match="tei:ab" priority="1000" mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:ab"/>

		    <!--REPORT -->
      <xsl:if test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum         |parent::tei:item         |parent::tei:note         |parent::tei:q         |parent::tei:quote         |parent::tei:remarks         |parent::tei:said         |parent::tei:sp         |parent::tei:stage         |parent::tei:cell         |parent::tei:figure)">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab) and not(parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure)">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: ab may not occur inside paragraphs or other ab elements.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>

   <!--PATTERN wea-ab-abstractModel-structure-l-constraint-report-13-->


	  <!--RULE -->
   <xsl:template match="tei:ab" priority="1000" mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:ab"/>

		    <!--REPORT -->
      <xsl:if test="ancestor::tei:l or ancestor::tei:lg">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="ancestor::tei:l or ancestor::tei:lg">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Lines may not contain higher-level divisions such as p or ab.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>

   <!--PATTERN wea-div-abstractModel-structure-l-constraint-report-14-->


	  <!--RULE -->
   <xsl:template match="tei:div" priority="1000" mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:div"/>

		    <!--REPORT -->
      <xsl:if test="ancestor::tei:l">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ancestor::tei:l">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Lines may not contain higher-level structural elements such as div.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>

   <!--PATTERN wea-div-abstractModel-structure-p-constraint-report-15-->


	  <!--RULE -->
   <xsl:template match="tei:div" priority="1000" mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:div"/>

		    <!--REPORT -->
      <xsl:if test="ancestor::tei:p or ancestor::tei:ab and not(ancestor::tei:floatingText)">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="ancestor::tei:p or ancestor::tei:ab and not(ancestor::tei:floatingText)">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: p and ab may not contain higher-level structural elements such as div.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>

   <!--PATTERN -->
   <xsl:variable name="spaceRegex" select="'(^\s)|(\s$)'"/>
   <xsl:variable name="docId" select="root(/)/tei:*/@xml:id"/>
   <xsl:variable name="docUri" select="document-uri(/)"/>
   <xsl:variable name="docIds" select="//tei:*[@xml:id]/@xml:id"/>
   <xsl:variable name="docTypes" select="//tei:catRef/@target"/>
   <xsl:variable name="docStatus" select="//tei:revisionDesc/@status"/>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/tei:TEI[not(ancestor::tei:teiCorpus)] | /tei:teiCorpus"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/tei:TEI[not(ancestor::tei:teiCorpus)] | /tei:teiCorpus"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@xml:id and matches($docUri,concat('[/\\]',$docId,'.xm[l_]$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@xml:id and matches($docUri,concat('[/\\]',$docId,'.xm[l_]$'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> ERROR: Document
                    xml:id (<xsl:text/>
                  <xsl:value-of select="$docId"/>
                  <xsl:text/>) does not match the document file
                    name (<xsl:text/>
                  <xsl:value-of select="$docUri"/>
                  <xsl:text/>). </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:*[not(ancestor-or-self::tei:code)][text()]"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:*[not(ancestor-or-self::tei:code)][text()]"/>
      <xsl:variable name="onlyOneQuote"
                    select="some $t in text() satisfies (not(count(tokenize($t,'”')) = count(tokenize($t,'“'))))"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not($onlyOneQuote)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not($onlyOneQuote)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: Curly quotes that cannot be QuickFixed. Either add the curly quotation mark or change to the q element.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:name | tei:ref | tei:title | tei:l"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:name | tei:ref | tei:title | tei:l"/>
      <xsl:variable name="text" select="string-join(descendant::text(),'')"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches($text,'^\s+|\s+$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not(matches($text,'^\s+|\s+$'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> should not begin or end with spaces.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:name" priority="1000" mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:name"/>
      <xsl:variable name="text" select="string-join(descendant::text(),'')"/>

		    <!--ASSERT warning-->
      <xsl:choose>
         <xsl:when test="not(matches($text,'\.$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not(matches($text,'\.$'))">
               <xsl:attribute name="role">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              WARNING: <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> usually shouldn't end with periods.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:q" priority="1000" mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:q"/>
      <xsl:variable name="text" select="string-join(descendant::text(),'')"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches($text,'[\.,]$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not(matches($text,'[\.,]$'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: Trailing punctuaton should go outside the <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:body | tei:*[text()][normalize-space(string-join(text(),'')) ne '']"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:body | tei:*[text()][normalize-space(string-join(text(),'')) ne '']"/>
      <xsl:variable name="thisText"
                    select="if (self::tei:body) then string-join(descendant::text(),'') else string-join(text(),'')"/>
      <xsl:variable name="cp" select="string-to-codepoints($thisText)"/>
      <xsl:variable name="distinctCp" select="distinct-values($cp)"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty($distinctCp[.=34])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty($distinctCp[.=34])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: QUICKFIX: Do not use straight quotation marks.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:body | tei:*[text()][normalize-space(string-join(text(),'')) ne '']"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:body | tei:*[text()][normalize-space(string-join(text(),'')) ne '']"/>
      <xsl:variable name="thisText"
                    select="if (self::tei:body) then string-join(descendant::text(),'') else string-join(text(),'')"/>
      <xsl:variable name="cp" select="string-to-codepoints($thisText)"/>
      <xsl:variable name="distinctCp" select="distinct-values($cp)"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty($distinctCp[.=39])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty($distinctCp[.=39])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: QUICKFIX: Do not use straight apostrophes. 
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:body | tei:div | tei:lg" priority="1000" mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:body | tei:div | tei:lg"/>
      <xsl:variable name="divs"
                    select="if (self::tei:body) then (descendant::tei:div) else ."/>
      <xsl:variable name="noElContentDivs" select="$divs[not(descendant::*)]"/>
      <xsl:variable name="contentDivs"
                    select="$noElContentDivs[not(normalize-space(string-join(text(),''))='')]"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty($contentDivs)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty($contentDivs)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: QUICKFIX: Untagged text should likely be tagged. Use the Quickfix to do so.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="tei:body | tei:*[text()][not(normalize-space(string-join(text(),''))='')]"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:body | tei:*[text()][not(normalize-space(string-join(text(),''))='')]"/>
      <xsl:variable name="text" select="string-join(descendant::text(),'')"/>
      <xsl:variable name="containsCurlyQuotes"
                    select="matches($text,'“') and matches($text,'”')"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not($containsCurlyQuotes)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($containsCurlyQuotes)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: QUICKFIX: Do not use curly quotes; use the q element instead.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
</xsl:stylesheet>
