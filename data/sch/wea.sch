<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<sch:schema xmlns:rng="http://relaxng.org/ns/structure/1.0"
            xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            queryBinding="xslt2">
   <sch:ns xmlns="http://www.tei-c.org/ns/1.0"
           xmlns:math="http://www.w3.org/1998/Math/MathML"
           xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:tei="http://www.tei-c.org/ns/1.0"
           xmlns:teix="http://www.tei-c.org/ns/Examples"
           xmlns:xi="http://www.w3.org/2001/XInclude"
           xmlns:xlink="http://www.w3.org/1999/xlink"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           prefix="tei"
           uri="http://www.tei-c.org/ns/1.0"/>
   <sch:ns xmlns="http://www.tei-c.org/ns/1.0"
           xmlns:math="http://www.w3.org/1998/Math/MathML"
           xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:tei="http://www.tei-c.org/ns/1.0"
           xmlns:teix="http://www.tei-c.org/ns/Examples"
           xmlns:xi="http://www.w3.org/2001/XInclude"
           xmlns:xlink="http://www.w3.org/1999/xlink"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           prefix="xs"
           uri="http://www.w3.org/2001/XMLSchema"/>
   <sch:ns xmlns="http://www.tei-c.org/ns/1.0"
           xmlns:math="http://www.w3.org/1998/Math/MathML"
           xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:tei="http://www.tei-c.org/ns/1.0"
           xmlns:teix="http://www.tei-c.org/ns/Examples"
           xmlns:xi="http://www.w3.org/2001/XInclude"
           xmlns:xlink="http://www.w3.org/1999/xlink"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           prefix="rng"
           uri="http://relaxng.org/ns/structure/1.0"/>
   <sch:ns xmlns="http://www.tei-c.org/ns/1.0"
           xmlns:math="http://www.w3.org/1998/Math/MathML"
           xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:tei="http://www.tei-c.org/ns/1.0"
           xmlns:teix="http://www.tei-c.org/ns/Examples"
           xmlns:xi="http://www.w3.org/2001/XInclude"
           xmlns:xlink="http://www.w3.org/1999/xlink"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           prefix="rna"
           uri="http://relaxng.org/ns/compatibility/annotations/1.0"/>
   <sch:ns xmlns="http://www.tei-c.org/ns/1.0"
           xmlns:math="http://www.w3.org/1998/Math/MathML"
           xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:tei="http://www.tei-c.org/ns/1.0"
           xmlns:teix="http://www.tei-c.org/ns/Examples"
           xmlns:xi="http://www.w3.org/2001/XInclude"
           xmlns:xlink="http://www.w3.org/1999/xlink"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           prefix="sch"
           uri="http://purl.oclc.org/dsdl/schematron"/>
   <sch:ns xmlns="http://www.tei-c.org/ns/1.0"
           xmlns:math="http://www.w3.org/1998/Math/MathML"
           xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:tei="http://www.tei-c.org/ns/1.0"
           xmlns:teix="http://www.tei-c.org/ns/Examples"
           xmlns:xi="http://www.w3.org/2001/XInclude"
           xmlns:xlink="http://www.w3.org/1999/xlink"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           prefix="sch1x"
           uri="http://www.ascc.net/xml/schematron"/>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.datable.w3c-att-datable-w3c-when-constraint-rule-1">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@when]">
         <sch:report test="@notBefore|@notAfter|@from|@to" role="nonfatal">The @when attribute cannot be used with any other att.datable.w3c attributes.</sch:report>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.datable.w3c-att-datable-w3c-from-constraint-rule-2">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@from]">
         <sch:report test="@notBefore" role="nonfatal">The @from and @notBefore attributes cannot be used together.</sch:report>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.datable.w3c-att-datable-w3c-to-constraint-rule-3">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@to]">
         <sch:report test="@notAfter" role="nonfatal">The @to and @notAfter attributes cannot be used together.</sch:report>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.global.source-source-only_1_ODD_source-constraint-rule-4">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@source]">
         <sch:let name="srcs" value="tokenize( normalize-space(@source),' ')"/>
         <sch:report test="( self::tei:classRef               | self::tei:dataRef               | self::tei:elementRef               | self::tei:macroRef               | self::tei:moduleRef               | self::tei:schemaSpec )               and               $srcs[2]">
              When used on a schema description element (like
              <sch:value-of select="name(.)"/>), the @source attribute
              should have only 1 value. (This one has <sch:value-of select="count($srcs)"/>.)
            </sch:report>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.typed-subtypeTyped-constraint-rule-5">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@subtype]">
         <sch:assert test="@type">The <sch:name/> element should not be categorized in detail with @subtype unless also categorized in general with @type</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.pointing-targetLang-constraint-rule-6">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[not(self::tei:schemaSpec)][@targetLang]">
         <sch:assert test="@target">@targetLang should only be used on <sch:name/> if @target is specified.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-7">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@schemeVersion]">
         <sch:assert test="@scheme and not(@scheme = 'free')">
              @schemeVersion can only be used if @scheme is specified.
            </sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.calendarSystem-calendar-calendar-constraint-rule-8">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
              systems or calendars to which the date represented by the content of this element belongs,
              but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-p-abstractModel-structure-p-in-ab-or-p-constraint-report-5">
      <rule context="tei:p">
         <sch:report xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="(ancestor::tei:ab or ancestor::tei:p) and not( ancestor::tei:floatingText |parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure )">
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
      </sch:report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-p-abstractModel-structure-p-in-l-or-lg-constraint-report-6">
      <rule context="tei:p">
         <sch:report xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="(ancestor::tei:l or ancestor::tei:lg) and not( ancestor::tei:floatingText |parent::tei:figure |parent::tei:note )">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab, unless p is a child of figure or note, or is a descendant of floatingText.
      </sch:report>
      </rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:foreign">
         <sch:let name="text" value="string-join(text(),'')"/>
         <sch:assert test="not(matches($text,'^\s+|\s+$'))">
                                 ERROR: foreign elements should not begin or end with spaces.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:q[not(ancestor::tei:TEI/@xml:id='wea')]">
         <sch:let name="text" value="string-join(descendant::text(),'')"/>
         <sch:assert test="if (normalize-space(string-join(child::text())) ='') then true() else not(matches($text,'^\s+|\s+$'))">
                                 ERROR: q elements should not begin or end with spaces.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-desc-deprecationInfo-only-in-deprecated-constraint-rule-11">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:desc[ @type eq 'deprecationInfo']">
         <sch:assert test="../@validUntil">Information about a
        deprecation should only be present in a specification element
        that is being deprecated: that is, only an element that has a
        @validUntil attribute should have a child &lt;desc
        type="deprecationInfo"&gt;.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-name-calendar-check-name-constraint-rule-12">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-name-calendar-calendar-check-name-constraint-rule-13">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:ptr[@type='readMore']">
         <sch:assert test="ancestor::tei:TEI/@xml:id='index'">
                                 ERROR: Only use the ptr element in the index page,
                                 and it must have type='readMore'.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:ptr[@type='readMore'] | tei:link[parent::tei:linkGrp]">
         <sch:assert test="matches(@target,'^doc:')">
                                 ERROR: All <sch:name/> elements must have a @target attribute
                                 that points to a document using the doc: prefix.
                                 (ie. &lt;<sch:name/> target="doc:LiChingsBaby1"/&gt;)
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-ptr-ptrAtts-constraint-report-7">
      <rule context="tei:ptr">
         <report xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 test="@target and @cRef">Only one of the
