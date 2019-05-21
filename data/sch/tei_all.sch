<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:rng="http://relaxng.org/ns/structure/1.0"
            queryBinding="xslt2">
   <ns xmlns="http://purl.oclc.org/dsdl/schematron"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns:tei="http://www.tei-c.org/ns/1.0"
       xmlns:teix="http://www.tei-c.org/ns/Examples"
       prefix="tei"
       uri="http://www.tei-c.org/ns/1.0"/>
   <ns xmlns="http://purl.oclc.org/dsdl/schematron"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns:tei="http://www.tei-c.org/ns/1.0"
       xmlns:teix="http://www.tei-c.org/ns/Examples"
       prefix="xs"
       uri="http://www.w3.org/2001/XMLSchema"/>
   <ns xmlns="http://purl.oclc.org/dsdl/schematron"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns:tei="http://www.tei-c.org/ns/1.0"
       xmlns:teix="http://www.tei-c.org/ns/Examples"
       prefix="rng"
       uri="http://relaxng.org/ns/structure/1.0"/>
   <ns xmlns="http://purl.oclc.org/dsdl/schematron"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns:tei="http://www.tei-c.org/ns/1.0"
       xmlns:teix="http://www.tei-c.org/ns/Examples"
       prefix="s"
       uri="http://www.ascc.net/xml/schematron"/>
   <ns xmlns="http://purl.oclc.org/dsdl/schematron"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns:tei="http://www.tei-c.org/ns/1.0"
       xmlns:teix="http://www.tei-c.org/ns/Examples"
       prefix="sch"
       uri="http://purl.oclc.org/dsdl/schematron"/>
   <ns xmlns="http://purl.oclc.org/dsdl/schematron"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns:tei="http://www.tei-c.org/ns/1.0"
       xmlns:teix="http://www.tei-c.org/ns/Examples"
       prefix="teix"
       uri="http://www.tei-c.org/ns/Examples"/>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="d9e120193-constraint">
         <rule context="tei:content">
            <report test="descendant::*[not(namespace-uri(.) =               ('http://relaxng.org/ns/structure/1.0', 'http://www.tei-c.org/ns/1.0'))]">content descendants must be in the
              namespaces
              'http://relaxng.org/ns/structure/1.0', 'http://www.tei-c.org/ns/1.0'</report>
         </rule>
      </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="d9e121478-constraint">
         <rule context="tei:datatype">
            <report test="descendant::*[not(namespace-uri(.) =               ('http://relaxng.org/ns/structure/1.0', 'http://www.tei-c.org/ns/1.0'))]">datatype descendants must be in the
              namespaces
              'http://relaxng.org/ns/structure/1.0', 'http://www.tei-c.org/ns/1.0'</report>
         </rule>
      </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.datable.w3c-att-datable-w3c-when-constraint-rule-1">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@when]">
        <sch:report test="@notBefore|@notAfter|@from|@to" role="nonfatal">The @when attribute cannot be used with any other att.datable.w3c attributes.</sch:report>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.datable.w3c-att-datable-w3c-from-constraint-rule-2">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@from]">
        <sch:report test="@notBefore" role="nonfatal">The @from and @notBefore attributes cannot be used together.</sch:report>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.datable.w3c-att-datable-w3c-to-constraint-rule-3">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@to]">
        <sch:report test="@notAfter" role="nonfatal">The @to and @notAfter attributes cannot be used together.</sch:report>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.datable-calendar-calendar-constraint-rule-4">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@calendar]">
            <sch:assert test="string-length(.) gt 0">
@calendar indicates the system or calendar to which the date represented by the content of this element
belongs, but this <sch:name/> element has no textual content.</sch:assert>
          </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.typed-subtypeTyped-constraint-rule-5">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@subtype]">
        <sch:assert test="@type">The <sch:name/> element should not be categorized in detail with @subtype unless also categorized in general with @type</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.pointing-targetLang-targetLang-constraint-rule-6">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[not(self::tei:schemaSpec)][@targetLang]">
            <sch:assert test="@target">@targetLang should only be used on <sch:name/> if @target is specified.</sch:assert>
          </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.spanning-spanTo-spanTo-2-constraint-rule-7">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@spanTo]">
            <sch:assert test="id(substring(@spanTo,2)) and following::*[@xml:id=substring(current()/@spanTo,2)]">
