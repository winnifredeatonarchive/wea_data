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
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-att.datable.w3c-att-datable-w3c-when-constraint-rule-1">
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
            id="wea-att.datable.w3c-att-datable-w3c-from-constraint-rule-2">
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
            id="wea-att.datable.w3c-att-datable-w3c-to-constraint-rule-3">
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
            id="wea-att.datable-calendar-calendar-constraint-rule-4">
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
            id="wea-att.typed-subtypeTyped-constraint-rule-5">
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
            id="wea-att.styleDef-schemeVersion-schemeVersionRequiresScheme-constraint-rule-6">
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
            id="wea-p-abstractModel-structure-p-constraint-report-5">
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
            id="wea-p-abstractModel-structure-l-constraint-report-6">
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:foreign">
                              <sch:let name="text" value="string-join(text(),'')"/>
                              <sch:assert test="not(matches($text,'^\s+|\s+$'))">
                                 ERROR: foreign elements should not begin or end with spaces.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:q">
                              <sch:let name="text" value="string-join(descendant::text(),'')"/>
                              <sch:assert test="if (normalize-space(string-join(child::text())) ='') then true() else not(matches($text,'^\s+|\s+$'))">
                                 ERROR: q elements should not begin or end with spaces.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-desc-deprecationInfo-only-in-deprecated-constraint-rule-10">
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
            id="wea-ref-refAtts-constraint-report-7">
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
            id="wea-list-gloss-list-must-have-labels-constraint-rule-11">
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:note[@type='authorial']">
                              <sch:assert test="ancestor::tei:q">
                                 ERROR: Authorial notes should only be used within the q element.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:note[ancestor::tei:q]">
                              <sch:assert test="@type">
                                 ERROR: Notes within the q element should have a type of either authorial
                                 or editorial.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:note[@type='editorial']">
                              <sch:assert test="@resp">
                                 ERROR: Editorial notes should have a @resp attribute pointing to the person who authored this note.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:note[@type='bio']">
                              <sch:assert test="parent::tei:person">
                                 ERROR: Biographical notes should only be used for people in personography.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:note[@type='bio']">
                              <sch:assert test="tei:p">
                                 ERROR: All biographical notes should have at least one paragraph.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:note[@type='bio'][@subtype='short']">
                              <sch:assert test="count(tei:p) = 1">
                                 ERROR: Short biographies should only contain a single paragraph.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:note[@subtype]">
                              <sch:assert test="@type='bio'">
                                 ERROR: @subtype is only allowed when used in concert with notes biographical.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:person">
                              <sch:assert test="count(tei:note[@type='bio'][@subtype='long']) lt 2 and count(tei:note[@type='bio'][@subtype='short']) lt 2">
                                 ERROR: Only one of each long and short bios are allowed in the personography.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:note[@type='bio'][@subtype='short']">
                              <sch:let name="wc"
                  value="count(tokenize(normalize-space(string-join(descendant::text(),'')),'\s+'))"/>
                              <sch:assert test="$wc lt 76">
                                 ERROR: This short biographical statement should be 75 words maximum. Current word count: <sch:value-of select="$wc"/>.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:pb[@n]">
                              <sch:assert test="matches(@n,'^((\d+[a-z]?)|(frontcover)|([xiv]+))$')">
                                 ERROR: All @n attributes on page beginnings should start with numbers (and optionally end a alphanumeric string).
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:text[descendant::tei:pb]">
                              <sch:assert test="child::tei:*[1]/self::tei:pb">
                                 ERROR: Every text with page beginnings should start with an initial pb element. The first page number encountered is <sch:value-of select="descendant::tei:pb[@n][1]/@n"/>.
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:bibl[tei:biblScope[@unit=('issue','volume')]]">
                              <sch:assert test="tei:title[@level='j']" role="warning">
                                 WARNING: You have encoded issues and volumes, but no journal title. Are you sure this is correct?
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-relatedItem-targetorcontent1-constraint-report-8">
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
            id="wea-relatedItem-targetorcontent1-constraint-assert-20">
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
            id="wea-l-abstractModel-structure-l-constraint-report-9">
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
            id="wea-lg-atleast1oflggapl-constraint-assert-21">
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
            id="wea-lg-abstractModel-structure-l-constraint-report-10">
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:sourceDesc[not(tei:bibl)]">
                              <sch:assert test="some $d in $docTypes satisfies matches($d, 'BornDigital')">
                      ERROR: All not born digital documents must use a &lt;bibl&gt; element in their
                      source descriptions.
                    </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-quotation-quotationContents-constraint-report-11">
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:textClass">
                              <sch:assert test="tei:catRef[@scheme='wdt:docType']">
                            ERROR: Missing category reference docType.
                        </sch:assert>
                           </sch:rule>
                           <sch:rule context="tei:textClass">
                              <sch:assert test="tei:catRef[@scheme='wdt:genre']">
                            ERROR: Missing category reference genre.
                        </sch:assert>
                           </sch:rule>
                           <sch:rule context="tei:textClass">
                              <sch:assert test="tei:catRef[@scheme='wdt:exhibit']">
                            ERROR: Missing category reference exhibit.
                        </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:catRef[@scheme='wdt:docType']">
                              <sch:assert test="matches(@target,'^((wdt:docPrimarySource)|(wdt:docPrimarySourceMS)|(wdt:docPrimarySourcePublished)|(wdt:docBornDigital)|(wdt:docBornDigitalExhibit))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
                              </sch:assert>
                           </sch:rule>
                           <sch:rule context="tei:catRef[@scheme='wdt:genre']">
                              <sch:assert test="matches(@target,'^((wdt:genreShortStory)|(wdt:genreNF)|(wdt:genreNFAuto)|(wdt:genreNFDedication)|(wdt:genreNFInterview)|(wdt:genreNFIntroduction)|(wdt:genreNFEthnography)|(wdt:genreFilm)|(wdt:genreFilmScenario)|(wdt:genreFilmTreatment)|(wdt:genrePoem)|(wdt:genreNovel)|(wdt:genreNovelSerial))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
                              </sch:assert>
                           </sch:rule>
                           <sch:rule context="tei:catRef[@scheme='wdt:exhibit']">
                              <sch:assert test="matches(@target,'^((wdt:Japan)|(wdt:Alberta)|(wdt:Hollywood)|(wdt:EarlyExperiment)|(wdt:NewYork))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-ab-abstractModel-structure-ab-constraint-report-12">
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
            id="wea-ab-abstractModel-structure-l-constraint-report-13">
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
            id="wea-div-abstractModel-structure-l-constraint-report-14">
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
            id="wea-div-abstractModel-structure-p-constraint-report-15">
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
            id="wea-att.global.facs-facs.mustStartWithFacs-constraint-rule-31">
      <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:*[@facs]">
                           <sch:let name="tokens" value="tokenize(@facs,'\s+')"/>
                           <sch:let name="facsRegex" value="'^facs:.+'"/>
                           <sch:assert test="every $t in $tokens satisfies (matches($t,$facsRegex) and not(matches($t,'\..+$')))">
                              ERROR: All facsimile pointers should start with facs: and not include the file extension.
                           </sch:assert>
                        </sch:rule>
   </pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:let name="spaceRegex" value="'(^\s)|(\s$)'"/>
                        <sch:let name="docId" value="root(/)/tei:*/@xml:id"/>
                        <sch:let name="docUri" value="document-uri(/)"/>
                        <sch:let name="docIds" value="//tei:*[@xml:id]/@xml:id"/>
                        <sch:let name="docTypes" value="//tei:catRef/@target"/>
                        <sch:let name="docStatus" value="//tei:revisionDesc/@status"/>
                        
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="/tei:TEI[not(ancestor::tei:teiCorpus)] | /tei:teiCorpus">
                           <sch:assert test="@xml:id and matches($docUri,concat('[/\\]',$docId,'.xm[l_]$'))"> ERROR: Document
                    xml:id (<sch:value-of select="$docId"/>) does not match the document file
                    name (<sch:value-of select="$docUri"/>). </sch:assert>
                        </sch:rule>
                     </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="tei:*[not(ancestor-or-self::tei:code)][text()]">
                           <sch:let name="onlyOneQuote"
                  value="some $t in text() satisfies (not(count(tokenize($t,'”')) = count(tokenize($t,'“'))))"/>
                           <sch:assert test="not($onlyOneQuote)">
                              ERROR: Curly quotes that cannot be QuickFixed. Either add the curly quotation mark or change to the q element.
                           </sch:assert>
                        </sch:rule>
                     </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="tei:text[@next or @prev]">
                           <sch:let name="errors"
                  value="for $r in (@next,@prev) return if (substring-after($r,'doc:')=$docId) then $r else ()"/>
                           <sch:assert test="empty($errors)">
                              ERROR: Next and prev should point to a different document (i.e. a different installment), but they contain the value(s) <sch:value-of select="string-join($errors,' ')"/>.
                           </sch:assert>
                        </sch:rule>
                     </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="tei:name | tei:ref | tei:title | tei:l">
                           <sch:let name="text" value="string-join(descendant::text(),'')"/>
                           <sch:assert test="not(matches($text,'^\s+|\s+$'))">
                              ERROR: <sch:name/> should not begin or end with spaces.
                           </sch:assert>
                        </sch:rule>
                     </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="tei:name">
                           <sch:let name="text" value="string-join(descendant::text(),'')"/>
                           <sch:assert test="not(matches($text,'\.$'))" role="warning">
                              WARNING: <sch:name/> usually shouldn't end with periods.
                           </sch:assert>
                        </sch:rule>
                     </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="tei:q">
                           <sch:let name="text" value="string-join(descendant::text(),'')"/>
                           <sch:assert test="not(matches($text,'[\.,]$'))">
                              ERROR: Trailing punctuaton should go outside the <sch:name/> element.
                           </sch:assert>
                        </sch:rule>
                     </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="tei:body | tei:*[text()][normalize-space(string-join(text(),'')) ne '']">
                           <sch:let name="thisText"
                  value="if (self::tei:body) then string-join(descendant::text(),'') else string-join(text(),'')"/>
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="tei:body | tei:*[text()][normalize-space(string-join(text(),'')) ne '']">
                           <sch:let name="thisText"
                  value="if (self::tei:body) then string-join(descendant::text(),'') else string-join(text(),'')"/>
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:rule context="tei:body | tei:*[text()][not(normalize-space(string-join(text(),''))='')]">
                           <sch:let name="text" value="string-join(descendant::text(),'')"/>
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