attributes @target and @cRef may be supplied on <name/>.</report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-ref-refAtts-constraint-report-8">
      <rule context="tei:ref">
         <report xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 test="@target and @cRef">Only one of the
	attributes @target' and @cRef' may be supplied on <name/>
         </report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-list-gloss-list-must-have-labels-constraint-rule-16">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:list[@type='gloss']">
         <sch:assert test="tei:label">The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element</sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:note[@type='parenthetical']">
         <sch:assert test="ancestor::tei:q">
                                 ERROR: Parenthetical notes should only be used within the q element.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:note[ancestor::tei:q]">
         <sch:assert test="@type = ('parenthetical','editorial')">
                                 ERROR: Notes within the q element should have a type of either parenthetical
                                 or editorial.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-note-note.editorialOnesShouldFollowTrailingPunct-constraint-rule-19">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:note[@type='editorial']">
         <sch:let name="folText" value="following-sibling::text()[1]"/>
         <sch:assert test="not(matches($folText, '^[\.,\?:;]'))">
                              ERROR: Editorial notes should be placed after the trailing punctuation.
                           </sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:person/tei:note | tei:org/tei:note">
         <sch:assert test="tei:p">
                                 ERROR: All person and org notes must contain at least one paragraph.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:person/tei:note | tei:org/tei:note">
         <sch:let name="text" value="normalize-space(string-join(text(),''))"/>
         <sch:assert test="$text=''">
                                 ERROR: All textual content for person/org notes should be contained within a paragraph.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:graphic[ancestor::tei:div[@type='listFigure']]">
         <sch:assert test="@mimeType">
                                 ERROR: All media in the media database should use the @mimeType attribute to specify
                                 the source mimetype.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:*[@url]">
         <sch:assert test="not(matches(@url,'\s+'))">
                                 ERROR: Do not put spaces in image names. If it is an image in the repository,
                                 please rename it to not use spaces.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:pb[@n]">
         <sch:assert test="matches(@n,'^[A-Za-z0-9_\-\.]+$')">ERROR: @n should contain
                              only letters, digits, underscores, periods, or dashes.</sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:pb[@n][not($isFilm)]">
         <sch:assert test="matches(@n,'^((\d+[a-z]?)|(frontcover)|(backcover)|([xiv]+))$')">
                                 ERROR: All @n attributes on page beginnings should start with numbers (and optionally end a alphanumeric string).
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:text[descendant::tei:pb]">
         <sch:assert test="child::tei:*[1]/self::tei:pb">
                                 ERROR: Every text with page beginnings should start with an initial pb element. The first page number encountered is <sch:value-of select="descendant::tei:pb[@n][1]/@n"/>.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:pb[not($isFilm)]">
         <sch:assert test="empty(preceding::tei:pb[@n = current()/@n])">
                                 ERROR: All pb/@n should be unique within a document: <sch:value-of select="current()/@n"/>.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:lb">
         <sch:assert test="ancestor::tei:floatingText or ancestor::tei:front">
                                 ERROR: Line beginning elements should ONLY be used in very special cases where lineation matters; currently that means only within floating
                                 texts.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-author-calendar-check-author-constraint-rule-29">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-author-calendar-calendar-check-author-constraint-rule-30">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-editor-calendar-calendar-check-editor-constraint-rule-31">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-resp-calendar-calendar-check-resp-constraint-rule-32">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:title[@ref]">
         <sch:assert test="@level='j'">
                                 ERROR: Only "j" level titles should use the @ref attribute.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-title-calendar-check-title-constraint-rule-34">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-title-calendar-calendar-check-title-constraint-rule-35">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:bibl[tei:biblScope[@unit=('issue','volume')]]">
         <sch:assert test="descendant::tei:title[@level='j']" role="warning">
                                 WARNING: You have encoded issues and volumes, but no journal title. Are you sure this is correct?
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:bibl[ancestor::tei:div[@xml:id='bibliography_resources']]">
         <sch:assert test="tei:date[@when or @notBefore or @notAfter or @to or @from]">
                                 ERROR: All secondary bibliography entries must encode a &lt;date&gt; element
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:sourceDesc[not(ancestor::tei:sourceDesc)]/tei:bibl">
         <sch:assert test="@copyOf and starts-with(@copyOf,'bibl:')">
                                 ERROR: All bibls should have an @copyOf that points to the bibl
                                 id number of the bibliographic item in question (i.e. copyOf="bibl:77").
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:bibl[@type]">
         <sch:assert test="../self::tei:surrogates">
                                 ERROR: @type allowed on bibl only in surrogates.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:surrogates/tei:bibl">
         <sch:assert test="@type">
                                 ERROR: @type required for a bibl pointer in surrogates.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-l-abstractModel-structure-l-in-l-constraint-report-9">
      <rule context="tei:l">
         <sch:report xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
        Abstract model violation: Lines may not contain lines or lg elements.
      </sch:report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-lg-atleast1oflggapl-constraint-assert-37">
      <rule context="tei:lg">
         <sch:assert xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0">An lg element
        must contain at least one child l, lg, or gap element.</sch:assert>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-lg-abstractModel-structure-lg-in-l-constraint-report-10">
      <rule context="tei:lg">
         <sch:report xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
        Abstract model violation: Lines may not contain line groups.
      </sch:report>
      </rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:extent">
         <sch:assert test="ancestor::tei:biblFull[ancestor::tei:sourceDesc]">
                                 ERROR: Do not use the extent element; it is to be used in the context
                                 of a biblFull in a source description.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-idno-calendar-calendar-check-idno-constraint-rule-42">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-licence-calendar-calendar-check-licence-constraint-rule-43">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:sourceDesc[not(tei:bibl or tei:msDesc)]">
         <sch:assert test="some $d in $docTypes satisfies matches($d, 'BornDigital')">
                      ERROR: All not born digital documents must use a &lt;bibl&gt; element in their
                      source descriptions.
                    </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-quotation-quotationContents-constraint-report-11">
      <rule context="tei:quotation">
         <report xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 test="not(@marks) and not (tei:p)">