The element indicated by @spanTo (<sch:value-of select="@spanTo"/>) must follow the current element <sch:name/>
                  </sch:assert>
          </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-8">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@schemeVersion]">
            <sch:assert test="@scheme and not(@scheme = 'free')">
              @schemeVersion can only be used if @scheme is specified.
            </sch:assert>
          </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-p-abstractModel-structure-p-constraint-report-5">
            <rule context="tei:p">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum                |parent::tei:item                |parent::tei:note                |parent::tei:q                |parent::tei:quote                |parent::tei:remarks                |parent::tei:said                |parent::tei:sp                |parent::tei:stage                |parent::tei:cell                |parent::tei:figure                )">
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-p-abstractModel-structure-l-constraint-report-6">
            <rule context="tei:p">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="ancestor::tei:l[not(.//tei:note//tei:p[. = current()])]">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-desc-deprecationInfo-only-in-deprecated-constraint-rule-10">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:desc[ @type eq 'deprecationInfo']">
	              <sch:assert test="../@validUntil">Information about a
	deprecation should only be present in a specification element
	that is being deprecated: that is, only an element that has a
	@validUntil attribute should have a child &lt;desc
	type="deprecationInfo"&gt;.</sch:assert>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-ptr-ptrAtts-constraint-report-7">
            <rule context="tei:ptr">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@target and @cRef">Only one of the
attributes @target and @cRef may be supplied on <name/>.</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-ref-refAtts-constraint-report-8">
            <rule context="tei:ref">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@target and @cRef">Only one of the
	attributes @target' and @cRef' may be supplied on <name/>
               </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-list-gloss-list-must-have-labels-constraint-rule-11">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:list[@type='gloss']">
	              <sch:assert test="tei:label">The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element</sch:assert>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-relatedItem-targetorcontent1-constraint-report-9">
            <rule context="tei:relatedItem">
               <sch:report xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="@target and count( child::* ) &gt; 0">
If the @target attribute on <sch:name/> is used, the
relatedItem element must be empty</sch:report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-relatedItem-targetorcontent1-constraint-assert-8">
            <rule context="tei:relatedItem">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="@target or child::*">A relatedItem element should have either a 'target' attribute
        or a child element to indicate the related bibliographic item</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-l-abstractModel-structure-l-constraint-report-10">
            <rule context="tei:l">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
        Abstract model violation: Lines may not contain lines or lg elements.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-lg-atleast1oflggapl-constraint-assert-9">
            <rule context="tei:lg">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0">An lg element
        must contain at least one child l, lg or gap element.</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-lg-abstractModel-structure-l-constraint-report-11">
            <rule context="tei:lg">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
        Abstract model violation: Lines may not contain line groups.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-s-noNestedS-constraint-report-12">
            <rule context="tei:s">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="tei:s">You may not nest one s element within
      another: use seg instead</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-span-targetfrom-constraint-report-13">
            <rule context="tei:span">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@from and @target">
Only one of the attributes @target and @from may be supplied on <name/>
               </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-span-targetto-constraint-report-14">
            <rule context="tei:span">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@to and @target">
Only one of the attributes @target and @to may be supplied on <name/>
               </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-span-tonotfrom-constraint-report-15">
            <rule context="tei:span">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@to and not(@from)">
If @to is supplied on <name/>, @from must be supplied as well</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-span-tofrom-constraint-report-16">
            <rule context="tei:span">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="contains(normalize-space(@to),' ') or contains(normalize-space(@from),' ')">
The attributes @to and @from on <name/> may each contain only a single value</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-quotation-quotationContents-constraint-report-17">
            <rule context="tei:quotation">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="not(@marks) and not (tei:p)">
