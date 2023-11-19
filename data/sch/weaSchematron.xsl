<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:rna="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                xmlns:sch1x="http://www.ascc.net/xml/schematron"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
         <svrl:ns-prefix-in-attribute-values uri="http://relaxng.org/ns/compatibility/annotations/1.0" prefix="rna"/>
         <svrl:ns-prefix-in-attribute-values uri="http://purl.oclc.org/dsdl/schematron" prefix="sch"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.ascc.net/xml/schematron" prefix="sch1x"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.datable.w3c-att-datable-w3c-when-constraint-rule-1</xsl:attribute>
            <xsl:attribute name="name">wea-att.datable.w3c-att-datable-w3c-when-constraint-rule-1</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.datable.w3c-att-datable-w3c-from-constraint-rule-2</xsl:attribute>
            <xsl:attribute name="name">wea-att.datable.w3c-att-datable-w3c-from-constraint-rule-2</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.datable.w3c-att-datable-w3c-to-constraint-rule-3</xsl:attribute>
            <xsl:attribute name="name">wea-att.datable.w3c-att-datable-w3c-to-constraint-rule-3</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.global.source-source-only_1_ODD_source-constraint-rule-4</xsl:attribute>
            <xsl:attribute name="name">wea-att.global.source-source-only_1_ODD_source-constraint-rule-4</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.typed-subtypeTyped-constraint-rule-5</xsl:attribute>
            <xsl:attribute name="name">wea-att.typed-subtypeTyped-constraint-rule-5</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.pointing-targetLang-constraint-rule-6</xsl:attribute>
            <xsl:attribute name="name">wea-att.pointing-targetLang-constraint-rule-6</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-7</xsl:attribute>
            <xsl:attribute name="name">wea-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-7</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.calendarSystem-calendar-calendar-constraint-rule-8</xsl:attribute>
            <xsl:attribute name="name">wea-att.calendarSystem-calendar-calendar-constraint-rule-8</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-p-abstractModel-structure-p-in-ab-or-p-constraint-report-5</xsl:attribute>
            <xsl:attribute name="name">wea-p-abstractModel-structure-p-in-ab-or-p-constraint-report-5</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-p-abstractModel-structure-p-in-l-or-lg-constraint-report-6</xsl:attribute>
            <xsl:attribute name="name">wea-p-abstractModel-structure-p-in-l-or-lg-constraint-report-6</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-desc-deprecationInfo-only-in-deprecated-constraint-rule-11</xsl:attribute>
            <xsl:attribute name="name">wea-desc-deprecationInfo-only-in-deprecated-constraint-rule-11</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-name-calendar-check-name-constraint-rule-12</xsl:attribute>
            <xsl:attribute name="name">wea-name-calendar-check-name-constraint-rule-12</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-name-calendar-calendar-check-name-constraint-rule-13</xsl:attribute>
            <xsl:attribute name="name">wea-name-calendar-calendar-check-name-constraint-rule-13</xsl:attribute>
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
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-ptr-ptrAtts-constraint-report-7</xsl:attribute>
            <xsl:attribute name="name">wea-ptr-ptrAtts-constraint-report-7</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-ref-refAtts-constraint-report-8</xsl:attribute>
            <xsl:attribute name="name">wea-ref-refAtts-constraint-report-8</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-list-gloss-list-must-have-labels-constraint-rule-16</xsl:attribute>
            <xsl:attribute name="name">wea-list-gloss-list-must-have-labels-constraint-rule-16</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-note-note.editorialOnesShouldFollowTrailingPunct-constraint-rule-19</xsl:attribute>
            <xsl:attribute name="name">wea-note-note.editorialOnesShouldFollowTrailingPunct-constraint-rule-19</xsl:attribute>
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
            <xsl:attribute name="id">wea-author-calendar-check-author-constraint-rule-29</xsl:attribute>
            <xsl:attribute name="name">wea-author-calendar-check-author-constraint-rule-29</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-author-calendar-calendar-check-author-constraint-rule-30</xsl:attribute>
            <xsl:attribute name="name">wea-author-calendar-calendar-check-author-constraint-rule-30</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-editor-calendar-calendar-check-editor-constraint-rule-31</xsl:attribute>
            <xsl:attribute name="name">wea-editor-calendar-calendar-check-editor-constraint-rule-31</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-resp-calendar-calendar-check-resp-constraint-rule-32</xsl:attribute>
            <xsl:attribute name="name">wea-resp-calendar-calendar-check-resp-constraint-rule-32</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-title-calendar-check-title-constraint-rule-34</xsl:attribute>
            <xsl:attribute name="name">wea-title-calendar-check-title-constraint-rule-34</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M43"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-title-calendar-calendar-check-title-constraint-rule-35</xsl:attribute>
            <xsl:attribute name="name">wea-title-calendar-calendar-check-title-constraint-rule-35</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M44"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M46"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M47"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-relatedItem-targetorcontent1-constraint-report-9</xsl:attribute>
            <xsl:attribute name="name">wea-relatedItem-targetorcontent1-constraint-report-9</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M49"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-l-abstractModel-structure-l-in-l-constraint-report-10</xsl:attribute>
            <xsl:attribute name="name">wea-l-abstractModel-structure-l-in-l-constraint-report-10</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M50"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-lg-atleast1oflggapl-constraint-assert-37</xsl:attribute>
            <xsl:attribute name="name">wea-lg-atleast1oflggapl-constraint-assert-37</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M51"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-lg-abstractModel-structure-lg-in-l-constraint-report-11</xsl:attribute>
            <xsl:attribute name="name">wea-lg-abstractModel-structure-lg-in-l-constraint-report-11</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M52"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M53"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-idno-calendar-calendar-check-idno-constraint-rule-41</xsl:attribute>
            <xsl:attribute name="name">wea-idno-calendar-calendar-check-idno-constraint-rule-41</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M54"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-licence-calendar-calendar-check-licence-constraint-rule-42</xsl:attribute>
            <xsl:attribute name="name">wea-licence-calendar-calendar-check-licence-constraint-rule-42</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M55"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M56"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-quotation-quotationContents-constraint-report-12</xsl:attribute>
            <xsl:attribute name="name">wea-quotation-quotationContents-constraint-report-12</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M57"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M58"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M59"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M60"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M61"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-change-calendar-calendar-check-change-constraint-rule-51</xsl:attribute>
            <xsl:attribute name="name">wea-change-calendar-calendar-check-change-constraint-rule-51</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M62"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M63"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M64"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M65"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-link-linkTargets3-constraint-assert-53</xsl:attribute>
            <xsl:attribute name="name">wea-link-linkTargets3-constraint-assert-53</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M66"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-ab-abstractModel-structure-ab-in-l-or-lg-constraint-report-13</xsl:attribute>
            <xsl:attribute name="name">wea-ab-abstractModel-structure-ab-in-l-or-lg-constraint-report-13</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M67"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-msIdentifier-msId_minimal-constraint-report-14</xsl:attribute>
            <xsl:attribute name="name">wea-msIdentifier-msId_minimal-constraint-report-14</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M68"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-orgName-calendar-calendar-check-orgName-constraint-rule-55</xsl:attribute>
            <xsl:attribute name="name">wea-orgName-calendar-calendar-check-orgName-constraint-rule-55</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M69"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-persName-calendar-check-persName-constraint-rule-56</xsl:attribute>
            <xsl:attribute name="name">wea-persName-calendar-check-persName-constraint-rule-56</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M70"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-persName-calendar-calendar-check-persName-constraint-rule-57</xsl:attribute>
            <xsl:attribute name="name">wea-persName-calendar-calendar-check-persName-constraint-rule-57</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M71"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-placeName-calendar-calendar-check-placeName-constraint-rule-58</xsl:attribute>
            <xsl:attribute name="name">wea-placeName-calendar-calendar-check-placeName-constraint-rule-58</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M72"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-birth-calendar-calendar-check-birth-constraint-rule-59</xsl:attribute>
            <xsl:attribute name="name">wea-birth-calendar-calendar-check-birth-constraint-rule-59</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M73"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-death-calendar-calendar-check-death-constraint-rule-60</xsl:attribute>
            <xsl:attribute name="name">wea-death-calendar-calendar-check-death-constraint-rule-60</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M74"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-event-calendar-calendar-check-event-constraint-rule-61</xsl:attribute>
            <xsl:attribute name="name">wea-event-calendar-calendar-check-event-constraint-rule-61</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M75"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-location-calendar-calendar-check-location-constraint-rule-62</xsl:attribute>
            <xsl:attribute name="name">wea-location-calendar-calendar-check-location-constraint-rule-62</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M76"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-nationality-calendar-calendar-check-nationality-constraint-rule-63</xsl:attribute>
            <xsl:attribute name="name">wea-nationality-calendar-calendar-check-nationality-constraint-rule-63</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M77"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-occupation-calendar-calendar-check-occupation-constraint-rule-64</xsl:attribute>
            <xsl:attribute name="name">wea-occupation-calendar-calendar-check-occupation-constraint-rule-64</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M78"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M79"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M80"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M81"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M82"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M83"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-div-abstractModel-structure-div-in-l-or-lg-constraint-report-15</xsl:attribute>
            <xsl:attribute name="name">wea-div-abstractModel-structure-div-in-l-or-lg-constraint-report-15</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M84"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-div-abstractModel-structure-div-in-ab-or-p-constraint-report-16</xsl:attribute>
            <xsl:attribute name="name">wea-div-abstractModel-structure-div-in-ab-or-p-constraint-report-16</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M85"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-att.global.facs-facs.mustStartWithFacs-constraint-rule-70</xsl:attribute>
            <xsl:attribute name="name">wea-att.global.facs-facs.mustStartWithFacs-constraint-rule-70</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M86"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">wea-subst-substContents1-constraint-assert-70</xsl:attribute>
            <xsl:attribute name="name">wea-subst-substContents1-constraint-assert-70</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M87"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M88"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M89"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M90"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M91"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M92"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M93"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M94"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M95"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M96"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M97"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M98"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M99"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M100"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M101"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M102"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M103"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M104"/>
      </svrl:schematron-output>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <!--PATTERN wea-att.datable.w3c-att-datable-w3c-when-constraint-rule-1-->
   <!--RULE -->
   <xsl:template match="tei:*[@when]" priority="1000" mode="M6">
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
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <!--PATTERN wea-att.datable.w3c-att-datable-w3c-from-constraint-rule-2-->
   <!--RULE -->
   <xsl:template match="tei:*[@from]" priority="1000" mode="M7">
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
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>
   <!--PATTERN wea-att.datable.w3c-att-datable-w3c-to-constraint-rule-3-->
   <!--RULE -->
   <xsl:template match="tei:*[@to]" priority="1000" mode="M8">
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
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>
   <!--PATTERN wea-att.global.source-source-only_1_ODD_source-constraint-rule-4-->
   <!--RULE -->
   <xsl:template match="tei:*[@source]" priority="1000" mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@source]"/>
      <xsl:variable name="srcs" select="tokenize( normalize-space(@source),' ')"/>
      <!--REPORT -->
      <xsl:if test="( self::tei:classRef               | self::tei:dataRef               | self::tei:elementRef               | self::tei:macroRef               | self::tei:moduleRef               | self::tei:schemaSpec )               and               $srcs[2]">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="( self::tei:classRef | self::tei:dataRef | self::tei:elementRef | self::tei:macroRef | self::tei:moduleRef | self::tei:schemaSpec ) and $srcs[2]">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
              When used on a schema description element (like
              <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>), the @source attribute
              should have only 1 value. (This one has <xsl:text/>
               <xsl:value-of select="count($srcs)"/>
               <xsl:text/>.)
            </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <!--PATTERN wea-att.typed-subtypeTyped-constraint-rule-5-->
   <!--RULE -->
   <xsl:template match="tei:*[@subtype]" priority="1000" mode="M10">
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
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <!--PATTERN wea-att.pointing-targetLang-constraint-rule-6-->
   <!--RULE -->
   <xsl:template match="tei:*[not(self::tei:schemaSpec)][@targetLang]"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:*[not(self::tei:schemaSpec)][@targetLang]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@target"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@target">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>@targetLang should only be used on <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> if @target is specified.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <!--PATTERN wea-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-7-->
   <!--RULE -->
   <xsl:template match="tei:*[@schemeVersion]" priority="1000" mode="M12">
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
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <!--PATTERN wea-att.calendarSystem-calendar-calendar-constraint-rule-8-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
              systems or calendars to which the date represented by the content of this element belongs,
              but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <!--PATTERN wea-p-abstractModel-structure-p-in-ab-or-p-constraint-report-5-->
   <!--RULE -->
   <xsl:template match="tei:p" priority="1000" mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:p"/>
      <!--REPORT -->
      <xsl:if test="(ancestor::tei:ab or ancestor::tei:p) and not( ancestor::tei:floatingText |parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure )">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="(ancestor::tei:ab or ancestor::tei:p) and not( ancestor::tei:floatingText |parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure )">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <!--PATTERN wea-p-abstractModel-structure-p-in-l-or-lg-constraint-report-6-->
   <!--RULE -->
   <xsl:template match="tei:p" priority="1000" mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:p"/>
      <!--REPORT -->
      <xsl:if test="(ancestor::tei:l or ancestor::tei:lg) and not( ancestor::tei:floatingText |parent::tei:figure |parent::tei:note )">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="(ancestor::tei:l or ancestor::tei:lg) and not( ancestor::tei:floatingText |parent::tei:figure |parent::tei:note )">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab, unless p is a child of figure or note, or is a descendant of floatingText.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:foreign" priority="1000" mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:foreign"/>
      <xsl:variable name="text" select="string-join(text(),'')"/>
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
                                 ERROR: foreign elements should not begin or end with spaces.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:q[not(ancestor::tei:TEI/@xml:id='wea')]"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:q[not(ancestor::tei:TEI/@xml:id='wea')]"/>
      <xsl:variable name="text" select="string-join(descendant::text(),'')"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="if (normalize-space(string-join(child::text())) ='') then true() else not(matches($text,'^\s+|\s+$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (normalize-space(string-join(child::text())) ='') then true() else not(matches($text,'^\s+|\s+$'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: q elements should not begin or end with spaces.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <!--PATTERN wea-desc-deprecationInfo-only-in-deprecated-constraint-rule-11-->
   <!--RULE -->
   <xsl:template match="tei:desc[ @type eq 'deprecationInfo']"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:desc[ @type eq 'deprecationInfo']"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="../@validUntil"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="../@validUntil">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Information about a
        deprecation should only be present in a specification element
        that is being deprecated: that is, only an element that has a
        @validUntil attribute should have a child &lt;desc
        type="deprecationInfo"&gt;.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <!--PATTERN wea-name-calendar-check-name-constraint-rule-12-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <!--PATTERN wea-name-calendar-calendar-check-name-constraint-rule-13-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:ptr" priority="1000" mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:ptr"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:TEI/@xml:id='index'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="ancestor::tei:TEI/@xml:id='index'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Only use the ptr element in the index page,
                                 and it must have type='readMore'.
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
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:ptr" priority="1000" mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:ptr"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@target,'^doc:')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="matches(@target,'^doc:')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All ptr elements must have a @target attribute
                                 that points to a document using the doc: prefix.
                                 (ie. &lt;ptr target="doc:LiChingsBaby1"/&gt;)
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <!--PATTERN wea-ptr-ptrAtts-constraint-report-7-->
   <!--RULE -->
   <xsl:template match="tei:ptr" priority="1000" mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:ptr"/>
      <!--REPORT -->
      <xsl:if test="@target and @cRef">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@target and @cRef">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Only one of the