On <name/>, either the @marks attribute should be used, or a paragraph of description provided</report>
      </rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:textClass[tei:catRef[@scheme='wdt:docType'][contains(@target,'Primary')]][ancestor::tei:TEI/descendant::tei:revisionDesc[@status=('readyForProof','published')]]">
         <sch:assert test="tei:catRef[@scheme='wdt:genre'] and tei:catRef[@scheme='wdt:exhibit']">
                                 ERROR: All primary soruce documents that are ready for proofing or published MUST have a genre and exhibit.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:catRef[@scheme='wdt:docType']">
         <sch:assert test="matches(@target,'^((wdt:docPrimarySource)|(wdt:docPrimarySourceMS)|(wdt:docPrimarySourcePublished)|(wdt:docBornDigital)|(wdt:docBornDigitalListing)|(wdt:docBornDigitalDocumentation))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
         </sch:assert>
      </sch:rule>
      <sch:rule context="tei:catRef[@scheme='wdt:genre']">
         <sch:assert test="matches(@target,'^((wdt:genreShortStory)|(wdt:genreNF)|(wdt:genreNFAuto)|(wdt:genreNFDedication)|(wdt:genreNFLetter)|(wdt:genreNFInterview)|(wdt:genreNFIntroduction)|(wdt:genreNFEthnography)|(wdt:genreNFMiscellany)|(wdt:genreNFMiscellanyBlurb)|(wdt:genreFilm)|(wdt:genreFilmScenario)|(wdt:genreFilmOutline)|(wdt:genreFilmTreatment)|(wdt:genreFilmScreenplay)|(wdt:genrePlay)|(wdt:genrePoem)|(wdt:genreMemo)|(wdt:genreNovel)|(wdt:genreNovelSerial))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
         </sch:assert>
      </sch:rule>
      <sch:rule context="tei:catRef[@scheme='wdt:exhibit']">
         <sch:assert test="matches(@target,'^((wdt:Japan)|(wdt:Alberta)|(wdt:Hollywood)|(wdt:EarlyExperiment)|(wdt:NewYork))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
         </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:revisionDesc[@status]">
         <sch:let name="thisStatus" value="@status"/>
         <sch:let name="firstChange" value="tei:change[@status][1]"/>
         <sch:assert test="$firstChange/@status = $thisStatus">
                                 ERROR: The status attribute must match the @status of the latest change element.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:revisionDesc[not(@status='empty')]">
         <sch:assert test="not(exists(//tei:text/descendant::tei:gap[@reason='noTranscriptionAvailable']))">
                                 ERROR: Only "empty" is allowed as a status for documents without transcriptions.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-change-calendar-calendar-check-change-constraint-rule-52">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:figure">
         <sch:assert test="tei:*">
                                 ERROR: All figures should have at least one element in it.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:figure[ancestor::tei:div[@type='listFigure']]">
         <sch:assert test="@type">
                                 ERROR: Every figure in the figure database must have an @type value.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:figure[ancestor::tei:div[@type='listFigure']][not(@type='generated')]">
         <sch:assert test="tei:head and tei:figDesc and tei:bibl">
                                 ERROR: Every figure in the media database must include a head element, a figDesc element, and a bibl element.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-link-linkTargets3-constraint-assert-53">
      <rule context="tei:link">
         <sch:assert xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="contains(normalize-space(@target),' ')">You must supply at least two values for @target or  on <sch:name/>
         </sch:assert>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-ab-abstractModel-structure-ab-in-l-or-lg-constraint-report-12">
      <rule context="tei:ab">
         <sch:report xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="(ancestor::tei:l or ancestor::tei:lg) and not( ancestor::tei:floatingText |parent::tei:figure |parent::tei:note )">
        Abstract model violation: Lines may not contain higher-level divisions such as p or ab, unless ab is a child of figure or note, or is a descendant of floatingText.
      </sch:report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-msDesc-one_ms_singleton_max-constraint-rule-56">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:msContents|tei:physDesc|tei:history|tei:additional">
         <sch:let name="gi" value="name(.)"/>
         <sch:report test="preceding-sibling::*[ name(.) eq $gi ]                           and                           not( following-sibling::*[ name(.) eq $gi ] )">
          Only one <sch:name/> is allowed as a child of <sch:value-of select="name(..)"/>.
        </sch:report>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-msIdentifier-msId_minimal-constraint-report-14">
      <rule context="tei:msIdentifier">
         <report xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 test="not(parent::tei:msPart) and (local-name(*[1])='idno' or local-name(*[1])='altIdentifier' or normalize-space(.)='')">An msIdentifier must contain either a repository or location.</report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-orgName-calendar-calendar-check-orgName-constraint-rule-57">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-persName-calendar-check-persName-constraint-rule-58">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-persName-calendar-calendar-check-persName-constraint-rule-59">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-placeName-calendar-calendar-check-placeName-constraint-rule-60">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-birth-calendar-calendar-check-birth-constraint-rule-61">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-death-calendar-calendar-check-death-constraint-rule-62">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-event-calendar-calendar-check-event-constraint-rule-63">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
            systems or calendars to which the date represented by the content of this element belongs,
            but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-location-calendar-calendar-check-location-constraint-rule-64">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-nationality-calendar-calendar-check-nationality-constraint-rule-65">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-occupation-calendar-calendar-check-occupation-constraint-rule-66">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:person[ancestor::tei:figure]">
         <sch:assert test="@corresp and normalize-space(string-join(descendant::text())) =''">
                                 ERROR: People referenced in figures should only contain an @corresp to the person 
                                 in question and no content.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:*[some $r in @* satisfies matches($r,'pers:')]">
         <sch:let name="atts"
                  value="for $a in @* return if (contains($a,'pers:')) then tokenize($a,'\s+') else ()"/>
         <sch:let name="vals"
                  value="for $a in $atts return if (starts-with($a,'pers:')) then $a else ()"/>
         <sch:let name="errors"
                  value="for $v in $vals return if (matches($v,'^pers:[A-Z]+\d+$')) then () else $v"/>
         <sch:assert test="empty($errors)">
                                 ERROR: All pers pointers (i.e. the string after 'pers:') must be a sequence of capital letters and a digit (bad val: <sch:value-of select="string-join($errors,' ')"/>)
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:person[@role]">
         <sch:assert test="ancestor::tei:figure">
                                 ERROR: The @role attribute is only allowed on person in the context of a figure.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:person[ancestor::tei:listPerson and ancestor::tei:figure]">
         <sch:assert test="@role">
                                 ERROR: All people in a listPerson in a figure should have a @role attribute.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-relation-reforkeyorname-constraint-assert-68">
      <rule context="tei:relation">
         <assert xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 test="@ref or @key or @name">One of the attributes  'name', 'ref' or 'key' must be supplied</assert>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-relation-activemutual-constraint-report-15">
      <rule context="tei:relation">
         <report xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 test="@active and @mutual">Only one of the attributes @active and @mutual may be supplied</report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-relation-activepassive-constraint-report-16">
      <rule context="tei:relation">
         <report xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 test="@passive and not(@active)">the attribute 'passive' may be supplied only if the attribute 'active' is supplied</report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-relation-calendar-calendar-check-relation-constraint-rule-71">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@calendar]">
         <sch:assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
                        systems or calendars to which the date represented by the content of this element belongs,
                        but this <sch:name/> element has no textual content.</sch:assert>
      </sch:rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:div[@type='listFigure']/tei:*">
         <sch:assert test="self::tei:div[@type='listFigure'] or self::tei:figure">
                                 ERROR: listFigure divs should only contain figures or itself.
                              </sch:assert>
      </sch:rule>
   </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-div-abstractModel-structure-div-in-l-or-lg-constraint-report-17">
      <rule context="tei:div">
         <sch:report xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="(ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText)">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </sch:report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-div-abstractModel-structure-div-in-ab-or-p-constraint-report-18">
      <rule context="tei:div">
         <sch:report xmlns="http://www.tei-c.org/ns/1.0"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
                     xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:xs="http://www.w3.org/2001/XMLSchema"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)">
        Abstract model violation: p and ab may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </sch:report>
      </rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-att.global.facs-facs.mustStartWithFacs-constraint-rule-73">
      <sch:rule xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                context="tei:*[@facs]">
         <sch:let name="tokens" value="tokenize(@facs,'\s+')"/>
         <sch:let name="facsRegex" value="'^facs:.+'"/>
         <sch:assert test="every $t in $tokens satisfies (matches($t,$facsRegex) and not(matches($t,'\..+$')))">
                              ERROR: All facsimile pointers should start with facs: and not include the file extension.
                           </sch:assert>
      </sch:rule>
   </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            id="wea-subst-substContents1-constraint-assert-72">
      <rule context="tei:subst">
         <assert xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 test="child::tei:add and (child::tei:del or child::tei:surplus)">
            <name/> must have at least one child add and at least one child del or surplus</assert>
      </rule>
   </pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:let name="spaceRegex" value="'(^\s)|(\s$)'"/>
      <sch:let name="docId" value="root(/)/tei:*/@xml:id"/>
      <sch:let name="docUri" value="document-uri(/)"/>
      <sch:let name="docIds" value="//tei:*[@xml:id]/@xml:id"/>
      <sch:let name="docTypes" value="//tei:catRef/@target"/>
      <sch:let name="docStatus" value="//tei:revisionDesc/@status"/>
      <sch:let name="isDocumentation"
               value="some $r in $docTypes satisfies matches($r,'Documentation')"/>
      <sch:let name="isFilm" value="some $r in $docTypes satisfies matches($r,'Film')"/>
      <sch:let name="thisUri" value="document-uri(/)"/>
      <sch:let name="thisProjectDir"
               value="if (matches($thisUri,'/data/')) then (substring-before($thisUri,'/data/') || '/data/') else replace($thisUri,'[^/]+$','')"/>
      <sch:let name="theseDocs"
               value="uri-collection(concat(substring-after($thisProjectDir,'file:'),'?select=*.xml;skip-errors=true;recurse=yes'))"/>
      <sch:let name="allDocIds"
               value="for $doc in $theseDocs return replace($doc,'.+/([^/]+)\.xml', '$1')"/>
      <sch:let name="peopleIds"
               value="document($theseDocs[matches(.,'people.xml$')][1])//tei:person/@xml:id/xs:string(.)"/>
      <sch:let name="orgIds"
               value="document($theseDocs[matches(.,'organizations.xml')][1])//tei:org/@xml:id/xs:string(.)"/>
      <sqf:fix id="globals">
         <sqf:description>
            <sqf:title>Global Templates</sqf:title>
         </sqf:description>
         <xsl:variable name="apos">'</xsl:variable>
         <xsl:variable name="dq">"</xsl:variable>
         <xsl:template name="tagBlocks">
            <xsl:param name="verse" select="false()"/>
            <xsl:variable name="ancestors" select="count(ancestor::tei:*)"/>
            <xsl:variable name="tabCount" select="$ancestors"/>
            <xsl:variable name="newLine">
               <xsl:text>