On <name/>, either the @marks attribute should be used, or a paragraph of description provided</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-link-linkTargets3-constraint-assert-10">
            <rule context="tei:link">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="contains(normalize-space(@target),' ')">You must supply at least two values for @target or  on <sch:name/>
               </sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-ab-abstractModel-structure-ab-constraint-report-18">
            <rule context="tei:ab">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum         |parent::tei:item         |parent::tei:note         |parent::tei:q         |parent::tei:quote         |parent::tei:remarks         |parent::tei:said         |parent::tei:sp         |parent::tei:stage         |parent::tei:cell         |parent::tei:figure)">
        Abstract model violation: ab may not occur inside paragraphs or other ab elements.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-ab-abstractModel-structure-l-constraint-report-19">
            <rule context="tei:ab">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="ancestor::tei:l or ancestor::tei:lg">
        Abstract model violation: Lines may not contain higher-level divisions such as p or ab.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-join-joinTargets3-constraint-assert-11">
            <rule context="tei:join">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="contains(@target,' ')">
You must supply at least two values for @target on <name/>
               </assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-catchwords-catchword_in_msDesc-constraint-assert-12">
            <rule context="tei:catchwords">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="ancestor::tei:msDesc or ancestor::tei:egXML">The <sch:name/> element should not be used outside of msDesc.</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-dimensions-duplicateDim-constraint-report-20">
            <rule context="tei:dimensions">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="count(tei:width)&gt; 1">
The element <name/> may appear once only
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-dimensions-duplicateDim-constraint-report-21">
            <rule context="tei:dimensions">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="count(tei:height)&gt; 1">
The element <name/> may appear once only
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-dimensions-duplicateDim-constraint-report-22">
            <rule context="tei:dimensions">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="count(tei:depth)&gt; 1">
The element <name/> may appear once only
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-secFol-secFol_in_msDesc-constraint-assert-13">
            <rule context="tei:secFol">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="ancestor::tei:msDesc or ancestor::tei:egXML">The <sch:name/> element should not be used outside of msDesc.</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-signatures-signatures_in_msDesc-constraint-assert-14">
            <rule context="tei:signatures">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="ancestor::tei:msDesc or ancestor::tei:egXML">The <sch:name/> element should not be used outside of msDesc.</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-msIdentifier-msId_minimal-constraint-report-23">
            <rule context="tei:msIdentifier">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="not(parent::tei:msPart) and (local-name(*[1])='idno' or local-name(*[1])='altIdentifier' or normalize-space(.)='')">An msIdentifier must contain either a repository or location.</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-relation-reforkeyorname-constraint-assert-15">
            <rule context="tei:relation">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@ref or @key or @name">One of the attributes  'name', 'ref' or 'key' must be supplied</assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-relation-activemutual-constraint-report-24">
            <rule context="tei:relation">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@active and @mutual">Only one of the attributes @active and @mutual may be supplied</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-relation-activepassive-constraint-report-25">
            <rule context="tei:relation">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@passive and not(@active)">the attribute 'passive' may be supplied only if the attribute 'active' is supplied</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-objectIdentifier-objectIdentifier_minimal-constraint-report-26">
            <rule context="tei:objectIdentifier">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="not(count(*) gt 0)">An objectIdentifier must contain at minimum a single piece of locating or identifying information.</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-shift-shiftNew-constraint-assert-16">
            <rule context="tei:shift">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@new"
                 role="warning">              
