<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:wea="https://github.com/wearchive/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>Author: Joey Takeda</xd:p>
            <xd:p>Date: April 2019</xd:p>
            <xd:p>This stylesheet performs two actions: it iterates through the bibl ids. If it encounters a bibl id that is there, then it takes the file, renames, and modifes it. Otherwise, it creates a new file, based off of the work id and the extant documents already there.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:variable name="bibls" select="document('../../data/bibliography.xml')//listBibl/listBibl/bibl[@xml:id]"/>
    
    <!--This is derived from teh spreadsheet in the Google drive,
        worked on by the RAs.-->
    <xsl:variable name="map" as="map(xs:string,xs:string+)">
        <xsl:map>
            <xsl:map-entry key="'bibl27'" select="'Amoy_Chinese_Girl','AmoyChineseGirl1'"/>
            <xsl:map-entry key="'bibl137'" select="'Betrothal_of_Otoyo','BetrothalOfOtoyo1'"/>
            <xsl:map-entry key="'bibl138'" select="'Bride_of_Yonejiro','BrideOfYonejiro1'"/>
            <xsl:map-entry key="'bibl35'" select="'Butchering_Brains','ButcheringBrains1'"/>
            <xsl:map-entry key="'bibl1'" select="'Chinese-Japanese_Cookbook','ChineseJapaneseCookbook1'"/>
            <xsl:map-entry key="'bibl58'" select="'I_Could_Get_Any_Womans_Husband','CouldGetAnyWomansHusband1'"/>
            <xsl:map-entry key="'bibl37'" select="'Count_Oguris_Quest','CountOgurisQuest1'"/>
            <xsl:map-entry key="'bibl38'" select="'Daughters_of_Nijo','DaughtersOfNijo1'"/>
            <xsl:map-entry key="'bibl5'" select="'Daughter_of_Two_Lands','DaughterTwoLands1'"/>
            <xsl:map-entry key="'bibl147'" select="'Diary_of_Dewdrop','DiaryOfDewdrop1'"/>
            <xsl:map-entry key="'bibl6'" select="'A_Father','Father1'"/>
            <xsl:map-entry key="'bibl152'" select="'Happy_Lot_of_Japanese_Women','HappyLot1'"/>
            <xsl:map-entry key="'bibl45'" select="'Her_Japanese_Lover','HerJapaneseLover1'"/>
            <xsl:map-entry key="'bibl48'" select="'His_Interpreter_s1','HisInterpreter1'"/>
            <xsl:map-entry key="'bibl49'" select="'His_Interpreter_s2','HisInterpreter2'"/>
            <xsl:map-entry key="'bibl50'" select="'His_Japanese_Teacher','HisJapaneseTeacher1'"/>
            <xsl:map-entry key="'bibl52'" select="'His_Wifes_Husband','HisWifesHusband1'"/>
            <xsl:map-entry key="'bibl154'" select="'Honorable_Miss_Moonlight','HonorableMissMoonlight1'"/>
            <xsl:map-entry key="'bibl55'" select="'Honorable_Movie_Takee_Sojin','HonorableMovie1'"/>
            <xsl:map-entry key="'bibl56'" select="'How_Frenchmen_Make_Love','HowFrenchmenMakeLove1'"/>
            <xsl:map-entry key="'bibl157'" select="'Japanese_in_New_York','JapaneseInNewYork1'"/>
            <xsl:map-entry key="'bibl11'" select="'Japanese_Love_Story','JapaneseLoveStory1'"/>
            <xsl:map-entry key="'bibl61'" select="'Japanese_War_News','JapaneseWarNews1'"/>
            <xsl:map-entry key="'bibl65'" select="'John_and_I','JohnAndI1'"/>
            <xsl:map-entry key="'bibl67'" select="'Karo','Karo1'"/>
            <xsl:map-entry key="'bibl71'" select="'Li_Chings_Baby','LiChingsBaby1'"/>
            <xsl:map-entry key="'bibl158'" select="'Life_of_a_Japanese_Girl','LifeOfJapaneseGirl1'"/>
            <xsl:map-entry key="'bibl72'" select="'Margot','Margot1'"/>
            <xsl:map-entry key="'bibl73'" select="'Marion','Marion1'"/>
            <xsl:map-entry key="'bibl169'" select="'Marriage_of_Jinyo','MarriageOfJinyo1'"/>
            <xsl:map-entry key="'bibl170'" select="'Marriage_of_Okiku-San','MarriageOkikuSan1'"/>
            <xsl:map-entry key="'bibl88'" select="'Memories','Memories1'"/>
            <xsl:map-entry key="'bibl90'" select="'Nume','MissNume1'"/>
            <xsl:map-entry key="'bibl92'" select="'Miss_Perfume','MissPerfume1'"/>
            <xsl:map-entry key="'bibl93'" select="'Miss_Spring_Morning','MissSpringMorning1'"/>
            <xsl:map-entry key="'bibl98'" select="'Natsu-San_Japanese_Tea_House','NatsuSanTeaHouseGirl1'"/>
            <xsl:map-entry key="'bibl103'" select="'Ojio-San','OjioSan1'"/>
            <xsl:map-entry key="'bibl174'" select="'Old_Jinrikisha_s1','OldJinrikisha1'"/>
            <xsl:map-entry key="'bibl175'" select="'Old_Jinrikisha_s2','OldJinrikisha2'"/>
            <xsl:map-entry key="'bibl176'" select="'Old_Jinrikisha_s3','OldJinrikisha3'"/>
            <xsl:map-entry key="'bibl177'" select="'Old_Jinrikisha_s4','OldJinrikisha4'"/>
            <xsl:map-entry key="'bibl178'" select="'Old_Jinrikisha_s5','OldJinrikisha5'"/>
            <xsl:map-entry key="'bibl217'" select="'Old_Jinrikisha_s6','OldJinrikisha6'"/>
            <xsl:map-entry key="'bibl179'" select="'Old_Jinrikisha_s7','OldJinrikisha7'"/>
            <xsl:map-entry key="'bibl180'" select="'Old_Jinrikisha_s8','OldJinrikisha8'"/>
            <xsl:map-entry key="'bibl181'" select="'Old_Jinrikisha_s9','OldJinrikisha9'"/>
            <xsl:map-entry key="'bibl29'" select="'Oriental_Holiday','OrientalHoliday1'"/>
            <xsl:map-entry key="'bibl22'" select="'Poor_Devil','PoorDevil1'"/>
            <xsl:map-entry key="'bibl182'" select="'Pot_of_Paint','PotOfPaint1'"/>
            <xsl:map-entry key="'bibl23'" select="'Prayer_For_Understanding','PrayerForUnderstanding1'"/>
            <xsl:map-entry key="'bibl117'" select="'Prince_Sagaritsus_Patriotism','PrinceSagaritsu1'"/>
            <xsl:map-entry key="'bibl24'" select="'Rhapsody_on_Japan','RhapsodyOnJapan1'"/>
            <xsl:map-entry key="'bibl122'" select="'Shizus_New_Years_Present','ShizusNewYearsPresent1'"/>
            <xsl:map-entry key="'bibl126'" select="'Sneer_Not','SneerNot1'"/>
            <xsl:map-entry key="'bibl128'" select="'Starving_and_Writing_in_NY','StarvingAndWriting1'"/>
            <xsl:map-entry key="'bibl183'" select="'Story_of_Ido','StoryOfIdo1'"/>
            <xsl:map-entry key="'bibl134'" select="'Sunny-San','SunnySan1'"/>
            <xsl:map-entry key="'bibl136'" select="'Taro','Taro1'"/>
            <xsl:map-entry key="'bibl200'" select="'Three_Loves','ThreeLoves1'"/>
            <xsl:map-entry key="'bibl202'" select="'Tokiwa','Tokiwa1'"/>
            <xsl:map-entry key="'bibl30'" select="'Unexpected_Grandchild','UnexpectedGrandchild1'"/>
            <xsl:map-entry key="'bibl206'" select="'What_Happened_to_Hayakawa','WhatHappenedHayakawa1'"/>
            <xsl:map-entry key="'bibl208'" select="'Where_the_Young_Look_Forward','WhereYoungLookForward1'"/>
            <xsl:map-entry key="'bibl184'" select="'Wickedness_of_Matsu','WickednessOfMatsu1'"/>
            <xsl:map-entry key="'bibl185'" select="'Wife_of_Shimadzu','WifeOfShimadzu1'"/>
            <xsl:map-entry key="'bibl214'" select="'Yoshida_Yone_Lover','YoshidaYoneLover1'"/>
        </xsl:map>
    </xsl:variable>
    
    <xsl:template name="go">
        <xsl:for-each select="$bibls">
            <xsl:sort select="xs:integer(substring-after(@xml:id,'bibl'))" order="ascending"/>
            <xsl:variable name="thisBibl" select="."/>
            <xsl:variable name="thisId" select="@xml:id"/>
            <xsl:message>Processing <xsl:value-of select="$thisId"/></xsl:message>
            <xsl:variable name="outId" select="wea:createId($thisBibl)"/>
            <xsl:message>This out id <xsl:value-of select="$outId"/></xsl:message>
            <xsl:choose>
                <xsl:when test="map:contains($map,$thisId)">
                    <xsl:message>Found <xsl:value-of select="$thisId"/>!</xsl:message>
                    
                    <xsl:apply-templates select="document(concat('../../data/texts/',$map($thisId)[1],'.xml'))//TEI">
                        <xsl:with-param name="id" select="$outId" tunnel="yes"/>
                        <xsl:with-param name="bibl" select="$thisBibl" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$template">
                        <xsl:with-param name="bibl" select="$thisBibl" tunnel="yes"/>
                        <xsl:with-param name="id" select="$outId" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:function name="wea:createId">
        <xsl:param name="bibl"/>
        
        <xsl:choose>
            <xsl:when test="map:contains($map,$bibl/@xml:id)">
                <xsl:value-of select="$map($bibl/@xml:id)[2]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="work" select="$bibl/parent::listBibl[@xml:id]"/>
                <xsl:variable name="workId" select="$work/@xml:id"/>
                <xsl:variable name="mapNum" select="count(for $n in $work/bibl return if (map:contains($map,$n/@xml:id)) then $n else ())"/>
                <xsl:variable name="startingNum" select="$mapNum + 1"/>
                <xsl:value-of select="concat($workId,(count($bibl/preceding-sibling::bibl[not(map:contains($map,@xml:id))]) + $startingNum))"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    <!--How do we create ids? If the thing has an id already, then just use that;
        otherwise, we have to see: if that get the max number in the thing, and then add
        one to the end-->
    
    <xsl:template match="TEI">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:param name="id" tunnel="yes"/>
        
        <xsl:result-document href="out/{$id}.xml" method="xml" indent="yes" suppress-indentation="p q name hi seg floatingText byline note supplied gap">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="TEI/@xml:id">
        <xsl:param name="id" tunnel="yes"/>
        <xsl:attribute name="xml:id" select="$id"/>
    </xsl:template>
    
    <xsl:template match="titleStmt/title[1]">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:copy>
            <xsl:sequence select="$bibl/title[1]/node()"/>
            <xsl:if test="$bibl/preceding-sibling::bibl">
                <xsl:choose>
                    <xsl:when test="$bibl/date"><xsl:text> (</xsl:text><xsl:value-of select="$bibl/date"/><xsl:text>)</xsl:text></xsl:when>
                    <xsl:otherwise><xsl:text> (#</xsl:text><xsl:value-of select="count($bibl/preceding-sibling::bibl) + 1"/><xsl:text>)</xsl:text></xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="revisionDesc">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:variable name="string">
            <xsl:choose>
                <xsl:when test="ancestor::TEI/@xml:id='template'">Created file from bibliography entry <xsl:value-of select="$bibl/@xml:id"/> using XSLT.</xsl:when>
                <xsl:otherwise>Merged file, changed xml:id, and associated with bibliography entry <xsl:value-of select="$bibl/@xml:id"/> using XSLT.</xsl:otherwise>
            </xsl:choose>
          
        </xsl:variable>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <change who="pers:JT1" when="2019-04-11"><xsl:value-of select="$string"/></change>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="sourceDesc">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:copy>
            <bibl copyOf="bibl:{substring-after($bibl/@xml:id,'bibl')}"/>
        </xsl:copy>
    </xsl:template>
    
    <!--Identity-->
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    
    
    <xsl:variable name="template">
        <TEI xml:id="template">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Template</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Publication Information</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Born digital.</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <textClass>
                        <catRef target="wdt:docPrimarySource" scheme="wdt:docType"/>
                    </textClass>
                </profileDesc>
                <revisionDesc status="empty">

                </revisionDesc>
            </teiHeader>
            <text>
                <body>
                    <div>
                        <gap reason="noTranscriptionAvailable"/>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:variable>
    
</xsl:stylesheet>