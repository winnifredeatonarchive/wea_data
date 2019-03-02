<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                version="2.0">
   <xsl:variable xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns="http://www.tei-c.org/ns/1.0"
                 xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                 name="apos">'</xsl:variable>
   <xsl:variable xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns="http://www.tei-c.org/ns/1.0"
                 xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                 name="dq">"</xsl:variable>
   <xsl:template xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns="http://www.tei-c.org/ns/1.0"
                 xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                 name="tagBlocks">
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
   <xsl:template xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns="http://www.tei-c.org/ns/1.0"
                 xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                 name="replaceApos">
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
   <xsl:template xmlns:xi="http://www.w3.org/2001/XInclude"
                 xmlns:svg="http://www.w3.org/2000/svg"
                 xmlns:math="http://www.w3.org/1998/Math/MathML"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 xmlns="http://www.tei-c.org/ns/1.0"
                 xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                 name="tagQuote">
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
</xsl:stylesheet>