The @new attribute should always be supplied; use the special value
"normal" to indicate that the feature concerned ceases to be
remarkable at this point.</assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-rdgGrp-only1lem-constraint-assert-17">
            <rule context="tei:rdgGrp">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="count(tei:lem) &lt; 2">Only one &lt;lem&gt; element may appear within a &lt;rdgGrp&gt;</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-variantEncoding-location-variantEncodingLocation-constraint-rule-12">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:variantEncoding">
               <sch:assert test="(@location != 'external') or (@method != 'parallel-segmentation')">
              The @location value "external" is inconsistent with the
              parallel-segmentation method of apparatus markup.</sch:assert>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-div-abstractModel-structure-l-constraint-report-27">
            <rule context="tei:div">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="ancestor::tei:l">
        Abstract model violation: Lines may not contain higher-level structural elements such as div.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-div-abstractModel-structure-p-constraint-report-28">
            <rule context="tei:div">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="ancestor::tei:p or ancestor::tei:ab and not(ancestor::tei:floatingText)">
        Abstract model violation: p and ab may not contain higher-level structural elements such as div.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-path-pathmustnotbeclosed-constraint-rule-13">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:path[@points]">
        
               <sch:let name="firstPair" value="tokenize( normalize-space( @points ), ' ')[1]"/>
               <sch:let name="lastPair"
                  value="tokenize( normalize-space( @points ), ' ')[last()]"/>
               <sch:let name="firstX" value="xs:float( substring-before( $firstPair, ',') )"/>
               <sch:let name="firstY" value="xs:float( substring-after( $firstPair, ',') )"/>
               <sch:let name="lastX" value="xs:float( substring-before( $lastPair, ',') )"/>
               <sch:let name="lastY" value="xs:float( substring-after( $lastPair, ',') )"/>
               <sch:report test="$firstX eq $lastX  and  $firstY eq $lastY">The first and
          last elements of this path are the same. To specify a closed polygon, use
          the zone element rather than the path element. </sch:report>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-addSpan-spanTo-constraint-assert-19">
            <rule context="tei:addSpan">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="@spanTo">The @spanTo attribute of <sch:name/> is required.</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-addSpan-spanTo_fr-constraint-assert-20">
            <rule context="tei:addSpan">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="@spanTo">L'attribut spanTo est requis.</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-damageSpan-spanTo-constraint-assert-21">
            <rule context="tei:damageSpan">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@spanTo">
The @spanTo attribute of <name/> is required.</assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-damageSpan-spanTo_fr-constraint-assert-22">
            <rule context="tei:damageSpan">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@spanTo">L'attribut spanTo est requis.</assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-delSpan-spanTo-constraint-assert-23">
            <rule context="tei:delSpan">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@spanTo">The @spanTo attribute of <name/> is required.</assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-delSpan-spanTo_fr-constraint-assert-24">
            <rule context="tei:delSpan">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="@spanTo">L'attribut spanTo est requis.</assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-subst-substContents1-constraint-assert-25">
            <rule context="tei:subst">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="child::tei:add and child::tei:del">
                  <name/> must have at least one child add and at least one child del</assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.repeatable-MINandMAXoccurs-constraint-rule-14">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="*[ @minOccurs  and  @maxOccurs ]">
        <sch:let name="min" value="@minOccurs cast as xs:integer"/>
        <sch:let name="max"
                  value="if ( normalize-space( @maxOccurs ) eq 'unbounded')                         then -1                         else @maxOccurs cast as xs:integer"/>
        <sch:assert test="$max eq -1  or  $max ge $min">@maxOccurs should be greater than or equal to @minOccurs</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.repeatable-MINandMAXoccurs-constraint-rule-15">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="*[ @minOccurs  and  not( @maxOccurs ) ]">
        <sch:assert test="@minOccurs cast as xs:integer lt 2">When @maxOccurs is not specified, @minOccurs must be 0 or 1</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.identified-spec-in-module-constraint-rule-16">
      <rule xmlns:xi="http://www.w3.org/2001/XInclude"
            xmlns:svg="http://www.w3.org/2000/svg"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:math="http://www.w3.org/1998/Math/MathML"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
            context="tei:elementSpec[@module]|tei:classSpec[@module]|tei:macroSpec[@module]">
        <assert test="         (not(ancestor::tei:schemaSpec | ancestor::tei:TEI | ancestor::tei:teiCorpus)) or         (not(@module) or          (not(//tei:moduleSpec) and not(//tei:moduleRef))  or         (//tei:moduleSpec[@ident = current()/@module]) or          (//tei:moduleRef[@key = current()/@module]))         ">
        Specification <value-of select="@ident"/>: the value of the module attribute ("<value-of select="@module"/>") 