</xsl:text>
            </xsl:variable>
            <xsl:variable name="tab"
                          select="string-join(for $n in (2 to $tabCount) return '&#x9;','')"/>
            <xsl:variable name="paras"
                          select="for $t in tokenize(.,'\n+') return normalize-space($t)"/>
            <xsl:for-each select="$paras[not(.='')]">
               <xsl:value-of select="$newLine"/>
               <xsl:value-of select="$tab"/>
               <xsl:element name="{if ($verse) then 'l' else 'p'}">
                  <xsl:value-of select="."/>
               </xsl:element>
            </xsl:for-each>
         </xsl:template>
         <xsl:template name="replaceApos">
            <xsl:param name="useDq" select="false()"/>
            <xsl:variable name="thisApos" select="if ($useDq) then $dq else $apos"/>
            <xsl:variable name="left" select="if ($useDq) then '“' else '‘'"/>
            <xsl:variable name="right" select="if ($useDq) then '”' else '’'"/>
            <xsl:analyze-string select="." regex="{concat('(^|\s+)',$thisApos)}">
               <xsl:matching-substring>
                  <xsl:value-of select="regex-group(1)"/>
                  <xsl:value-of select="$left"/>
               </xsl:matching-substring>
               <xsl:non-matching-substring>
                  <xsl:analyze-string select="." regex="{concat('([a-zA-Z])',$thisApos)}">
                     <xsl:matching-substring>
                        <xsl:value-of select="regex-group(1)"/>
                        <xsl:value-of select="$right"/>
                     </xsl:matching-substring>
                     <xsl:non-matching-substring>
                        <xsl:analyze-string select="." regex="{concat($thisApos,'(\s+|$)')}">
                           <xsl:matching-substring>
                              <xsl:value-of select="$right"/>
                              <xsl:value-of select="regex-group(1)"/>
                           </xsl:matching-substring>
                           <xsl:non-matching-substring>
                              <xsl:value-of select="."/>
                           </xsl:non-matching-substring>
                        </xsl:analyze-string>
                     </xsl:non-matching-substring>
                  </xsl:analyze-string>
               </xsl:non-matching-substring>
            </xsl:analyze-string>
         </xsl:template>
         <xsl:template name="tagQuote">
            <xsl:param name="left"/>
            <xsl:param name="right"/>
            <xsl:variable name="rex1" select="concat($left,'([^',$right,']+)([\.,])',$right)"/>
            <xsl:variable name="rex2" select="concat($left,'([^',$right,']+)',$right)"/>
            <xsl:analyze-string select="." regex="{$rex1}">
               <xsl:matching-substring>
                  <xsl:element name="q">
                     <xsl:value-of select="regex-group(1)"/>
                  </xsl:element>
                  <xsl:value-of select="regex-group(2)"/>
               </xsl:matching-substring>
               <xsl:non-matching-substring>
                  <xsl:analyze-string select="." regex="{$rex2}">
                     <xsl:matching-substring>
                        <xsl:element name="q">
                           <xsl:value-of select="regex-group(1)"/>
                        </xsl:element>
                     </xsl:matching-substring>
                     <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                     </xsl:non-matching-substring>
                  </xsl:analyze-string>
               </xsl:non-matching-substring>
            </xsl:analyze-string>
         </xsl:template>
      </sqf:fix>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="/tei:TEI[not(ancestor::tei:teiCorpus)] | /tei:teiCorpus">
         <sch:assert test="@xml:id and matches($docUri,concat('[/\\]',$docId,'.[\w_]+$'))"> ERROR: Document
                    xml:id (<sch:value-of select="$docId"/>) does not match the document file
                    name (<sch:value-of select="$docUri"/>). </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:name[@ref] | tei:change[@who] | tei:rs[@ref] | tei:*[@resp]">
         <sch:let name="att"
                  value="if (@ref) then @ref else if (@who) then @who else @resp"/>
         <sch:let name="errors"
                  value="for $i in tokenize($att,'\s+') return if (matches($i,'^(pers:|https://dcs|#)')) then () else $i"/>
         <sch:assert test="empty($errors)"> ERROR: All personography pointers must start with the pers: prefix.</sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:linkGrp[@type='redirects'] | tei:link">
         <sch:assert test="ancestor::tei:TEI/@xml:id = 'redirects'">
                              ERROR: Only use <sch:name/> in the redirects file.
                           </sch:assert>
      </sch:rule>
      <sch:rule context="tei:link">
         <sch:assert test="@target and count(tokenize(@target,'\s+')) = 2">
                              ERROR: Link must have an @target attribute with two pointers.
                           </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:msDesc/tei:msContents/tei:msItem">
         <sch:assert test="count(tei:bibl) = 1">
                              ERROR: All primary source documents must contain a bibliographic citation (i.e. a bibl element)
                           </sch:assert>
      </sch:rule>
      <sch:rule context="tei:msDesc/tei:msContents/tei:msItem/tei:bibl">
         <sch:assert test="matches(string-join(descendant::text()),'\S')">
                              ERROR: All primary source documents must have a meaningful bibliographic citation.
                           </sch:assert>
      </sch:rule>
      <sch:rule context="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title">
         <sch:assert test="matches(string-join(descendant::text()),'\S')">
                              ERROR: Document titles should not be empty
                           </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:publisher[@ref]">
         <sch:let name="errors"
                  value="for $i in tokenize(@ref,'\s+') return if (matches($i,'^org:')) then () else $i"/>
         <sch:assert test="empty($errors)"> ERROR: All org pointers must start with the org: prefix.</sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:change[@who]">
         <sch:let name="errors"
                  value="tokenize(@who,'\s+')[not(matches(.,'^pers:[A-Z]{2}\d+$'))]"/>
         <sch:assert test="empty($errors)">ERROR: Bad @who value for this change element: <sch:value-of select="string-join($errors,' ')"/>
         </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:*[not(ancestor-or-self::tei:code)][text()][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]">
         <sch:let name="onlyOneQuote"
                  value="some $t in text() satisfies (not(count(tokenize($t,'”')) = count(tokenize($t,'“'))))"/>
         <sch:assert test="not($onlyOneQuote)">
                              ERROR: Curly quotes that cannot be QuickFixed. Either add the curly quotation mark or change to the q element.
                           </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:TEI[descendant::tei:catRef[contains(@target,'Poem')]][not(descendant::tei:revisionDesc/@status='empty')]">
         <sch:assert test="descendant::tei:text[descendant::tei:lg or descendant::tei:l or descendant::tei:gap[@reason=('readyForProof','inProgress')]]">
                              ERROR: This document is classified as a poem, but there are no line groups (&lt;lg&gt;) or lines (&lt;l&gt;).
                              Ensure that you do not use paragraph tags if it is a poem. 
                           </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:text[@next or @prev]">
         <sch:let name="errors"
                  value="for $r in (@next,@prev) return if (substring-after($r,'doc:')=$docId) then $r else ()"/>
         <sch:assert test="empty($errors)">
                              ERROR: Next and prev should point to a different document (i.e. a different installment), but they contain the value(s) <sch:value-of select="string-join($errors,' ')"/>.
                           </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:name | tei:ref[not(descendant::tei:graphic)] | tei:title | tei:l | tei:orgName | tei:persName/tei:reg">
         <sch:let name="text" value="string-join(descendant::text(),'')"/>
         <sch:assert test="not(matches($text,'^\s+|\s+$'))">
                              ERROR: <sch:name/> should not begin or end with spaces.
                           </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:name">
         <sch:let name="text" value="string-join(descendant::text(),'')"/>
         <sch:assert test="if (matches($text,'^(\w\.)+$')) then true() else not(matches($text,'\.$'))"
                     role="warning">
                              WARNING: <sch:name/> usually shouldn't end with periods.
                           </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:q[not(@rendition='rnd:block')][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]">
         <sch:let name="text" value="string-join(descendant::text(),'')"/>
         <sch:assert test="not(matches($text,'[\.,]$'))">
                              ERROR: Trailing punctuation should go outside the <sch:name/> element.
                           </sch:assert>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:body[not($isDocumentation)] | tei:*[not(self::tei:code)][text()][normalize-space(string-join(text(),'')) ne ''][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]">
         <sch:let name="thisText"
                  value="if (self::tei:body) then string-join(descendant::text()[not(ancestor::tei:code)],'') else string-join(text()[not(ancestor::tei:code)],'')"/>
         <sch:let name="cp" value="string-to-codepoints($thisText)"/>
         <sch:let name="distinctCp" value="distinct-values($cp)"/>
         <sch:assert test="empty($distinctCp[.=34])"
                     sqf:fix="replaceStraightQuotesHere replaceStraightQuotesEverywhere">
                              ERROR: QUICKFIX: Do not use straight quotation marks.
                           </sch:assert>
         <sqf:fix id="replaceStraightQuotesHere" use-when="self::tei:body">
            <sqf:description>
               <sqf:title>GLOBAL: Replace straight quotation mark with curly question marks everywhere.</sqf:title>
            </sqf:description>
            <sqf:replace match="//text()">
               <xsl:call-template name="replaceApos">
                  <xsl:with-param name="useDq" select="true()"/>
               </xsl:call-template>
            </sqf:replace>
         </sqf:fix>
         <sqf:fix id="replaceStraightQuotesEverywhere" use-when="not(self::tei:body)">
            <sqf:description>
               <sqf:title>LOCAL: Replace straight quotation marks with curly quotation marks in this <sch:name/> element.</sqf:title>
            </sqf:description>
            <sqf:replace match="text()">
               <xsl:call-template name="replaceApos">
                  <xsl:with-param name="useDq" select="true()"/>
               </xsl:call-template>
            </sqf:replace>
         </sqf:fix>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:bibl[ancestor::tei:div[@xml:id='bibliography_we']]">
         <sch:assert test="@xml:id" sqf:fix="addNewBiblId">ERROR: QUICKFIX: All WE bibls need an id. Click the red lightbulb to the left to add one. </sch:assert>
         <sch:assert test="@xml:id and matches(@xml:id,'^bibl\d+$')" sqf:fix="replaceBiblId">ERROR: QUICKFIX: All WE bibls need a bibl id in the format bibl#. Click the red lightbulb to the left to replace the current id.</sch:assert>
         <sqf:fix id="addNewBiblId">
            <sqf:description>
               <sqf:title>Add a new bibl id</sqf:title>
            </sqf:description>
            <sqf:add match="." target="xml:id" node-type="attribute">
               <xsl:variable name="bibls"
                             select="for $bibl in ancestor::tei:div[@xml:id='bibliography_we']/descendant::tei:bibl[matches(@xml:id,'^bibl')]/@xml:id return substring-after($bibl,'bibl')"/>
               <xsl:variable name="newNum" select="max(for $n in $bibls return xs:integer($n)) + 1"/>
               <xsl:value-of select="'bibl' || $newNum"/>
            </sqf:add>
         </sqf:fix>
         <sqf:fix id="replaceBiblId">
            <sqf:description>
               <sqf:title>Replace bibl id</sqf:title>
            </sqf:description>
            <sqf:replace match="@xml:id" node-type="attribute" target="xml:id">
               <xsl:variable name="rBibls"
                             select="for $bibl in ancestor::tei:div[@xml:id='bibliography_we']/descendant::tei:bibl[matches(@xml:id,'^bibl')]/@xml:id return substring-after($bibl,'bibl')"/>
               <xsl:variable name="rNewNum"
                             select="max(for $n in $rBibls return xs:integer($n)) + 1"/>
               <xsl:value-of select="'bibl'||$rNewNum"/>
            </sqf:replace>
         </sqf:fix>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:body[not($isDocumentation)] | tei:*[text()][not(self::tei:code)][normalize-space(string-join(text(),'')) ne ''][not($isDocumentation)][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]">
         <sch:let name="thisText"
                  value="if (self::tei:body) then string-join(descendant::text()[not(ancestor::tei:code)],'') else string-join(text()[not(ancestor::tei:code)],'')"/>
         <sch:let name="cp" value="string-to-codepoints($thisText)"/>
         <sch:let name="distinctCp" value="distinct-values($cp)"/>
         <sch:assert test="empty($distinctCp[.=39])"
                     sqf:fix="replaceAposHere replaceAposEverywhere">
                              ERROR: QUICKFIX: Do not use straight apostrophes. 
                           </sch:assert>
         <sqf:fix id="replaceAposHere" use-when="self::tei:body">
            <sqf:description>
               <sqf:title>GLOBAL: Replace straight apostrophe with curly apostrophe everywhere.</sqf:title>
            </sqf:description>
            <sqf:replace match="//text()">
               <xsl:call-template name="replaceApos"/>
            </sqf:replace>
         </sqf:fix>
         <sqf:fix id="replaceAposEverywhere" use-when="not(self::tei:body)">
            <sqf:description>
               <sqf:title>LOCAL: Replace straight apostrophe with curly apostrophe in this <sch:name/> element.</sqf:title>
            </sqf:description>
            <sqf:replace match="text()">
               <xsl:call-template name="replaceApos"/>
            </sqf:replace>
         </sqf:fix>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:body | tei:div | tei:lg">
         <sch:let name="divs"
                  value="if (self::tei:body) then (descendant::tei:div) else ."/>
         <sch:let name="noElContentDivs" value="$divs[not(descendant::*)]"/>
         <sch:let name="contentDivs"
                  value="$noElContentDivs[not(normalize-space(string-join(text(),''))='')]"/>
         <sch:assert test="empty($contentDivs)" sqf:fix="fixDivsHere fixDivsEverywhere">
                              ERROR: QUICKFIX: Untagged text should likely be tagged. Use the Quickfix to do so.
                           </sch:assert>
         <sqf:fixes>
            <sqf:fix id="fixDivsHere" use-when="not(self::tei:body)">
               <sqf:description>
                  <sqf:title>LOCAL: Fix this <sch:name/>
                  </sqf:title>
               </sqf:description>
               <sqf:replace match="node()">
                  <xsl:call-template name="tagBlocks">
                     <xsl:with-param name="verse"
                                     select="if (parent::*/self::tei:lg) then true() else false()"/>
                  </xsl:call-template>
               </sqf:replace>
            </sqf:fix>
            <sqf:fix id="fixDivsEverywhere" use-when="self::tei:body">
               <sqf:description>
                  <sqf:title>GLOBAL: Tag all paragraphs within divs and lines within linegroups.</sqf:title>
               </sqf:description>
               <sqf:replace match="//tei:div[not(descendant::*)][not(normalize-space(string-join(text(),''))='')]/node() | //tei:lg[not(descendant::*)][not(normalize-space(string-join(text(),''))='')]/node()">
                  <xsl:call-template name="tagBlocks">
                     <xsl:with-param name="verse"
                                     select="if (parent::*/self::tei:lg) then true() else false()"/>
                  </xsl:call-template>
               </sqf:replace>
            </sqf:fix>
         </sqf:fixes>
      </sch:rule>
   </sch:pattern>
   <sch:pattern xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <sch:rule context="tei:body[not($isDocumentation)] | tei:*[text()][not(normalize-space(string-join(text(),''))='')][not($isDocumentation) or ($isDocumentation and not(ancestor::tei:back))]">
         <sch:let name="text"
                  value="string-join(descendant::text()[not(ancestor::tei:code)],'')"/>
         <sch:let name="containsCurlyQuotes"
                  value="matches($text,'“') and matches($text,'”')"/>
         <sch:assert test="not($containsCurlyQuotes)"
                     sqf:fix="fixQuotesHere fixQuotesEverywhere">
                              ERROR: QUICKFIX: Do not use curly quotes; use the q element instead.
                           </sch:assert>
         <sqf:fix id="fixQuotesHere">
            <sqf:description>
               <sqf:title>
                                    LOCAL: Replace curly quotes with q elements in this <sch:name/> element.</sqf:title>
            </sqf:description>
            <sqf:replace match="text()[contains(.,'“') and contains(.,'”')]">
               <xsl:call-template name="tagQuote">
                  <xsl:with-param name="left" select="'“'"/>
                  <xsl:with-param name="right" select="'”'"/>
               </xsl:call-template>
            </sqf:replace>
         </sqf:fix>
         <sqf:fix id="fixQuotesEverywhere" use-when="self::tei:body">
            <sqf:description>
               <sqf:title>GLOBAL: Replace curly quotes with q elements.</sqf:title>
            </sqf:description>
            <sqf:replace match="//text()[contains(.,'“') and contains(.,'”')]">
               <xsl:call-template name="tagQuote">
                  <xsl:with-param name="left" select="'“'"/>
                  <xsl:with-param name="right" select="'”'"/>
               </xsl:call-template>
            </sqf:replace>
         </sqf:fix>
      </sch:rule>
   </sch:pattern>
   <sch:diagnostics/>
</sch:schema>
