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
    <xsl:variable name="repoReckoning">
        <list>
            <item>
                <item>Amoy, A Chinese Girl</item>
                <item>Amoy_Chinese_Girl</item>
                <item>AmoyChineseGirl1</item>
                <item>bibl27</item>
            </item>
            <item><item>The Betrothal of Otoyo</item>
                <item>Betrothal_of_Otoyo</item>
                <item>BetrothalOfOtoyo1</item>
                <item>bibl137</item></item>
            <item><item>The Bride of Yonejiro</item>
                <item>Bride_of_Yonejiro</item>
                <item>BrideOfYonejiro1</item>
                <item>bibl138</item></item>
            <item><item>Butchering Brains</item>
                <item>Butchering_Brains</item>
                <item>ButcheringBrains1</item>
                <item>bibl35</item></item>
            <item><item>Chinese-Japanese Cookbook</item>
                <item>Chinese-Japanese_Cookbook</item>
                <item>ChineseJapaneseCookbook1</item>
                <item>bibl1</item></item>
            <item><item>I Could Get Any Woman’s Husband</item>
                <item>I_Could_Get_Any_Womans_Husband</item>
                <item>CouldGetAnyWomansHusband1</item>
                <item>bibl58</item></item>
            <item><item>Count Oguri’s Quest</item>
                <item>Count_Oguris_Quest</item>
                <item>CountOgurisQuest1</item>
                <item>bibl37</item></item>
            <item><item>Daughters of Nijo</item>
                <item>Daughters_of_Nijo</item>
                <item>DaughtersOfNijo1</item>
                <item>bibl38</item></item>
            <item><item>Daughter of Two Lands</item>
                <item>Daughter_of_Two_Lands</item>
                <item>DaughterTwoLands1</item>
                <item>bibl5</item></item>
            <item><item>The Diary of Dewdrop</item>
                <item>Diary_of_Dewdrop</item>
                <item>DiaryOfDewdrop1</item>
                <item>bibl147</item></item>
            <item><item>A Father</item>
                <item>A_Father</item>
                <item>Father1</item>
                <item>bibl6</item></item>
            <item><item>The Happy Lot of Japanese Women</item>
                <item>Happy_Lot_of_Japanese_Women</item>
                <item>HappyLot1</item>
                <item>bibl152</item></item>
            <item><item>Her Japanese Lover</item>
                <item>Her_Japanese_Lover</item>
                <item>HerJapaneseLover1</item>
                <item>bibl45</item></item>
            <item><item>His Interpreter: Part I</item>
                <item>His_Interpreter_s1</item>
                <item>HisInterpreter1</item>
                <item>bibl48</item></item>
            <item><item>His Interpreter: Part II</item>
                <item>His_Interpreter_s2</item>
                <item>HisInterpreter2</item>
                <item>bibl49</item></item>
            <item><item>His Japanese Teacher</item>
                <item>His_Japanese_Teacher</item>
                <item>HisJapaneseTeacher1</item>
                <item>bibl50</item></item>
            <item><item>His Wife’s Husband</item>
                <item>His_Wifes_Husband</item>
                <item>HisWifesHusband1</item>
                <item>bibl52</item></item>
            <item><item>The Honorable Miss Moonlight</item>
                <item>Honorable_Miss_Moonlight</item>
                <item>HonorableMissMoonlight1</item>
                <item>bibl154</item></item>
            <item><item>Honorable Movie Takee Sojin</item>
                <item>Honorable_Movie_Takee_Sojin</item>
                <item>HonorableMovie1</item>
                <item>bibl55</item></item>
            <item><item>How Frenchmen Make Love</item>
                <item>How_Frenchmen_Make_Love</item>
                <item>HowFrenchmenMakeLove1</item>
                <item>bibl56</item></item>
            <item><item>The Japanese in New York</item>
                <item>Japanese_in_New_York</item>
                <item>JapaneseInNewYork1</item>
                <item>bibl157</item></item>
            <item><item>Japanese Love Story</item>
                <item>Japanese_Love_Story</item>
                <item>JapaneseLoveStory1</item>
                <item>bibl11</item></item>
            <item><item>Japanese War News by Word o’Mouth</item>
                <item>Japanese_War_News</item>
                <item>JapaneseWarNews1</item>
                <item>bibl61</item></item>
            <item><item>John and I</item>
                <item>John_and_I</item>
                <item>JohnAndI1</item>
                <item>bibl65</item></item>
            <item><item>Karo</item>
                <item>Karo</item>
                <item>Karo1</item>
                <item>bibl67</item></item>
            <item><item>Li Ching’s Baby</item>
                <item>Li_Chings_Baby</item>
                <item>LiChingsBaby1</item>
                <item>bibl71</item></item>
            <item><item>The Life of a Japanese Girl</item>
                <item>Life_of_a_Japanese_Girl</item>
                <item>LifeOfJapaneseGirl1</item>
                <item>bibl158</item></item>
            <item><item>Margot</item>
                <item>Margot</item>
                <item>Margot1</item>
                <item>bibl72</item></item>
            <item><item>Marion: The Story of an Artist’s Model</item>
                <item>Marion</item>
                <item>Marion1</item>
                <item>bibl73</item></item>
            <item><item>The Marriage of Jinyo</item>
                <item>Marriage_of_Jinyo</item>
                <item>MarriageOfJinyo1</item>
                <item>bibl169</item></item>
            <item><item>The Marriage of Okiku-San</item>
                <item>Marriage_of_Okiku-San</item>
                <item>MarriageOkikuSan1</item>
                <item>bibl170</item></item>
            <item><item>Memories</item>
                <item>Memories</item>
                <item>Memories1</item>
                <item>bibl88</item></item>
            <item><item>Miss Numè of Japan</item>
                <item>Nume</item>
                <item>MissNume1</item>
                <item>bibl90</item></item>
            <item><item>Miss Perfume</item>
                <item>Miss_Perfume</item>
                <item>MissPerfume1</item>
                <item>bibl92</item></item>
            <item><item>Miss Spring Morning</item>
                <item>Miss_Spring_Morning</item>
                <item>MissSpringMorning1</item>
                <item>bibl93</item></item>
            <item><item>Natsu-San</item>
                <item>Natsu-San_Japanese_Tea_House</item>
                <item>NatsuSanTeaHouseGirl1</item>
                <item>bibl98</item></item>
            <item><item>Ojio-San</item>
                <item>Ojio-San</item>
                <item>OjioSan1</item>
                <item>bibl103</item></item>
            <item><item>The Old Jinrikisha: Installment 1</item>
                <item>Old_Jinrikisha_s1</item>
                <item>OldJinrikisha1</item>
                <item>bibl174</item></item>
            <item><item>The Old Jinrikisha: Installment 2</item>
                <item>Old_Jinrikisha_s2</item>
                <item>OldJinrikisha2</item>
                <item>bibl175</item></item>
            <item><item>The Old Jinrikisha: Installment 3</item>
                <item>Old_Jinrikisha_s3</item>
                <item>OldJinrikisha3</item>
                <item>bibl176</item></item>
            <item><item>The Old Jinrikisha: Installment 4</item>
                <item>Old_Jinrikisha_s4</item>
                <item>OldJinrikisha4</item>
                <item>bibl177</item></item>
            <item><item>The Old Jinrikisha: Installment 5</item>
                <item>Old_Jinrikisha_s5</item>
                <item>OldJinrikisha5</item>
                <item>bibl178</item></item>
            <item><item>The Old Jinrikisha: Installment 6</item>
                <item>Old_Jinrikisha_s6</item>
                <item>OldJinrikisha6</item>
                <item>bibl217</item></item>
            <item><item>The Old Jinrikisha: Installment 7</item>
                <item>Old_Jinrikisha_s7</item>
                <item>OldJinrikisha7</item>
                <item>bibl179</item></item>
            <item><item>The Old Jinrikisha: Installment 8</item>
                <item>Old_Jinrikisha_s8</item>
                <item>OldJinrikisha8</item>
                <item>bibl180</item></item>
            <item><item>The Old Jinrikisha: Installment 9</item>
                <item>Old_Jinrikisha_s9</item>
                <item>OldJinrikisha9</item>
                <item>bibl181</item></item>
            <item><item>An Oriental Holiday</item>
                <item>Oriental_Holiday</item>
                <item>OrientalHoliday1</item>
                <item>bibl29</item></item>
            <item><item>A Poor Devil</item>
                <item>Poor_Devil</item>
                <item>PoorDevil1</item>
                <item>bibl22</item></item>
            <item><item>The Pot of Paint</item>
                <item>Pot_of_Paint</item>
                <item>PotOfPaint1</item>
                <item>bibl182</item></item>
            <item><item>A Prayer For Understanding</item>
                <item>Prayer_For_Understanding</item>
                <item>PrayerForUnderstanding1</item>
                <item>bibl23</item></item>
            <item><item>Prince Sagaritsu’s Patriotism</item>
                <item>Prince_Sagaritsus_Patriotism</item>
                <item>PrinceSagaritsu1</item>
                <item>bibl117</item></item>
            <item><item>A Rhapsody on Japan</item>
                <item>Rhapsody_on_Japan</item>
                <item>RhapsodyOnJapan1</item>
                <item>bibl24</item></item>
            <item><item>Shizu’s New Year’s Present</item>
                <item>Shizus_New_Years_Present</item>
                <item>ShizusNewYearsPresent1</item>
                <item>bibl122</item></item>
            <item><item>Sneer Not</item>
                <item>Sneer_Not</item>
                <item>SneerNot1</item>
                <item>bibl126</item></item>
            <item><item>Starving and Writing in New York</item>
                <item>Starving_and_Writing_in_NY</item>
                <item>StarvingAndWriting1</item>
                <item>bibl128</item></item>
            <item><item>The Story of Ido</item>
                <item>Story_of_Ido</item>
                <item>StoryOfIdo1</item>
                <item>bibl183</item></item>
            <item><item>Sunny-San</item>
                <item>Sunny-San</item>
                <item>SunnySan1</item>
                <item>bibl134</item></item>
            <item><item>Taro</item>
                <item>Taro</item>
                <item>Taro1</item>
                <item>bibl136</item></item>
            <item><item>Three Loves</item>
                <item>Three_Loves</item>
                <item>ThreeLoves1</item>
                <item>bibl200</item></item>
            <item><item>Tokiwa: A Tale of Old Japan</item>
                <item>Tokiwa</item>
                <item>Tokiwa1</item>
                <item>bibl202</item></item>
            <item><item>An Unexpected Grandchild</item>
                <item>Unexpected_Grandchild</item>
                <item>UnexpectedGrandchild1</item>
                <item>bibl30</item></item>
            <item><item>What Happened to Hayakawa</item>
                <item>What_Happened_to_Hayakawa</item>
                <item>WhatHappenedHayakawa1</item>
                <item>bibl206</item></item>
            <item>
                <item>Where the Young Look Forward to Old Age</item>
                <item>Where_the_Young_Look_Forward</item>
                <item>WhereYoungLookForward1</item>
                <item>bibl208</item>
            </item>
            <item>
                <item>The Wickedness of Matsu</item>
                <item>Wickedness_of_Matsu</item>
                <item>WickednessOfMatsu1</item>
                <item>bibl184</item>
            </item>
            <item><item>The Wife of Shimadzu</item>
                <item>Wife_of_Shimadzu</item>
                <item>WifeOfShimadzu1</item>
                <item>bibl185</item></item>
            <item><item>Yoshida Yone, Lover</item>
                <item>Yoshida_Yone_Lover</item>
                <item>YoshidaYoneLover1</item>
                <item>bibl214</item></item>
        </list>
    </xsl:variable>
    
    <xsl:variable name="usedBiblIds" select="$repoReckoning//item/item[4]"/>
    
    
    <xsl:template match="/">
        <xsl:for-each select="$bibls">
            <xsl:variable name="thisBibl" select="."/>
            <xsl:variable name="thisId" select="@xml:id"/>
            <xsl:variable name="outId" select="wea:createId($thisBibl)"/>
            <xsl:choose>
                <xsl:when test="$repoReckoning//item[item[4]=$thisId]">
                    
                    <xsl:variable name="thisItem" select="$usedBiblIds[. = $thisId]/parent::item"/>
                    <xsl:variable name="thisDoc" select="$thisItem/item[3]"/>
                    
                    <xsl:apply-templates select="document(concat('../../data/texts/',$thisDoc,'.xml'))//TEI">
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
            <xsl:when test="$usedBiblIds[.=$bibl/@xml:id]">
                <xsl:value-of select="$usedBiblIds[.=$bibl/@xml:id]/parent::item/item[3]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="work" select="$bibl/parent::listBibl[@xml:id]"/>
                <xsl:variable name="workId" select="$work/@xml:id"/>
                <xsl:variable name="num" select="count(for $n in $work/bibl return if ($n/@xml:id=$usedBiblIds) then $n else ())"/>
                <xsl:value-of select="concat($workId,$num+1)"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    <!--How do we create ids? If the thing has an id already, then just use that;
        otherwise, we have to see: if that get the max number in the thing, and then add
        one to the end-->
    
    <xsl:template match="TEI">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:param name="id" tunnel="yes"/>
        
        <xsl:result-document href="out/{$id}.xml">
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
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="sourceDesc">
        <xsl:param name="bibl" tunnel="yes"/>
        <xsl:copy>
            <bibl copyOf="bibl:{substring-after($bibl/@xml:id,'bibl')}"/>
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
                <revisionDesc>
                    <change who="pers:JT1" when="2019-04-11">Generated file.</change>
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