should correspond to an existing module, via a moduleSpec or
      moduleRef</assert>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.deprecated-validUntil-deprecation-two-month-warning-constraint-rule-17">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@validUntil]">
            <sch:let name="advance_warning_period"
                  value="current-date() + xs:dayTimeDuration('P60D')"/>
            <sch:let name="me_phrase"
                  value="if (@ident)                                                then concat('The ', @ident )                                                else concat('This ',                                                            local-name(.),                                                            ' of ',                                                            ancestor::tei:*[@ident][1]/@ident )"/>
            <sch:assert test="@validUntil cast as xs:date  ge  current-date()">
              <sch:value-of select="                  concat( $me_phrase,                          'construct is outdated (as of ',                          @validUntil,                          '); ODD processors may ignore it, and its use is no longer supported'                        )"/>
         </sch:assert>
              <sch:assert role="nonfatal"
                     test="@validUntil cast as xs:date  ge  $advance_warning_period">
                <sch:value-of select="concat( $me_phrase, ' construct becomes outdated on ', @validUntil )"/>
              </sch:assert>
          </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-att.deprecated-validUntil-deprecation-should-be-explained-constraint-rule-18">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@validUntil][ not( self::valDesc | self::valList | self::defaultVal )]">
            <sch:assert test="child::tei:desc[ @type eq 'deprecationInfo']">
              A deprecated construct should include, whenever possible, an explanation, but this <sch:value-of select="name(.)"/> does not have a child &lt;desc type="deprecationInfo"&gt;</sch:assert>
          </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-moduleRef-modref-constraint-rule-19">
            <rule xmlns:xi="http://www.w3.org/2001/XInclude"
            xmlns:svg="http://www.w3.org/2000/svg"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:math="http://www.w3.org/1998/Math/MathML"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
            context="tei:moduleRef">
               <report test="* and @key">