attributes @target and @cRef may be supplied on <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <!--PATTERN wea-ref-refAtts-constraint-report-8-->
   <!--RULE -->
   <xsl:template match="tei:ref" priority="1000" mode="M24">
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
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <!--PATTERN wea-list-gloss-list-must-have-labels-constraint-rule-16-->
   <!--RULE -->
   <xsl:template match="tei:list[@type='gloss']" priority="1000" mode="M25">
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
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:note[@type='parenthetical']" priority="1000" mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:note[@type='parenthetical']"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:q"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ancestor::tei:q">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Parenthetical notes should only be used within the q element.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:note[ancestor::tei:q]" priority="1000" mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:note[ancestor::tei:q]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type = ('parenthetical','editorial')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@type = ('parenthetical','editorial')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Notes within the q element should have a type of either parenthetical
                                 or editorial.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <!--PATTERN wea-note-note.editorialOnesShouldFollowTrailingPunct-constraint-rule-19-->
   <!--RULE -->
   <xsl:template match="tei:note[@type='editorial']" priority="1000" mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:note[@type='editorial']"/>
      <xsl:variable name="folText" select="following-sibling::text()[1]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches($folText, '^[\.,\?:;]'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not(matches($folText, '^[\.,\?:;]'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: Editorial notes should be placed after the trailing punctuation.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:person/tei:note | tei:org/tei:note"
                 priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:person/tei:note | tei:org/tei:note"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:p"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="tei:p">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All person and org notes must contain at least one paragraph.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:person/tei:note | tei:org/tei:note"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:person/tei:note | tei:org/tei:note"/>
      <xsl:variable name="text" select="normalize-space(string-join(text(),''))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$text=''"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="$text=''">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All textual content for person/org notes should be contained within a paragraph.
                              </svrl:text>
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
   <xsl:template match="tei:graphic[ancestor::tei:div[@type='listFigure']]"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:graphic[ancestor::tei:div[@type='listFigure']]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@mimeType"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@mimeType">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All media in the media database should use the @mimeType attribute to specify
                                 the source mimetype.
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
   <xsl:template match="tei:*[@url]" priority="1000" mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@url]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(@url,'\s+'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(matches(@url,'\s+'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Do not put spaces in image names. If it is an image in the repository,
                                 please rename it to not use spaces.
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
   <xsl:template match="tei:pb[@n]" priority="1000" mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:pb[@n]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@n,'^[A-Za-z0-9_\-\.]+$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@n,'^[A-Za-z0-9_\-\.]+$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>ERROR: @n should contain
                              only letters, digits, underscores, periods, or dashes.</svrl:text>
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
   <xsl:template match="tei:pb[@n][not($isFilm)]" priority="1000" mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:pb[@n][not($isFilm)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@n,'^((\d+[a-z]?)|(frontcover)|(backcover)|([xiv]+))$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@n,'^((\d+[a-z]?)|(frontcover)|(backcover)|([xiv]+))$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All @n attributes on page beginnings should start with numbers (and optionally end a alphanumeric string).
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
   <xsl:template match="tei:text[descendant::tei:pb]" priority="1000" mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:text[descendant::tei:pb]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="child::tei:*[1]/self::tei:pb"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="child::tei:*[1]/self::tei:pb">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Every text with page beginnings should start with an initial pb element. The first page number encountered is <xsl:text/>
                  <xsl:value-of select="descendant::tei:pb[@n][1]/@n"/>
                  <xsl:text/>.
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
   <xsl:template match="tei:pb[not($isFilm)]" priority="1000" mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:pb[not($isFilm)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(preceding::tei:pb[@n = current()/@n])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(preceding::tei:pb[@n = current()/@n])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All pb/@n should be unique within a document: <xsl:text/>
                  <xsl:value-of select="current()/@n"/>
                  <xsl:text/>.
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
   <xsl:template match="tei:lb" priority="1000" mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:lb"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:floatingText or ancestor::tei:front"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="ancestor::tei:floatingText or ancestor::tei:front">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Line beginning elements should ONLY be used in very special cases where lineation matters; currently that means only within floating
                                 texts.
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
   <!--PATTERN wea-author-calendar-check-author-constraint-rule-29-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <!--PATTERN wea-author-calendar-calendar-check-author-constraint-rule-30-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <!--PATTERN wea-editor-calendar-calendar-check-editor-constraint-rule-31-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <!--PATTERN wea-resp-calendar-calendar-check-resp-constraint-rule-32-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:title[@ref]" priority="1000" mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:title[@ref]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@level='j'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@level='j'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Only "j" level titles should use the @ref attribute.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <!--PATTERN wea-title-calendar-check-title-constraint-rule-34-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <!--PATTERN wea-title-calendar-calendar-check-title-constraint-rule-35-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:bibl[tei:biblScope[@unit=('issue','volume')]]"
                 priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:bibl[tei:biblScope[@unit=('issue','volume')]]"/>
      <!--ASSERT warning-->
      <xsl:choose>
         <xsl:when test="descendant::tei:title[@level='j']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::tei:title[@level='j']">
               <xsl:attribute name="role">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 WARNING: You have encoded issues and volumes, but no journal title. Are you sure this is correct?
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:bibl[ancestor::tei:div[@xml:id='bibliography_resources']]"
                 priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:bibl[ancestor::tei:div[@xml:id='bibliography_resources']]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:date[@when or @notBefore or @notAfter or @to or @from]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="tei:date[@when or @notBefore or @notAfter or @to or @from]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All secondary bibliography entries must encode a &lt;date&gt; element
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:sourceDesc[not(ancestor::tei:sourceDesc)]/tei:bibl"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:sourceDesc[not(ancestor::tei:sourceDesc)]/tei:bibl"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@copyOf and starts-with(@copyOf,'bibl:')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@copyOf and starts-with(@copyOf,'bibl:')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All bibls should have an @copyOf that points to the bibl
                                 id number of the bibliographic item in question (i.e. copyOf="bibl:77").
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:relatedItem[@target][not(tei:bibl)]"
                 priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:relatedItem[@target][not(tei:bibl)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@target,'^((https?://.+)|(bibl:[A-Z]{4}\d+)|(weda:Eat.+))$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@target,'^((https?://.+)|(bibl:[A-Z]{4}\d+)|(weda:Eat.+))$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: The @target for this relatedItem should be one of a 
                                 bibl pointer (bibl:AAAA1), an old WEDA link (weda:Eat...), OR an external link (https://...).
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <!--PATTERN wea-relatedItem-targetorcontent1-constraint-report-9-->
   <!--RULE -->
   <xsl:template match="tei:relatedItem" priority="1000" mode="M49">
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
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <!--PATTERN wea-l-abstractModel-structure-l-in-l-constraint-report-10-->
   <!--RULE -->
   <xsl:template match="tei:l" priority="1000" mode="M50">
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
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <!--PATTERN wea-lg-atleast1oflggapl-constraint-assert-37-->
   <!--RULE -->
   <xsl:template match="tei:lg" priority="1000" mode="M51">
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
        must contain at least one child l, lg, or gap element.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <!--PATTERN wea-lg-abstractModel-structure-lg-in-l-constraint-report-11-->
   <!--RULE -->
   <xsl:template match="tei:lg" priority="1000" mode="M52">
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
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:extent" priority="1000" mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:extent"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:biblFull[ancestor::tei:sourceDesc]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="ancestor::tei:biblFull[ancestor::tei:sourceDesc]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Do not use the extent element; it is to be used in the context
                                 of a biblFull in a source description.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <!--PATTERN wea-idno-calendar-calendar-check-idno-constraint-rule-41-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <!--PATTERN wea-licence-calendar-calendar-check-licence-constraint-rule-42-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:sourceDesc[not(tei:bibl)]" priority="1000" mode="M56">
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
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <!--PATTERN wea-quotation-quotationContents-constraint-report-12-->
   <!--RULE -->
   <xsl:template match="tei:quotation" priority="1000" mode="M57">
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
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:textClass[tei:catRef[@scheme='wdt:docType'][contains(@target,'Primary')]][ancestor::tei:TEI/descendant::tei:revisionDesc[@status=('readyForProof','published')]]"
                 priority="1000"
                 mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:textClass[tei:catRef[@scheme='wdt:docType'][contains(@target,'Primary')]][ancestor::tei:TEI/descendant::tei:revisionDesc[@status=('readyForProof','published')]]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:catRef[@scheme='wdt:genre'] and tei:catRef[@scheme='wdt:exhibit']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="tei:catRef[@scheme='wdt:genre'] and tei:catRef[@scheme='wdt:exhibit']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All primary soruce documents that are ready for proofing or published MUST have a genre and exhibit.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:catRef[@scheme='wdt:docType']"
                 priority="1002"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:catRef[@scheme='wdt:docType']"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@target,'^((wdt:docPrimarySource)|(wdt:docPrimarySourceMS)|(wdt:docPrimarySourcePublished)|(wdt:docBornDigital)|(wdt:docBornDigitalListing)|(wdt:docBornDigitalDocumentation))$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@target,'^((wdt:docPrimarySource)|(wdt:docPrimarySourceMS)|(wdt:docPrimarySourcePublished)|(wdt:docBornDigital)|(wdt:docBornDigitalListing)|(wdt:docBornDigitalDocumentation))$')">
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
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="tei:catRef[@scheme='wdt:genre']" priority="1001" mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:catRef[@scheme='wdt:genre']"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@target,'^((wdt:genreShortStory)|(wdt:genreNF)|(wdt:genreNFAuto)|(wdt:genreNFDedication)|(wdt:genreNFLetter)|(wdt:genreNFInterview)|(wdt:genreNFIntroduction)|(wdt:genreNFEthnography)|(wdt:genreNFMiscellany)|(wdt:genreNFMiscellanyBlurb)|(wdt:genreFilm)|(wdt:genreFilmScenario)|(wdt:genreFilmTreatment)|(wdt:genreFilmScreenplay)|(wdt:genrePoem)|(wdt:genreNovel)|(wdt:genreNovelSerial))$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@target,'^((wdt:genreShortStory)|(wdt:genreNF)|(wdt:genreNFAuto)|(wdt:genreNFDedication)|(wdt:genreNFLetter)|(wdt:genreNFInterview)|(wdt:genreNFIntroduction)|(wdt:genreNFEthnography)|(wdt:genreNFMiscellany)|(wdt:genreNFMiscellanyBlurb)|(wdt:genreFilm)|(wdt:genreFilmScenario)|(wdt:genreFilmTreatment)|(wdt:genreFilmScreenplay)|(wdt:genrePoem)|(wdt:genreNovel)|(wdt:genreNovelSerial))$')">
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
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="tei:catRef[@scheme='wdt:exhibit']"
                 priority="1000"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:catRef[@scheme='wdt:exhibit']"/>
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
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:revisionDesc[@status]" priority="1000" mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:revisionDesc[@status]"/>
      <xsl:variable name="thisStatus" select="@status"/>
      <xsl:variable name="firstChange" select="tei:change[@status][1]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$firstChange/@status = $thisStatus"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="$firstChange/@status = $thisStatus">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: The status attribute must match the @status of the latest change element.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:revisionDesc[not(@status='empty')]"
                 priority="1000"
                 mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:revisionDesc[not(@status='empty')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(exists(//tei:text/descendant::tei:gap[@reason='noTranscriptionAvailable']))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not(exists(//tei:text/descendant::tei:gap[@reason='noTranscriptionAvailable']))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Only "empty" is allowed as a status for documents without transcriptions.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <!--PATTERN wea-change-calendar-calendar-check-change-constraint-rule-51-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:figure" priority="1000" mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:figure"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:*"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="tei:*">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All figures should have at least one element in it.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:figure[ancestor::tei:div[@type='listFigure']]"
                 priority="1000"
                 mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:figure[ancestor::tei:div[@type='listFigure']]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@type">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Every figure in the figure database must have an @type value.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:figure[ancestor::tei:div[@type='listFigure']][not(@type='generated')]"
                 priority="1000"
                 mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:figure[ancestor::tei:div[@type='listFigure']][not(@type='generated')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:head and tei:figDesc and tei:bibl"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="tei:head and tei:figDesc and tei:bibl">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: Every figure in the media database must include a head element, a figDesc element, and a bibl element.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <!--PATTERN wea-link-linkTargets3-constraint-assert-53-->
   <!--RULE -->
   <xsl:template match="tei:link" priority="1000" mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:link"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="contains(normalize-space(@target),' ')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(normalize-space(@target),' ')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>You must supply at least two values for @target or  on <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/>
               </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <!--PATTERN wea-ab-abstractModel-structure-ab-in-l-or-lg-constraint-report-13-->
   <!--RULE -->
   <xsl:template match="tei:ab" priority="1000" mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:ab"/>
      <!--REPORT -->
      <xsl:if test="(ancestor::tei:l or ancestor::tei:lg) and not( ancestor::tei:floatingText |parent::tei:figure |parent::tei:note )">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="(ancestor::tei:l or ancestor::tei:lg) and not( ancestor::tei:floatingText |parent::tei:figure |parent::tei:note )">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Lines may not contain higher-level divisions such as p or ab, unless ab is a child of figure or note, or is a descendant of floatingText.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <!--PATTERN wea-msIdentifier-msId_minimal-constraint-report-14-->
   <!--RULE -->
   <xsl:template match="tei:msIdentifier" priority="1000" mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:msIdentifier"/>
      <!--REPORT -->
      <xsl:if test="not(parent::tei:msPart) and (local-name(*[1])='idno' or local-name(*[1])='altIdentifier' or normalize-space(.)='')">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(parent::tei:msPart) and (local-name(*[1])='idno' or local-name(*[1])='altIdentifier' or normalize-space(.)='')">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>An msIdentifier must contain either a repository or location.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <!--PATTERN wea-orgName-calendar-calendar-check-orgName-constraint-rule-55-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <!--PATTERN wea-persName-calendar-check-persName-constraint-rule-56-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <!--PATTERN wea-persName-calendar-calendar-check-persName-constraint-rule-57-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M71">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <!--PATTERN wea-placeName-calendar-calendar-check-placeName-constraint-rule-58-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <!--PATTERN wea-birth-calendar-calendar-check-birth-constraint-rule-59-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <!--PATTERN wea-death-calendar-calendar-check-death-constraint-rule-60-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M74">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <!--PATTERN wea-event-calendar-calendar-check-event-constraint-rule-61-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M75">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
            systems or calendars to which the date represented by the content of this element belongs,
            but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <!--PATTERN wea-location-calendar-calendar-check-location-constraint-rule-62-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M76">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <!--PATTERN wea-nationality-calendar-calendar-check-nationality-constraint-rule-63-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M77">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <!--PATTERN wea-occupation-calendar-calendar-check-occupation-constraint-rule-64-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M78">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@calendar]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length( normalize-space(.) ) gt 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="string-length( normalize-space(.) ) gt 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element has no textual content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:person[ancestor::tei:figure]" priority="1000" mode="M79">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:person[ancestor::tei:figure]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@corresp and normalize-space(string-join(descendant::text())) =''"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@corresp and normalize-space(string-join(descendant::text())) =''">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: People referenced in figures should only contain an @corresp to the person 
                                 in question and no content.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:*[some $r in @* satisfies matches($r,'pers:')]"
                 priority="1000"
                 mode="M80">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:*[some $r in @* satisfies matches($r,'pers:')]"/>
      <xsl:variable name="atts"
                    select="for $a in @* return if (contains($a,'pers:')) then tokenize($a,'\s+') else ()"/>
      <xsl:variable name="vals"
                    select="for $a in $atts return if (starts-with($a,'pers:')) then $a else ()"/>
      <xsl:variable name="errors"
                    select="for $v in $vals return if (matches($v,'^pers:[A-Z]+\d+$')) then () else $v"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty($errors)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty($errors)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All pers pointers (i.e. the string after 'pers:') must be a sequence of capital letters and a digit (bad val: <xsl:text/>
                  <xsl:value-of select="string-join($errors,' ')"/>
                  <xsl:text/>)
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="@*|node()" priority="-2" mode="M80">
      <xsl:apply-templates select="*" mode="M80"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:person[@role]" priority="1000" mode="M81">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:person[@role]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:figure"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ancestor::tei:figure">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: The @role attribute is only allowed on person in the context of a figure.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="@*|node()" priority="-2" mode="M81">
      <xsl:apply-templates select="*" mode="M81"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:person[ancestor::tei:listPerson and ancestor::tei:figure]"
                 priority="1000"
                 mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:person[ancestor::tei:listPerson and ancestor::tei:figure]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@role"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@role">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: All people in a listPerson in a figure should have a @role attribute.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="@*|node()" priority="-2" mode="M82">
      <xsl:apply-templates select="*" mode="M82"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:div[@type='listFigure']/tei:*"
                 priority="1000"
                 mode="M83">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:div[@type='listFigure']/tei:*"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="self::tei:div[@type='listFigure'] or self::tei:figure"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="self::tei:div[@type='listFigure'] or self::tei:figure">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                                 ERROR: listFigure divs should only contain figures or itself.
                              </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="@*|node()" priority="-2" mode="M83">
      <xsl:apply-templates select="*" mode="M83"/>
   </xsl:template>
   <!--PATTERN wea-div-abstractModel-structure-div-in-l-or-lg-constraint-report-15-->
   <!--RULE -->
   <xsl:template match="tei:div" priority="1000" mode="M84">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:div"/>
      <!--REPORT -->
      <xsl:if test="(ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText)">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="(ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText)">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: Lines may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M84"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M84"/>
   <xsl:template match="@*|node()" priority="-2" mode="M84">
      <xsl:apply-templates select="*" mode="M84"/>
   </xsl:template>
   <!--PATTERN wea-div-abstractModel-structure-div-in-ab-or-p-constraint-report-16-->
   <!--RULE -->
   <xsl:template match="tei:div" priority="1000" mode="M85">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:div"/>
      <!--REPORT -->
      <xsl:if test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>
        Abstract model violation: p and ab may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M85"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M85"/>
   <xsl:template match="@*|node()" priority="-2" mode="M85">
      <xsl:apply-templates select="*" mode="M85"/>
   </xsl:template>
   <!--PATTERN wea-att.global.facs-facs.mustStartWithFacs-constraint-rule-70-->
   <!--RULE -->
   <xsl:template match="tei:*[@facs]" priority="1000" mode="M86">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:*[@facs]"/>
      <xsl:variable name="tokens" select="tokenize(@facs,'\s+')"/>
      <xsl:variable name="facsRegex" select="'^facs:.+'"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $t in $tokens satisfies (matches($t,$facsRegex) and not(matches($t,'\..+$')))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $t in $tokens satisfies (matches($t,$facsRegex) and not(matches($t,'\..+$')))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: All facsimile pointers should start with facs: and not include the file extension.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M86"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M86"/>
   <xsl:template match="@*|node()" priority="-2" mode="M86">
      <xsl:apply-templates select="*" mode="M86"/>
   </xsl:template>
   <!--PATTERN wea-subst-substContents1-constraint-assert-70-->
   <!--RULE -->
   <xsl:template match="tei:subst" priority="1000" mode="M87">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:subst"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="child::tei:add and (child::tei:del or child::tei:surplus)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="child::tei:add and (child::tei:del or child::tei:surplus)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                  <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> must have at least one child add and at least one child del or surplus</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="@*|node()" priority="-2" mode="M87">
      <xsl:apply-templates select="*" mode="M87"/>
   </xsl:template>
   <!--PATTERN -->
   <xsl:variable name="spaceRegex" select="'(^\s)|(\s$)'"/>
   <xsl:variable name="docId" select="root(/)/tei:*/@xml:id"/>
   <xsl:variable name="docUri" select="document-uri(/)"/>
   <xsl:variable name="docIds" select="//tei:*[@xml:id]/@xml:id"/>
   <xsl:variable name="docTypes" select="//tei:catRef/@target"/>
   <xsl:variable name="docStatus" select="//tei:revisionDesc/@status"/>
   <xsl:variable name="isDocumentation"
                 select="some $r in $docTypes satisfies matches($r,'Documentation')"/>
   <xsl:variable name="isFilm"
                 select="some $r in $docTypes satisfies matches($r,'Film')"/>
   <xsl:variable name="thisUri" select="document-uri(/)"/>
   <xsl:variable name="thisProjectDir"
                 select="if (matches($thisUri,'/data/')) then (substring-before($thisUri,'/data/') || '/data/') else replace($thisUri,'[^/]+$','')"/>
   <xsl:variable name="theseDocs"
                 select="uri-collection(concat(substring-after($thisProjectDir,'file:'),'?select=*.xml;skip-errors=true;recurse=yes'))"/>
   <xsl:variable name="allDocIds"
                 select="for $doc in $theseDocs return replace($doc,'.+/([^/]+)\.xml', '$1')"/>
   <xsl:variable name="peopleIds"
                 select="document($theseDocs[matches(.,'people.xml$')][1])//tei:person/@xml:id/xs:string(.)"/>
   <xsl:variable name="orgIds"
                 select="document($theseDocs[matches(.,'organizations.xml')][1])//tei:org/@xml:id/xs:string(.)"/>
   <xsl:template match="text()" priority="-1" mode="M88"/>
   <xsl:template match="@*|node()" priority="-2" mode="M88">
      <xsl:apply-templates select="*" mode="M88"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/tei:TEI[not(ancestor::tei:teiCorpus)] | /tei:teiCorpus"
                 priority="1000"
                 mode="M89">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/tei:TEI[not(ancestor::tei:teiCorpus)] | /tei:teiCorpus"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@xml:id and matches($docUri,concat('[/\\]',$docId,'.\w+$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@xml:id and matches($docUri,concat('[/\\]',$docId,'.\w+$'))">
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
      <xsl:apply-templates select="*" mode="M89"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M89"/>
   <xsl:template match="@*|node()" priority="-2" mode="M89">
      <xsl:apply-templates select="*" mode="M89"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:name[@ref] | tei:change[@who] | tei:rs[@ref] | tei:*[@resp]"
                 priority="1000"
                 mode="M90">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:name[@ref] | tei:change[@who] | tei:rs[@ref] | tei:*[@resp]"/>
      <xsl:variable name="att"
                    select="if (@ref) then @ref else if (@who) then @who else @resp"/>
      <xsl:variable name="errors"
                    select="for $i in tokenize($att,'\s+') return if (matches($i,'^(pers:|https://dcs|#)')) then () else $i"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty($errors)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty($errors)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> ERROR: All personography pointers must start with the pers: prefix.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="@*|node()" priority="-2" mode="M90">
      <xsl:apply-templates select="*" mode="M90"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:linkGrp | tei:link" priority="1001" mode="M91">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:linkGrp | tei:link"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:TEI/@xml:id = 'redirects'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="ancestor::tei:TEI/@xml:id = 'redirects'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: Only use <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> in the redirects file.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="tei:link" priority="1000" mode="M91">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:link"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@target and count(tokenize(@target,'\s+')) = 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@target and count(tokenize(@target,'\s+')) = 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: Link must have an @target attribute with two pointers.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M91"/>
   <xsl:template match="@*|node()" priority="-2" mode="M91">
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:publisher[@ref]" priority="1000" mode="M92">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:publisher[@ref]"/>
      <xsl:variable name="errors"
                    select="for $i in tokenize(@ref,'\s+') return if (matches($i,'^org:')) then () else $i"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty($errors)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty($errors)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> ERROR: All org pointers must start with the org: prefix.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M92"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M92"/>
   <xsl:template match="@*|node()" priority="-2" mode="M92">
      <xsl:apply-templates select="*" mode="M92"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:change[@who]" priority="1000" mode="M93">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:change[@who]"/>
      <xsl:variable name="errors"
                    select="tokenize(@who,'\s+')[not(matches(.,'^pers:[A-Z]{2}\d+$'))]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty($errors)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty($errors)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>ERROR: Bad @who value for this change element: <xsl:text/>
                  <xsl:value-of select="string-join($errors,' ')"/>
                  <xsl:text/>
               </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M93"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M93"/>
   <xsl:template match="@*|node()" priority="-2" mode="M93">
      <xsl:apply-templates select="*" mode="M93"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:*[not(ancestor-or-self::tei:code)][text()][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"
                 priority="1000"
                 mode="M94">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:*[not(ancestor-or-self::tei:code)][text()][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"/>
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
      <xsl:apply-templates select="*" mode="M94"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M94"/>
   <xsl:template match="@*|node()" priority="-2" mode="M94">
      <xsl:apply-templates select="*" mode="M94"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:TEI[descendant::tei:catRef[contains(@target,'Poem')]][not(descendant::tei:revisionDesc/@status='empty')]"
                 priority="1000"
                 mode="M95">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:TEI[descendant::tei:catRef[contains(@target,'Poem')]][not(descendant::tei:revisionDesc/@status='empty')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="descendant::tei:text[descendant::tei:lg or descendant::tei:l or descendant::tei:gap[@reason=('readyForProof','inProgress')]]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::tei:text[descendant::tei:lg or descendant::tei:l or descendant::tei:gap[@reason=('readyForProof','inProgress')]]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: This document is classified as a poem, but there are no line groups (&lt;lg&gt;) or lines (&lt;l&gt;).
                              Ensure that you do not use paragraph tags if it is a poem. 
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M95"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M95"/>
   <xsl:template match="@*|node()" priority="-2" mode="M95">
      <xsl:apply-templates select="*" mode="M95"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:text[@next or @prev]" priority="1000" mode="M96">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:text[@next or @prev]"/>
      <xsl:variable name="errors"
                    select="for $r in (@next,@prev) return if (substring-after($r,'doc:')=$docId) then $r else ()"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty($errors)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty($errors)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                              ERROR: Next and prev should point to a different document (i.e. a different installment), but they contain the value(s) <xsl:text/>
                  <xsl:value-of select="string-join($errors,' ')"/>
                  <xsl:text/>.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="@*|node()" priority="-2" mode="M96">
      <xsl:apply-templates select="*" mode="M96"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:name | tei:ref[not(descendant::tei:graphic)] | tei:title | tei:l | tei:orgName | tei:persName/tei:reg"
                 priority="1000"
                 mode="M97">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:name | tei:ref[not(descendant::tei:graphic)] | tei:title | tei:l | tei:orgName | tei:persName/tei:reg"/>
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
      <xsl:apply-templates select="*" mode="M97"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M97"/>
   <xsl:template match="@*|node()" priority="-2" mode="M97">
      <xsl:apply-templates select="*" mode="M97"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:name" priority="1000" mode="M98">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="tei:name"/>
      <xsl:variable name="text" select="string-join(descendant::text(),'')"/>
      <!--ASSERT warning-->
      <xsl:choose>
         <xsl:when test="if (matches($text,'^(\w\.)+$')) then true() else not(matches($text,'\.$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (matches($text,'^(\w\.)+$')) then true() else not(matches($text,'\.$'))">
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
      <xsl:apply-templates select="*" mode="M98"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M98"/>
   <xsl:template match="@*|node()" priority="-2" mode="M98">
      <xsl:apply-templates select="*" mode="M98"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:q[not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"
                 priority="1000"
                 mode="M99">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:q[not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"/>
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
                              ERROR: Trailing punctuation should go outside the <xsl:text/>
                  <xsl:value-of select="name(.)"/>
                  <xsl:text/> element.
                           </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M99"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M99"/>
   <xsl:template match="@*|node()" priority="-2" mode="M99">
      <xsl:apply-templates select="*" mode="M99"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:body[not($isDocumentation)] | tei:*[not(self::tei:code)][text()][normalize-space(string-join(text(),'')) ne ''][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"
                 priority="1000"
                 mode="M100">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:body[not($isDocumentation)] | tei:*[not(self::tei:code)][text()][normalize-space(string-join(text(),'')) ne ''][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"/>
      <xsl:variable name="thisText"
                    select="if (self::tei:body) then string-join(descendant::text()[not(ancestor::tei:code)],'') else string-join(text()[not(ancestor::tei:code)],'')"/>
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
      <xsl:apply-templates select="*" mode="M100"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M100"/>
   <xsl:template match="@*|node()" priority="-2" mode="M100">
      <xsl:apply-templates select="*" mode="M100"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:bibl[ancestor::tei:div[@xml:id='bibliography_we']]"
                 priority="1000"
                 mode="M101">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:bibl[ancestor::tei:div[@xml:id='bibliography_we']]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@xml:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@xml:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>ERROR: QUICKFIX: All WE bibls need an id. Click the red lightbulb to the left to add one. </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@xml:id and matches(@xml:id,'^bibl\d+$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="@xml:id and matches(@xml:id,'^bibl\d+$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>ERROR: QUICKFIX: All WE bibls need a bibl id in the format bibl#. Click the red lightbulb to the left to replace the current id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M101"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M101"/>
   <xsl:template match="@*|node()" priority="-2" mode="M101">
      <xsl:apply-templates select="*" mode="M101"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:body[not($isDocumentation)] | tei:*[text()][not(self::tei:code)][normalize-space(string-join(text(),'')) ne ''][not($isDocumentation)][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"
                 priority="1000"
                 mode="M102">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:body[not($isDocumentation)] | tei:*[text()][not(self::tei:code)][normalize-space(string-join(text(),'')) ne ''][not($isDocumentation)][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"/>
      <xsl:variable name="thisText"
                    select="if (self::tei:body) then string-join(descendant::text()[not(ancestor::tei:code)],'') else string-join(text()[not(ancestor::tei:code)],'')"/>
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
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M102"/>
   <xsl:template match="@*|node()" priority="-2" mode="M102">
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:body | tei:div | tei:lg" priority="1000" mode="M103">
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
      <xsl:apply-templates select="*" mode="M103"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M103"/>
   <xsl:template match="@*|node()" priority="-2" mode="M103">
      <xsl:apply-templates select="*" mode="M103"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:body[not($isDocumentation)] | tei:*[text()][not(normalize-space(string-join(text(),''))='')][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"
                 priority="1000"
                 mode="M104">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="tei:body[not($isDocumentation)] | tei:*[text()][not(normalize-space(string-join(text(),''))='')][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]"/>
      <xsl:variable name="text"
                    select="string-join(descendant::text()[not(ancestor::tei:code)],'')"/>
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
      <xsl:apply-templates select="*" mode="M104"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M104"/>
   <xsl:template match="@*|node()" priority="-2" mode="M104">
      <xsl:apply-templates select="*" mode="M104"/>
   </xsl:template>
</xsl:stylesheet>
