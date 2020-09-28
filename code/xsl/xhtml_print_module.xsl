<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xd:doc>
        <xd:desc>
            <xd:p>Created on: Sept 27, 2020</xd:p>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>This stylesheet creates the print information block for the WEA.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:template name="createPrintInfo">
        <div id="print">
            <xsl:variable name="abstract" select="//abstract"/>            
            <!--Get the title-->
            <h2><xsl:apply-templates select="//teiHeader/fileDesc/titleStmt/title[1]/node()" mode="tei"/></h2>

            <!--Retrieve the content from the abstract, if we need it-->
            <xsl:if test="$abstract">
                <div id="print_headnote">
                    <h3>Headnote</h3>
                    <xsl:variable name="abstractContents" as="element()*">
                        <xsl:apply-templates select="$abstract/p" mode="tei"/>
                    </xsl:variable>
                    <div>
                        <xsl:iterate select="$abstractContents">
                            <xsl:param name="i" select="1" as="xs:integer"/>
                            <xsl:message><xsl:value-of select="$i"/></xsl:message>
                            
                            <xsl:copy>
                                <xsl:sequence select="@*|node()"/>
                                <xsl:if test="$i = count($abstractContents)">
                                    <xsl:value-of select="' (' || string(wea:returnHeadnoteByline($abstract)) ||')'"/>
                                </xsl:if>
                            </xsl:copy>
                            <xsl:next-iteration>
                                <xsl:with-param name="i" select="$i + 1"/>
                            </xsl:next-iteration>
                        </xsl:iterate>
                    </div>

                </div>
            </xsl:if>
            
            <!--Add the respStmts-->
            <div id="print_resps">
                <h3>Credits</h3>
                <xsl:variable name="respStmts" as="element()*">
                    <xsl:apply-templates select="//respStmt[not(ancestor::biblFull)]" mode="metadata"/>
                </xsl:variable>
                <xsl:for-each select="$respStmts">
                    <xsl:copy>
                        <xsl:sequence select="@*[not(local-name()='id')]|node()"/>
                    </xsl:copy>
                </xsl:for-each>
   
            </div>
            
            <!--Retrieve the content for the print citation-->
            <div id="print_citation">
                <h3>Citation</h3>
                <div class="bibl">
                    <xsl:apply-templates select="//teiHeader/fileDesc/publicationStmt/descendant::bibl[@type='mla']/node()" mode="tei"/>
                </div>
         
            </div>
        </div>
    </xsl:template>
    
    
</xsl:stylesheet>