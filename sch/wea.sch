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
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 test="ancestor::tei:l[not(.//tei:note//tei:p[. = current()])]">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-ref-refAtts-constraint-report-7">
            <rule context="tei:ref">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 test="@target and @cRef">Only one of the
	attributes @target' and @cRef' may be supplied on <name/>
               </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-list-gloss-list-must-have-labels-constraint-rule-8">
            <sch:rule xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns="http://www.tei-c.org/ns/1.0"
                context="tei:list[@type='gloss']">
	              <sch:assert test="tei:label">The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element</sch:assert>
            </sch:rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-relatedItem-targetorcontent1-constraint-report-8">
            <rule context="tei:relatedItem">
               <sch:report xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
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
            id="wea-relatedItem-targetorcontent1-constraint-assert-5">
            <rule context="tei:relatedItem">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
        Abstract model violation: Lines may not contain lines or lg elements.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-lg-atleast1oflggapl-constraint-assert-6">
            <rule context="tei:lg">
               <sch:assert xmlns:xi="http://www.w3.org/2001/XInclude"
                     xmlns:svg="http://www.w3.org/2000/svg"
                     xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
        Abstract model violation: Lines may not contain line groups.
      </report>
            </rule>
         </pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
                              <sch:assert test="tei:catRef[@scheme='wdt:object']">
                            ERROR: Missing category reference object.
                        </sch:assert>
                           </sch:rule>
                           <sch:rule context="tei:textClass">
                              <sch:assert test="tei:catRef[@scheme='wdt:locations']">
                            ERROR: Missing category reference locations.
                        </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                           <sch:rule context="tei:catRef[@scheme='wdt:docType']">
                              <sch:assert test="matches(@target,'^((wdt:primarySource)|(wdt:bornDigital))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
                              </sch:assert>
                           </sch:rule>
                           <sch:rule context="tei:catRef[@scheme='wdt:genre']">
                              <sch:assert test="matches(@target,'^((wdt:genreShortStory)|(wdt:genreNF)|(wdt:genreNFAuto)|(wdt:genreNFDedication)|(wdt:genreNFInterview)|(wdt:genreNFIntroduction)|(wdt:genreNFEthnography)|(wdt:genreFilm)|(wdt:genreFilmScenario)|(wdt:genreFilmTreatment)|(wdt:genrePoem)|(wdt:genreNovel)|(wdt:genreNovelSerial))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
                              </sch:assert>
                           </sch:rule>
                           <sch:rule context="tei:catRef[@scheme='wdt:object']">
                              <sch:assert test="matches(@target,'^((wdt:objectText)|(wdt:objectPhoto)|(wdt:objectFilm)|(wdt:objectPoster))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
                              </sch:assert>
                           </sch:rule>
                           <sch:rule context="tei:catRef[@scheme='wdt:locations']">
                              <sch:assert test="matches(@target,'^((wdt:locJapan)|(wdt:locAlberta)|(wdt:locHollywood)|(wdt:locMontreal)|(wdt:locNY))$')">
                            ERROR: Value <sch:value-of select="@target"/> not allowed for category reference <sch:value-of select="@scheme"/>
                              </sch:assert>
                           </sch:rule>
                        </sch:pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-div-abstractModel-structure-l-constraint-report-11">
            <rule context="tei:div">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 test="ancestor::tei:l">
        Abstract model violation: Lines may not contain higher-level structural elements such as div.
      </report>
            </rule>
         </pattern>
   <pattern xmlns="http://purl.oclc.org/dsdl/schematron"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:teix="http://www.tei-c.org/ns/Examples"
            id="wea-div-abstractModel-structure-p-constraint-report-12">
            <rule context="tei:div">
               <report xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 test="ancestor::tei:p or ancestor::tei:ab and not(ancestor::tei:floatingText)">
        Abstract model violation: p and ab may not contain higher-level structural elements such as div.
      </report>
            </rule>
         </pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples">
                        <sch:let name="spaceRegex" value="'(^\s)|(\s$)'"/>
                        <sch:let name="docId" value="root(/)/tei:*/@xml:id"/>
                        <sch:let name="docUri" value="document-uri(/)"/>
                        <sch:let name="docIds" value="//tei:*[@xml:id]/@xml:id"/>
                        <sch:let name="docTypes" value="//tei:catRef/@target"/>
                     </sch:pattern>
   <sch:pattern xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
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
   <sch:diagnostics/>
</sch:schema>