Child elements of <name/> are only allowed when an external module is being loaded
        </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-moduleRef-prefix-not-same-prefix-constraint-rule-20">
            <rule xmlns:xi="http://www.w3.org/2001/XInclude"
            xmlns:svg="http://www.w3.org/2000/svg"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:math="http://www.w3.org/1998/Math/MathML"
            xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
            context="tei:moduleRef">
               <report test="//*[ not( generate-id(.) eq generate-id(      current() ) ) ]/@prefix = @prefix">The prefix attribute
	    of <name/> should not match that of any other
	    element (it would defeat the purpose)</report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-model-no_dup_default_models-constraint-rule-21">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:model[ not( parent::tei:modelSequence ) ][ not( @predicate ) ]">
               <sch:let name="output" value="normalize-space( @output )"/>
               <sch:report test="following-sibling::tei:model                             [ not( @predicate )]                             [ normalize-space( @output ) eq $output ]">
          There are 2 (or more) 'model' elements in this '<sch:value-of select="local-name(..)"/>'
          that have no predicate, but are targeted to the same output
          ("<sch:value-of select="( $output, parent::modelGrp/@output, 'all')[1]"/>")</sch:report>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-model-no_dup_models-constraint-rule-22">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:model[ not( parent::tei:modelSequence ) ][ @predicate ]">
               <sch:let name="predicate" value="normalize-space( @predicate )"/>
               <sch:let name="output" value="normalize-space( @output )"/>
               <sch:report test="following-sibling::tei:model                             [ normalize-space( @predicate ) eq $predicate ]                             [ normalize-space( @output ) eq $output ]">
          There are 2 (or more) 'model' elements in this
          '<sch:value-of select="local-name(..)"/>' that have
          the same predicate, and are targeted to the same output
          ("<sch:value-of select="( $output, parent::modelGrp/@output, 'all')[1]"/>")</sch:report>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-modelSequence-no_outputs_nor_predicates_4_my_kids-constraint-report-34">
            <rule context="tei:modelSequence">
               <sch:report xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="tei:model[@output]"
                     role="warning">The 'model' children
      of a 'modelSequence' element inherit the @output attribute of the
      parent 'modelSequence', and thus should not have their own</sch:report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-content-empty-content-deprecated-constraint-assert-32">
            <rule context="tei:content">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="*">The use of the &lt;content&gt; element
      without any child elements is deprecated, and will be considered
      invalid after 2019-08-25. Use a child &lt;empty&gt; element to
      indicate that the element being specified is not allowed to have
      content.</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-sequence-sequencechilden-constraint-assert-33">
            <rule context="tei:sequence">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="count(*)&gt;1">The sequence element must have at least two child elements</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-alternate-alternatechilden-constraint-assert-34">
            <rule context="tei:alternate">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="count(*)&gt;1">The alternate element must have at least two child elements</sch:assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-constraintSpec-sch_no_more-constraint-report-35">
            <rule context="tei:constraintSpec">
               <sch:report xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="tei:constraint/s:*  and  @scheme = ('isoschematron','schematron')">Rules
        in the Schematron 1.* language must be inside a constraintSpec
        with a value other than 'schematron' or 'isoschematron' on the
        scheme attribute</sch:report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-constraintSpec-isosch-constraint-report-36">
            <rule context="tei:constraintSpec">
               <sch:report xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns="http://www.tei-c.org/ns/1.0"
                     test="tei:constraint/sch:*  and  not( @scheme eq 'schematron')">Rules
        in the ISO Schematron language must be inside a constraintSpec
        with the value 'schematron' on the scheme attribute</sch:report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-constraintSpec-needrules-constraint-rule-23">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:macroSpec/tei:constraintSpec[@scheme eq 'schematron']/tei:constraint">
               <sch:report test="sch:assert|sch:report">An ISO Schematron constraint specification for a macro should not
        have an 'assert' or 'report' element without a parent 'rule' element</sch:report>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-attDef-attDefContents-constraint-assert-37">
            <rule context="tei:attDef">
               <assert xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 test="ancestor::teix:egXML[@valid='feasible'] or @mode eq 'change' or @mode eq 'delete' or tei:datatype or tei:valList[@type='closed']">Attribute: the definition of the @<value-of select="@ident"/> attribute in the <value-of select="ancestor::*[@ident][1]/@ident"/>
                  <value-of select="' '"/>
                  <value-of select="local-name(ancestor::*[@ident][1])"/> should have a closed valList or a datatype</assert>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-attDef-noDefault4Required-constraint-rule-24">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:attDef[@usage eq 'req']">
               <sch:report test="tei:defaultVal">It does not make sense to make "<sch:value-of select="normalize-space(tei:defaultVal)"/>" the default value of @<sch:value-of select="@ident"/>, because that attribute is required.</sch:report>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-attDef-defaultIsInClosedList-twoOrMore-constraint-rule-25">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:attDef[   tei:defaultVal   and   tei:valList[@type eq 'closed']   and   tei:datatype[    @maxOccurs &gt; 1    or    @minOccurs &gt; 1    or    @maxOccurs = 'unbounded'    ]   ]">
               <sch:assert test="     tokenize(normalize-space(tei:defaultVal),' ')     =     tei:valList/tei:valItem/@ident">In the <sch:value-of select="local-name(ancestor::*[@ident][1])"/> defining
        <sch:value-of select="ancestor::*[@ident][1]/@ident"/> the default value of the
        @<sch:value-of select="@ident"/> attribute is not among the closed list of possible
        values</sch:assert>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-attDef-defaultIsInClosedList-one-constraint-rule-26">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:attDef[   tei:defaultVal   and   tei:valList[@type eq 'closed']   and   tei:datatype[    not(@maxOccurs)    or (    if ( @maxOccurs castable as xs:integer )     then ( @maxOccurs cast as xs:integer eq 1 )     else false()    )]   ]">
               <sch:assert test="string(tei:defaultVal)      =      tei:valList/tei:valItem/@ident">In the <sch:value-of select="local-name(ancestor::*[@ident][1])"/> defining
        <sch:value-of select="ancestor::*[@ident][1]/@ident"/> the default value of the
        @<sch:value-of select="@ident"/> attribute is not among the closed list of possible
        values</sch:assert>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-dataRef-restrictDataFacet-constraint-rule-27">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:dataRef[tei:dataFacet]">
               <sch:assert test="@name" role="nonfatal">Data facets can only be specified for references to datatypes specified by
          XML Schemas: Part 2: Datatypes</sch:assert>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="tei_all-dataRef-restrictAttRestriction-constraint-rule-28">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:dataRef[tei:dataFacet]">
               <sch:report test="@restriction" role="nonfatal">The attribute restriction cannot be used when dataFacet elements are present.</sch:report>
            </sch:rule>
         </pattern>
   <sch:diagnostics/>
</sch:schema>
