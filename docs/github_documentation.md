<?xml version="1.0" encoding="UTF-8"?>
## Winnifred Eaton Archive Project Documentation
Note that this is an abridged version of the documentation for editorial use within oXygen. See [docs/documentation_full.html](documentation_full.html) for full documentation. 
## Table of contents
 
 
 
* [Introduction](#index.xml-body.1_div.1)
* [Requirements](#index.xml-body.1_div.2)
* [Using Github](#github)
 
 
* [Setting up the repository](#github_get)
* [The Github Workflow](#index.xml-body.1_div.3_div.2)
 
 
* [Updating](#index.xml-body.1_div.3_div.2_div.1)
* [Committing](#index.xml-body.1_div.3_div.2_div.2)
 
 
 
 
* [Working in oXygen](#index.xml-body.1_div.4)
* [Editing the Texts](#index.xml-body.1_div.5)
* [Building the Schema](#index.xml-body.1_div.6)
 
 
## Introduction  <span id="index.xml-body.1_div.1"/>
 
The following are the Guidelines and schema specification for the Winnifred Eaton Archive project (WEA). The project uses a highly constrained version of the TEI Guidelines; the texts are lightly encoded with very little linked data. Primarily, the texts are meant to be easily ported into an existing Omeka framework; the details of this framework are still in development. 
 
## Requirements  <span id="index.xml-body.1_div.2"/>
 
To edit material for the site, you will need to use a computer with the following software: 
 
 
 
* Git (to get data from and commit data to the repository). Most computers come with git automatically installed. To check this, open the Command Line (Windows) / Terminal (Mac/Linux) and type in 
```
git --version
```
. If you get something like this in response: 
```
git version 2.17.2 (Apple Git-113)
```
, then you have Git installed. Otherwise, follow the instructions [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git). 
* oXygen XML Editor. (For current RAs, talk to Mary Chapman about licensing.)
* You must also set up a free Github account [here](https://github.com/). It will be connected to your email address; once the Github account is set up, let the repository owner (currently Joey Takeda) know the email address used so that they can grant you write access to the repository. 
 
 
## Using Github  <span id="github"/>
 
All of the data for the project is kept in a Git repository that is hosted through Github. Git is a version control system, which means that one could "roll back" the site to any particular version, and retrieve any file at any state of editing. Note that Github is a public repository, so all of the data and commit messages you make are visible to anyone. Our Github repository URL is [https://github.com/winnifredeatonarchive/wea_data](https://github.com/winnifredeatonarchive/wea_data). 
 
### Setting up the repository
 
To get the data, you must first checkout a copy of the repository as follows:
 
 
 
* Open the terminal
* Create a directory for working in: 
```
mkdir wea
```
 
* Go into the directory: 
```
cd wea
```
 
* Initialize the repository: 
```
git init .
```
 
* Pull the repository: 
```
git pull https://github.com/winnifredeatonarchive/wea_data
```
 
 
 
Note that you only need to do this the first time you start working in the Github repository. 
 
 ----- 
 
### The Github Workflow
 
The normal workflow for working in Github (and any version software) is as follows: 
 
 
 
* Update your repository so that any changes made by others are pushed into your local system 
* Commit the items to the repository
* Push those items to the Github interface
 
 
### Updating
 
Make sure to update as often as possible; always update at the beginning of your working session. 
 
To update: 
 
 
 
* Go into your working folder: 
```
cd wea
```
 
* Pull the repository: 
```
git pull
```
 
 
 
 ----- 
 
### Committing
 
Unlike some versioning systems, Github requires three steps for committing/saving your work to the repository. 
 
 
 
* First, check the status of your files to see what you have changed since your last commit: 
```
git status
```
 If there are no changes to the repository, then you'll like see something like this: 
```
On branch master nothing to commit, working tree clean 
```
 If there are changes, you should see something like this: 
```
On branch master Changes not staged for commit: (use "git add &lt;file&gt;..." to update what will be committed) (use "git checkout -- &lt;file&gt;..." to discard changes in working directory) modified: README.md no changes added to commit (use "git add" and/or "git commit -a") 
```
 
* If there are changes, then add the files/folders that you want to commit to the repository. 
```
git add README.md
```
 
* Third, commit the files to the repository, including a commit message that explains what you did: 
```
git commit -m "Encoding a new poem."
```
 
* Fourth, push the files to the repository: 
```
git push
```
 Note that, if you are committing for the first time, you'll like see something like this: 
```
Either specify the URL from the command-line or configure a remote repository using git remote add &lt;name&gt; &lt;url&gt; and then push using the remote name git push &lt;name&gt; 
```
 This means that you must set up your local copy to track the changes in the global repository. To do that, simply follow the above instructions like so: 
```
git remote add wea https://github.com/winnifredeatonarchive/wea_data
```
 
```
git push wea
```
 You'll then like get another message, saying something like: 
```
fatal: The current branch master has no upstream branch. To push the current branch and set the remote as upstream, use git push --set-upstream wea master 
```
 To resolve that, simply: 
```
git push --set-upstream wea master 
```
 You may then be prompted for your username and password; if this is your first commit, then it might give your instructions on how to store those credentials in your local git system so that you do not need to add your username and password every time you commit. 
 
 
 
 
## Working in oXygen  <span id="index.xml-body.1_div.4"/>
 
First, ensure that you're working in the wea_data.xpr project file.
 
## Editing the Texts  <span id="index.xml-body.1_div.5"/>
 
## Building the Schema  <span id="index.xml-body.1_div.6"/>
 
All constraints and documentation are contained within the ODD file, including the RelaxNG schema, the schematron file, and the compiled schematron XSLT. 
 
To regenerate the schema and the documentation follow these directions
 
In oXygen: Simply open the ODD file in the oXygen project file and press the red "play" button. 
 
Command line: in the root project directory (`wea_data`), run: 
```
ant -lib lib -f code/buildSchemas.xml
```
 Note that you must have ant installed. 
 
## 
 
## Schema wea: Elements
 
### `abstract`<span id="abstract"/>
 
 
**abstract** contains a summary or formal abstract prefixed to an existing source document by the encoder. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-abstract.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [profileDesc](#profileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [list](#list)  [p](#p) 
 
 
 
 
 
#### **Note**
 
This element is intended only for cases where no abstract is available in the original source. Any abstract already present in the source document should be encoded as a  [div](#div)  within the  [front](#front) , as it should for a born-digital document. 
 
 
 
 
 
#### **Example**
 
 
```
 
<profileDesc> <abstract resp="#LB">
                                <p>Good database design involves the acquisition and deployment of     skills which have a wider relevance to the educational process. From     a set of more or less instinctive rules of thumb a formal discipline     or "methodology" of database design has evolved. Applying that     methodology can be of great benefit to a very wide range of academic     subjects: it requires fundamental skills of abstraction and     generalisation and it provides a simple mechanism whereby complex     ideas and information structures can be represented and manipulated,     even without the use of a computer. </p> </abstract></profileDesc>
 
```
 
 
 
 
 
 
 ----- 
 
### `att`<span id="att"/>
 
 
**att** (attribute) contains the name of an attribute appearing within running text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
`@scheme` supplies an identifier for the scheme in which this name is defined. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Sample values include:**: 
 
     *    **TEI** (Text Encoding Initiative) this attribute is part of the TEI scheme. [Default] 
     *    **DBK** (Docbook) this attribute is part of the Docbook scheme.
     *    **XX** (unknown) this attribute is part of an unknown scheme.
     *    **imaginary** the attribute is from a non-existent scheme, for illustrative purposes only
     *    **XHTML** the attribute is part of the XHTML language
     *    **XML** the attribute is part of the XML language
     *    **XI** the attribute is defined in the xInclude schema
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
Empty element
 
 
 
 
 
#### **Note**
 
As an alternative to using the scheme attribute a namespace prefix may be used. Where both scheme and a prefix are used, the prefix takes precedence. 
 
 
 
 
 
#### **Example**
 
 
```
 
<p>The TEI defines several <soCalled>global</soCalled> attributes; their names include<att>xml:id</att>, <att>rend</att>, <att>xml:lang</att>, <att>n</att>, <att>xml:space</att>, and <att>xml:base</att>; <att scheme="XX">
                              type</att> is not amongst them.</p>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `author`<span id="author"/>
 
 
**author** in a bibliographic reference, contains the name(s) of an author, personal or corporate, of a work; for example in the same form as that provided by a recognized bibliographic name authority. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-author.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.naming](#att.naming)  (`@role`, `@nymRef`) ( [att.canonical](#att.canonical)  (`@key`, `@ref`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [editionStmt](#editionStmt)  [titleStmt](#titleStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
Particularly where cataloguing is likely to be based on the content of the header, it is advisable to use a generally recognized name authority file to supply the content for this element. The attributes key or ref may also be used to reference canonical information about the author(s) intended from any appropriate authority, such as a library catalogue or online resource. In the case of a broadcast, use this element for the name of the company or network responsible for making the broadcast. Where an author is unknown or unspecified, this element may contain text such as Unknown or Anonymous. When the appropriate TEI modules are in use, it may also contain detailed tagging of the names used for people, organizations or places, in particular where multiple names are given. 
 
 
 
 
 
#### **Example**
 
 
```
 
<author>British Broadcasting Corporation</author><author>La Fayette, Marie Madeleine Pioche de la Vergne, comtesse de (1634–1693)</author><author>Anonymous</author><author>Bill and Melinda Gates Foundation</author><author> <persName>Beaumont, Francis</persName> and<persName>John Fletcher</persName></author><author> <orgName key="BBC">
                              British Broadcasting   Corporation</orgName>: Radio 3 Network</author>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `authority`<span id="authority"/>
 
 
**authority** (release authority) supplies the name of a person or other agency responsible for making a work available, other than a publisher or distributor. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-authority.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [publicationStmt](#publicationStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [choice](#choice)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [pb](#pb)  [ref](#ref)  [term](#term)  [title](#title) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<authority>John Smith</authority>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `availability`<span id="availability"/>
 
 
**availability** supplies information about the availability of a text, for example any restrictions on its use or distribution, its copyright status, any licence applying to it, etc. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-availability.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`) 
 
 
`@status` supplies a code identifying the current availability of the text. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **free** the text is freely available.
     *    **unknown** the status of the text is unknown.
     *    **restricted** the text is not freely available.
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [publicationStmt](#publicationStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [p](#p) 
 
**header:** [licence](#licence) 
 
 
 
 
 
#### **Note**
 
A consistent format should be adopted
 
 
 
 
 
#### **Example**
 
 
```
 
<availability status="restricted">
                               <p>Available for academic research purposes only.</p></availability><availability status="free">
                               <p>In the public domain</p></availability><availability status="restricted">
                               <p>Available under licence from the publishers.</p></availability>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<availability> <licence target="http://opensource.org/licenses/MIT">
                                <p>The MIT License     applies to this document.</p>  <p>Copyright (C) 2011 by The University of Victoria</p>  <p>Permission is hereby granted, free of charge, to any person obtaining a copy     of this software and associated documentation files (the "Software"), to deal     in the Software without restriction, including without limitation the rights     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     copies of the Software, and to permit persons to whom the Software is     furnished to do so, subject to the following conditions:</p>  <p>The above copyright notice and this permission notice shall be included in     all copies or substantial portions of the Software.</p>  <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     THE SOFTWARE.</p> </licence></availability>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `back`<span id="back"/>
 
 
**back** (back matter) contains any appendixes, etc. following the main part of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-back.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declaring](#att.declaring)  (`@decls`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [text](#text) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [gap](#gap)  [head](#head)  [lb](#lb)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [note](#note)  [p](#p)  [pb](#pb) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [epigraph](#epigraph)  [titlePage](#titlePage)  [titlePart](#titlePart)  [trailer](#trailer) 
 
 
 
 
 
#### **Note**
 
Because cultural conventions differ as to which elements are grouped as back matter and which as front matter, the content models for the  [back](#back)  and  [front](#front)  elements are identical. 
 
 
 
 
 
#### **Example**
 
 
```
 
<back> <div type="appendix">
                                <head>The Golden Dream or, the Ingenuous Confession</head>  <p>TO shew the Depravity of human Nature, and how apt the Mind is to be misled by Trinkets     and false Appearances, Mrs. Two-Shoes does acknowledge, that after she became
                           rich, she     had like to have been, too fond of Money <!-- .... -->  </p> </div><!-- ... --> <div type="epistle">
                                <head>A letter from the Printer, which he desires may be inserted</head>  <salute>Sir.</salute>  <p>I have done with your Copy, so you may return it to the Vatican, if you please;  <!-- ... -->  </p> </div> <div type="advert">
                                <head>The Books usually read by the Scholars of Mrs Two-Shoes are these and are sold at
                           Mr     Newbery's at the Bible and Sun in St Paul's Church-yard.</head>  <list>   <item n="1">
                              The Christmas Box, Price 1d.</item>   <item n="2">
                              The History of Giles Gingerbread, 1d.</item><!-- ... -->   <item n="42">
                              A Curious Collection of Travels, selected from the Writers of all Nations,       10 Vol, Pr. bound 1l.</item>  </list> </div> <div type="advert">
                                <head>By the KING's Royal Patent, Are sold by J. NEWBERY, at the Bible and Sun in St.     Paul's Church-Yard.</head>  <list>   <item n="1">
                              Dr. James's Powders for Fevers, the Small-Pox, Measles, Colds, &amp;c. 2s.       6d</item>   <item n="2">
                              Dr. Hooper's Female Pills, 1s.</item><!-- ... -->  </list> </div></back>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `bibl`<span id="bibl"/>
 
 
**bibl** (bibliographic citation) contains a loosely-structured bibliographic citation of which the sub-components may or may not be explicitly tagged. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-bibl.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`)  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.sortable](#att.sortable)  (`@sortKey`)  [att.docStatus](#att.docStatus)  (`@status`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl)  [corr](#corr)  [emph](#emph)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [listBibl](#listBibl)  [note](#note)  [orig](#orig)  [p](#p)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [sic](#sic)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [licence](#licence)  [rendition](#rendition)  [sourceDesc](#sourceDesc) 
 
**textstructure:** [body](#body)  [div](#div)  [epigraph](#epigraph)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [author](#author)  [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [pubPlace](#pubPlace)  [publisher](#publisher)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [respStmt](#respStmt)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [availability](#availability)  [distributor](#distributor)  [edition](#edition)  [idno](#idno) 
 
**tagdocs:** [code](#code) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
Contains phrase-level elements, together with any combination of elements from the model.biblPart class 
 
 
 
 
 
#### **Example**
 
 
```
 
<bibl>Blain, Clements and Grundy: Feminist Companion to Literature in English (Yale, 1990)</bibl>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<bibl> <title level="a">
                              The Interesting story of the Children in the Wood</title>. In<author>Victor E Neuberg</author>, <title>The Penny Histories</title>.<publisher>OUP</publisher> <date>1968</date>. </bibl>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<bibl type="article" subtype="book_chapter" xml:id="carlin_2003">
                               <author>  <name>   <surname>Carlin</surname>     (<forename>Claire</forename>)</name> </author>,<title level="a">
                              The Staging of Impotence : France’s last   congrès</title> dans<bibl type="monogr">
                                <title level="m">
                              Theatrum mundi : studies in honor of Ronald W.     Tobin</title>, éd. <editor>   <name>    <forename>Claire</forename>    <surname>Carlin</surname>   </name>  </editor> et <editor>   <name>    <forename>Kathleen</forename>    <surname>Wine</surname>   </name>  </editor>, <pubPlace>Charlottesville, Va.</pubPlace>, <publisher>Rookwood Press</publisher>, <date when="2003">
                              2003</date>. </bibl></bibl>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `biblFull`<span id="biblFull"/>
 
 
**biblFull** (fully-structured bibliographic citation) contains a fully-structured bibliographic citation, in which all components of the TEI file description are present. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-biblFull.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`)  [att.sortable](#att.sortable)  (`@sortKey`)  [att.docStatus](#att.docStatus)  (`@status`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [corr](#corr)  [emph](#emph)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [listBibl](#listBibl)  [note](#note)  [orig](#orig)  [p](#p)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [sic](#sic)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [licence](#licence)  [rendition](#rendition)  [sourceDesc](#sourceDesc) 
 
**textstructure:** [body](#body)  [div](#div)  [epigraph](#epigraph)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [editionStmt](#editionStmt)  [fileDesc](#fileDesc)  [notesStmt](#notesStmt)  [profileDesc](#profileDesc)  [publicationStmt](#publicationStmt)  [seriesStmt](#seriesStmt)  [sourceDesc](#sourceDesc)  [titleStmt](#titleStmt) 
 
 
 
 
 
#### **Example**
 
 
```
 
<biblFull> <titleStmt>  <title>The Feminist Companion to Literature in English: women writers from the middle ages     to the present</title>  <author>Blain, Virginia</author>  <author>Clements, Patricia</author>  <author>Grundy, Isobel</author> </titleStmt> <editionStmt>  <edition>UK edition</edition> </editionStmt> <extent>1231 pp</extent> <publicationStmt>  <publisher>Yale University Press</publisher>  <pubPlace>New Haven and London</pubPlace>  <date>1990</date> </publicationStmt> <sourceDesc>  <p>No source: this is an original work</p> </sourceDesc></biblFull>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `body`<span id="body"/>
 
 
**body** (text body) contains the whole body of a single unitary text, excluding any front or back matter. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-body.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declaring](#att.declaring)  (`@decls`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [text](#text) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [bibl](#bibl)  [gap](#gap)  [head](#head)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [note](#note)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote) 
 
**header:** [biblFull](#biblFull) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [epigraph](#epigraph)  [opener](#opener)  [trailer](#trailer) 
 
 
 
 
 
#### **Example**
 
 
```
 
<body> <l>Nu scylun hergan hefaenricaes uard</l> <l>metudæs maecti end his modgidanc</l> <l>uerc uuldurfadur sue he uundra gihuaes</l> <l>eci dryctin or astelidæ</l> <l>he aerist scop aelda barnum</l> <l>heben til hrofe haleg scepen.</l> <l>tha middungeard moncynnæs uard</l> <l>eci dryctin æfter tiadæ</l> <l>firum foldu frea allmectig</l> <trailer>primo cantauit Cædmon istud carmen.</trailer></body>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `byline`<span id="byline"/>
 
 
**byline** contains the primary statement of responsibility given for a work on its title page or at the head or end of the work. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-byline.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list) 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [front](#front)  [opener](#opener)  [titlePage](#titlePage) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**textstructure:** [docAuthor](#docAuthor) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The byline on a title page may include either the name or a description for the document's author. Where the name is included, it may optionally be tagged using the  [docAuthor](#docAuthor)  element. 
 
 
 
 
 
#### **Example**
 
 
```
 
<byline>Written by a CITIZEN who continued all the while in London. Never made publick before.</byline>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<byline>Written from her own MEMORANDUMS</byline>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<byline>By George Jones, Political Editor, in Washington</byline>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<byline>BY<docAuthor>THOMAS PHILIPOTT,</docAuthor> Master of Arts, (Somtimes) Of Clare-Hall in Cambridge.</byline>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `category`<span id="category"/>
 
 
**category** contains an individual descriptive category, possibly nested within a superordinate category, within a user-defined taxonomy. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-category.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [category](#category) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [category](#category) 
 
 
 
 
 
#### **Example**
 
 
```
 
<category xml:id="b1">
                               <catDesc>Prose reportage</catDesc></category>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<category xml:id="b2">
                               <catDesc>Prose </catDesc> <category xml:id="b11">
                                <catDesc>journalism</catDesc> </category> <category xml:id="b12">
                                <catDesc>fiction</catDesc> </category></category>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<category xml:id="LIT">
                               <catDesc xml:lang="pl">
                              literatura piękna</catDesc> <catDesc xml:lang="en">
                              fiction</catDesc> <category xml:id="LPROSE">
                                <catDesc xml:lang="pl">
                              proza</catDesc>  <catDesc xml:lang="en">
                              prose</catDesc> </category> <category xml:id="LPOETRY">
                                <catDesc xml:lang="pl">
                              poezja</catDesc>  <catDesc xml:lang="en">
                              poetry</catDesc> </category> <category xml:id="LDRAMA">
                                <catDesc xml:lang="pl">
                              dramat</catDesc>  <catDesc xml:lang="en">
                              drama</catDesc> </category></category>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `catRef`<span id="catRef"/>
 
 
**catRef** (category reference) specifies one or more defined categories within some taxonomy or text typology. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-catRef.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.pointing](#att.pointing)  (`@targetLang`, `@target`, `@evaluate`) 
 
 
`@scheme` identifies the classification scheme within which the set of categories concerned is defined, for example by a `taxonomy` element, or by some other resource. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [textClass](#textClass) 
 
 
 
 
 
#### **May contain**
 
Empty element
 
 
 
 
 
#### **Note**
 
The scheme attribute needs to be supplied only if more than one taxonomy has been declared. 
 
 
 
 
 
#### **Example**
 
 
```
 
<catRef scheme="#myTopics" target="#news #prov #sales2"/><!-- elsewhere --><taxonomy xml:id="myTopics">
                               <category xml:id="news">
                                <catDesc>Newspapers</catDesc> </category> <category xml:id="prov">
                                <catDesc>Provincial</catDesc> </category> <category xml:id="sales2">
                                <catDesc>Low to average annual sales</catDesc> </category></taxonomy>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `change`<span id="change"/>
 
 
**change** documents a change or set of changes made during the production of a source document, or during the revision of an electronic file. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-change.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.ascribed](#att.ascribed) `@who`)  [att.datable](#att.datable)  (`@calendar`, `@period`) ( [att.datable.w3c](#att.datable.w3c)  (`@when`, `@notBefore`, `@notAfter`, `@from`, `@to`))  [att.docStatus](#att.docStatus)  (`@status`)  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
`@target` points to one or more elements that belong to this change. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [listChange](#listChange)  [revisionDesc](#revisionDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The who attribute may be used to point to any other element, but will typically specify a  [respStmt](#respStmt)  or `person` element elsewhere in the header, identifying the person responsible for the change and their role in making it. It is recommended that changes be recorded with the most recent first. The status attribute may be used to indicate the status of a document following the change documented. 
 
 
 
 
 
#### **Example**
 
 
```
 
<titleStmt> <title> ... </title> <editor xml:id="LDB">
                              Lou Burnard</editor> <respStmt xml:id="BZ">
                                <resp>copy editing</resp>  <name>Brett Zamir</name> </respStmt></titleStmt><!-- ... --><revisionDesc status="published">
                               <change who="#BZ" when="2008-02-02"  status="public">
                              Finished chapter 23</change> <change who="#BZ" when="2008-01-02"  status="draft">
                              Finished chapter 2</change> <change n="P2.2" when="1991-12-21"  who="#LDB">
                              Added examples to section 3</change> <change when="1991-11-11" who="#MSM">
                              Deleted chapter 10</change></revisionDesc>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<profileDesc> <creation>  <listChange>   <change xml:id="DRAFT1">
                              First draft in pencil</change>   <change xml:id="DRAFT2"    notBefore="1880-12-09">
                              First revision, mostly       using green ink</change>   <change xml:id="DRAFT3"    notBefore="1881-02-13">
                              Final corrections as       supplied to printer.</change>  </listChange> </creation></profileDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `choice`<span id="choice"/>
 
 
**choice** groups a number of alternative encodings for the same point in a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-choice.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [author](#author)  [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [choice](#choice)  [corr](#corr)  [orig](#orig)  [reg](#reg)  [sic](#sic)  [unclear](#unclear) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **Note**
 
Because the children of a  [choice](#choice)  element all represent alternative ways of encoding the same sequence, it is natural to think of them as mutually exclusive. However, there may be cases where a full representation of a text requires the alternative encodings to be considered as parallel. Note also that  [choice](#choice)  elements may self-nest. Where the purpose of an encoding is to record multiple witnesses of a single work, rather than to identify multiple possible encoding decisions at a given point, the `app` element and associated elements discussed in section  [12.1. The Apparatus Entry, Readings, and Witnesses](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/TC.html#TCAPLL)  should be preferred. 
 
 
 
 
 
#### **Example**
 
An American encoding of Gulliver's Travels which retains the British spelling but also provides a version regularized to American spelling might be encoded as follows. 
```
 
<p>Lastly, That, upon his solemn oath to observe all the above articles, the said man-mountain shall have a daily allowance of meat and drink sufficient for the support of <choice>  <sic>1724</sic>  <corr>1728</corr> </choice> of our subjects, with free access to our royal person, and other marks of our<choice>  <orig>favour</orig>  <reg>favor</reg> </choice>.</p>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `closer`<span id="closer"/>
 
 
**closer** groups together salutations, datelines, and similar phrases appearing as a final group at the end of a division, especially of a letter. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-closer.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.written](#att.written)  (`@hand`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list) 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [front](#front) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**textstructure:** [dateline](#dateline) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<div type="letter">
                               <p> perhaps you will favour me with a sight of it when convenient.</p> <closer>  <salute>I remain, &amp;c. &amp;c.</salute>  <signed>H. Colburn</signed> </closer></div>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<div type="chapter">
                               <p><!-- ... --> and his heart was going like mad and yes I said yes I will Yes.</p> <closer>  <dateline>   <name type="place">
                              Trieste-Zürich-Paris,</name>   <date>1914–1921</date>  </dateline> </closer></div>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `code`<span id="code"/>
 
 
**code** contains literal code from some formal language such as a programming language. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-code.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
`@lang` (formal language) a name identifying the formal language in which the code is expressed 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.word
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
Character data only
 
 
 
 
 
#### **Example**
 
 
```
 
<code lang="JAVA">
                               Size fCheckbox1Size = new Size(); fCheckbox1Size.Height = 500; fCheckbox1Size.Width = 500; xCheckbox1.setSize(fCheckbox1Size);</code>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `corr`<span id="corr"/>
 
 
**corr** (correction) contains the correct form of a passage apparently erroneous in the copy text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-corr.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.editLike](#att.editLike)  (`@evidence`, `@instant`)  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [author](#author)  [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
If all that is desired is to call attention to the fact that the copy text has been corrected,  [corr](#corr)  may be used alone: 
```
 
I don't know, Juan. It's so far in the past now — how <corr>can we</corr> prove or disprove anyone's theories?
                        
 
```
 
 
 
 
 
 
#### **Example**
 
It is also possible, using the  [choice](#choice)  and  [sic](#sic)  elements, to provide an uncorrected reading: 
```
 
I don't know, Juan. It's so far in the past now — how <choice> <sic>we can</sic> <corr>can we</corr></choice> prove or disprove anyone's theories?
                        
 
```
 
 
 
 
 
 
 
 ----- 
 
### `creation`<span id="creation"/>
 
 
**creation** contains information about the creation of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-creation.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.datable](#att.datable)  (`@calendar`, `@period`) ( [att.datable.w3c](#att.datable.w3c)  (`@when`, `@notBefore`, `@notAfter`, `@from`, `@to`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [profileDesc](#profileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [choice](#choice)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [hi](#hi)  [name](#name)  [num](#num)  [ref](#ref)  [term](#term)  [title](#title) 
 
**header:** [idno](#idno)  [listChange](#listChange) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) character data
 
 
 
 
 
#### **Note**
 
The  [creation](#creation)  element may be used to record details of a text's creation, e.g. the date and place it was composed, if these are of interest. It may also contain a more structured account of the various stages or revisions associated with the evolution of a text; this should be encoded using the  [listChange](#listChange)  element. It should not be confused with the  [publicationStmt](#publicationStmt)  element, which records date and place of publication. 
 
 
 
 
 
#### **Example**
 
 
```
 
<creation> <date>Before 1987</date></creation>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<creation> <date when="1988-07-10">
                              10 July 1988</date></creation>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `date`<span id="date"/>
 
 
**date** contains a date in any format. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-date.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`)  [att.datable](#att.datable)  (`@calendar`, `@period`) ( [att.datable.w3c](#att.datable.w3c)  (`@when`, `@notBefore`, `@notAfter`, `@from`, `@to`))  [att.editLike](#att.editLike)  (`@evidence`, `@instant`)  [att.dimensions](#att.dimensions)  (`@unit`, `@quantity`, `@extent`, `@precision`, `@scope`) ( [att.ranging](#att.ranging)  (`@atLeast`, `@atMost`, `@min`, `@max`, `@confidence`))  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [publicationStmt](#publicationStmt)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<date when="1980-02">
                              early February 1980</date>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
Given on the <date when="1977-06-12">
                              Twelfth Day of June in the Year of Our Lord One Thousand Nine Hundred and Seventy-seven of the
                           Republic the Two Hundredth and first and of the University the Eighty-Sixth.</date>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<date when="1990-09">
                              September 1990</date>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `dateline`<span id="dateline"/>
 
 
**dateline** contains a brief description of the place, date, time, etc. of production of a letter, newspaper story, or other work, prefixed or suffixed to it as a kind of heading or trailer. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-dateline.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list) 
 
**textstructure:** [body](#body)  [closer](#closer)  [div](#div)  [front](#front)  [opener](#opener) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**textstructure:** [docDate](#docDate) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<dateline>Walden, this 29. of August 1592</dateline>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<div type="chapter">
                               <p><!-- ... --> and his heart was going like mad and yes I said yes I will Yes.</p> <closer>  <dateline>   <name type="place">
                              Trieste-Zürich-Paris,</name>   <date>1914–1921</date>  </dateline> </closer></div>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `distributor`<span id="distributor"/>
 
 
**distributor** supplies the name of a person or other agency responsible for the distribution of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-distributor.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [publicationStmt](#publicationStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<distributor>Oxford Text Archive</distributor><distributor>Redwood and Burn Ltd</distributor>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `div`<span id="div"/>
 
 
**div** (text division) contains a subdivision of the front, body, or back of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-div.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.divLike](#att.divLike)  (`@org`, `@sample`) ( [att.fragmentable](#att.fragmentable)  (`@part`))  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.declaring](#att.declaring)  (`@decls`)  [att.written](#att.written)  (`@hand`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [front](#front) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [bibl](#bibl)  [gap](#gap)  [head](#head)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [note](#note)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote) 
 
**header:** [biblFull](#biblFull) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [epigraph](#epigraph)  [opener](#opener)  [trailer](#trailer) 
 
 
 
 
 
#### **Example**
 
 
```
 
<body> <div type="part">
                                <head>Fallacies of Authority</head>  <p>The subject of which is Authority in various shapes, and the object, to repress all     exercise of the reasoning faculty.</p>  <div n="1" type="chapter">
                                 <head>The Nature of Authority</head>   <p>With reference to any proposed measures having for their object the greatest       happiness of the greatest number [...]</p>   <div n="1.1" type="section">
                                  <head>Analysis of Authority</head>    <p>What on any given occasion is the legitimate weight or influence to be attached to         authority [...] </p>   </div>   <div n="1.2" type="section">
                                  <head>Appeal to Authority, in What Cases Fallacious.</head>    <p>Reference to authority is open to the charge of fallacy when [...] </p>   </div>  </div> </div></body>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `docAuthor`<span id="docAuthor"/>
 
 
**docAuthor** (document author) contains the name of the author of the document, as given on the title page (often but not always contained in a byline). [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-docAuthor.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list) 
 
**textstructure:** [back](#back)  [body](#body)  [byline](#byline)  [div](#div)  [front](#front)  [titlePage](#titlePage) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The document author's name often occurs within a byline, but the  [docAuthor](#docAuthor)  element may be used whether the  [byline](#byline)  element is used or not. It should be used only for the author(s) of the entire document, not for author(s) of any subset or part of it. (Attributions of authorship of a subset or part of the document, for example of a chapter in a textbook or an article in a newspaper, may be encoded with  [byline](#byline)  without  [docAuthor](#docAuthor) .) 
 
 
 
 
 
#### **Example**
 
 
```
 
<titlePage> <docTitle>  <titlePart>Travels into Several Remote Nations of the World, in Four     Parts.</titlePart> </docTitle> <byline> By <docAuthor>Lemuel Gulliver</docAuthor>, First a Surgeon,   and then a Captain of several Ships</byline></titlePage>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `docDate`<span id="docDate"/>
 
 
**docDate** (document date) contains the date of a document, as given on a title page or in a dateline. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-docDate.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
`@when` gives the value of the date in standard form, i.e. YYYY-MM-DD. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.temporal.w3c
*  **Note**: For simple dates, the when attribute should give the Gregorian or proleptic Gregorian date in one of the formats specified in XML Schema Part 2: Datatypes Second Edition. 
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list) 
 
**textstructure:** [back](#back)  [body](#body)  [dateline](#dateline)  [div](#div)  [front](#front)  [titlePage](#titlePage) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
Cf. the general  [date](#date)  element in the core tag set. This specialized element is provided for convenience in marking and processing the date of the documents, since it is likely to require specialized handling for many applications. It should be used only for the date of the entire document, not for any subset or part of it. 
 
 
 
 
 
#### **Example**
 
 
```
 
<docImprint>Oxford, Clarendon Press, <docDate>1987</docDate></docImprint>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `docTitle`<span id="docTitle"/>
 
 
**docTitle** (document title) contains the title of a document, including all its constituents, as given on a title page. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-docTitle.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [back](#back)  [front](#front)  [titlePage](#titlePage) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [gap](#gap)  [lb](#lb)  [milestone](#milestone)  [note](#note)  [pb](#pb) 
 
**textstructure:** [titlePart](#titlePart) 
 
 
 
 
 
#### **Example**
 
 
```
 
<docTitle> <titlePart type="main">
                              The DUNCIAD, VARIOURVM.</titlePart> <titlePart type="sub">
                              WITH THE PROLEGOMENA of SCRIBLERUS.</titlePart></docTitle>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `edition`<span id="edition"/>
 
 
**edition** describes the particularities of one edition of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-edition.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [editionStmt](#editionStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<edition>First edition <date>Oct 1990</date></edition><edition n="S2">
                              Students' edition</edition>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `editionStmt`<span id="editionStmt"/>
 
 
**editionStmt** (edition statement) groups information relating to one edition of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-editionStmt.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [biblFull](#biblFull)  [fileDesc](#fileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [author](#author)  [editor](#editor)  [p](#p)  [respStmt](#respStmt) 
 
**header:** [edition](#edition) 
 
 
 
 
 
#### **Example**
 
 
```
 
<editionStmt> <edition n="S2">
                              Students' edition</edition> <respStmt>  <resp>Adapted by </resp>  <name>Elizabeth Kirk</name> </respStmt></editionStmt>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<editionStmt> <p>First edition, <date>Michaelmas Term, 1991.</date> </p></editionStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `editor`<span id="editor"/>
 
 
**editor** contains a secondary statement of responsibility for a bibliographic item, for example the name of an individual, institution or organization, (or of several such) acting as editor, compiler, translator, etc. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-editor.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.naming](#att.naming)  (`@role`, `@nymRef`) ( [att.canonical](#att.canonical)  (`@key`, `@ref`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [editionStmt](#editionStmt)  [seriesStmt](#seriesStmt)  [titleStmt](#titleStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
A consistent format should be adopted.Particularly where cataloguing is likely to be based on the content of the header, it is advisable to use generally recognized authority lists for the exact form of personal names. 
 
 
 
 
 
#### **Example**
 
 
```
 
<editor role="Technical_Editor">
                              Ron Van den Branden</editor><editor role="Editor-in-Chief">
                              John Walsh</editor><editor role="Managing_Editor">
                              Anne Baillot</editor>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `editorialDecl`<span id="editorialDecl"/>
 
 
**editorialDecl** (editorial practice declaration) provides details of editorial principles and practices applied during the encoding of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-editorialDecl.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [encodingDesc](#encodingDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [p](#p) 
 
**header:** [hyphenation](#hyphenation) 
 
 
 
 
 
#### **Example**
 
 
```
 
<editorialDecl> <normalization>  <p>All words converted to Modern American spelling using     Websters 9th Collegiate dictionary  </p> </normalization> <quotation marks="all">
                                <p>All opening quotation marks converted to “ all closing     quotation marks converted to &amp;cdq;.</p> </quotation></editorialDecl>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `emph`<span id="emph"/>
 
 
**emph** (emphasized) marks words or phrases which are stressed or emphasized for linguistic or rhetorical effect. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-emph.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
You took the car and did <emph>what</emph>?!!
                        
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<q>What it all comes to is this,</q> he said. <q> <emph>What   does Christopher Robin do in the morning nowadays?</emph></q>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `encodingDesc`<span id="encodingDesc"/>
 
 
**encodingDesc** (encoding description) documents the relationship between an electronic text and the source or sources from which it was derived. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-encodingDesc.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [teiHeader](#teiHeader) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [p](#p) 
 
**header:** [editorialDecl](#editorialDecl)  [listPrefixDef](#listPrefixDef)  [projectDesc](#projectDesc) 
 
 
 
 
 
#### **Example**
 
 
```
 
<encodingDesc> <p>Basic encoding, capturing lexical information only. All   hyphenation, punctuation, and variant spellings normalized. No   formatting or layout information preserved.</p></encodingDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `epigraph`<span id="epigraph"/>
 
 
**epigraph** contains a quotation, anonymous or attributed, appearing at the start or end of a section or on a title page. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-epigraph.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list) 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [front](#front)  [opener](#opener)  [titlePage](#titlePage) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [bibl](#bibl)  [gap](#gap)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [note](#note)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote) 
 
**header:** [biblFull](#biblFull) 
 
 
 
 
 
#### **Example**
 
 
```
 
<epigraph xml:lang="la">
                               <cit>  <bibl>Lucret.</bibl>  <quote>   <l part="F">
                              petere inde coronam,</l>   <l>Vnde prius nulli velarint tempora Musae.</l>  </quote> </cit></epigraph>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `fileDesc`<span id="fileDesc"/>
 
 
**fileDesc** (file description) contains a full bibliographic description of an electronic file. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-fileDesc.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [biblFull](#biblFull)  [teiHeader](#teiHeader) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [editionStmt](#editionStmt)  [notesStmt](#notesStmt)  [publicationStmt](#publicationStmt)  [seriesStmt](#seriesStmt)  [sourceDesc](#sourceDesc)  [titleStmt](#titleStmt) 
 
 
 
 
 
#### **Note**
 
The major source of information for those seeking to create a catalogue entry or bibliographic citation for an electronic file. As such, it provides a title and statements of responsibility together with details of the publication or distribution of the file, of any series to which it belongs, and detailed bibliographic notes for matters not addressed elsewhere in the header. It also contains a full bibliographic description for the source or sources from which the electronic text was derived. 
 
 
 
 
 
#### **Example**
 
 
```
 
<fileDesc> <titleStmt>  <title>The shortest possible TEI document</title> </titleStmt> <publicationStmt>  <p>Distributed as part of TEI P5</p> </publicationStmt> <sourceDesc>  <p>No print source exists: this is an original digital text</p> </sourceDesc></fileDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `foreign`<span id="foreign"/>
 
 
**foreign** identifies a word or phrase as belonging to some language other than that of the surrounding text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-foreign.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The global xml:lang attribute should be supplied for this element to identify the language of the word or phrase marked. As elsewhere, its value should be a language tag as defined in  [6.1. Language Identification](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/CH.html#CHSH) . This element is intended for use only where no other element is available to mark the phrase or words concerned. The global xml:lang attribute should be used in preference to this element where it is intended to mark the language of the whole of some text element. The `distinct` element may be used to identify phrases belonging to sublanguages or registers not generally regarded as true languages. 
 
 
 
 
 
#### **Example**
 
 
```
 
This is heathen Greek to you still? Your <foreign xml:lang="la">
                              lapis philosophicus</foreign>?
                        
 
```
 
 
 
 
 
 
 
 ----- 
 
### `front`<span id="front"/>
 
 
**front** (front matter) contains any prefatory matter (headers, abstracts, title page, prefaces, dedications, etc.) found at the start of a document, before the main body. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-front.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declaring](#att.declaring)  (`@decls`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [text](#text) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [gap](#gap)  [head](#head)  [lb](#lb)  [listBibl](#listBibl)  [milestone](#milestone)  [note](#note)  [p](#p)  [pb](#pb) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [epigraph](#epigraph)  [titlePage](#titlePage)  [titlePart](#titlePart)  [trailer](#trailer) 
 
 
 
 
 
#### **Note**
 
Because cultural conventions differ as to which elements are grouped as front matter and which as back matter, the content models for the  [front](#front)  and  [back](#back)  elements are identical. 
 
 
 
 
 
#### **Example**
 
 
```
 
<front> <epigraph>  <quote>Nam Sibyllam quidem Cumis ego ipse oculis meis vidi in ampulla     pendere, et cum illi pueri dicerent: <q xml:lang="gr">
                              Σίβυλλα τί       θέλεις</q>; respondebat illa: <q xml:lang="gr">
                              ὰποθανεῖν θέλω.</q>  </quote> </epigraph> <div type="dedication">
                                <p>For Ezra Pound <q xml:lang="it">
                              il miglior fabbro.</q>  </p> </div></front>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<front> <div type="dedication">
                                <p>To our three selves</p> </div> <div type="preface">
                                <head>Author's Note</head>  <p>All the characters in this book are purely imaginary, and if the     author has used names that may suggest a reference to living persons     she has done so inadvertently. ...</p> </div></front>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<front> <div type="abstract">
                                <div>   <head> BACKGROUND:</head>   <p>Food insecurity can put children at greater risk of obesity because       of altered food choices and nonuniform consumption patterns.</p>  </div>  <div>   <head> OBJECTIVE:</head>   <p>We examined the association between obesity and both child-level       food insecurity and personal food insecurity in US children.</p>  </div>  <div>   <head> DESIGN:</head>   <p>Data from 9,701 participants in the National Health and Nutrition       Examination Survey, 2001-2010, aged 2 to 11 years were analyzed.       Child-level food insecurity was assessed with the US Department of       Agriculture's Food Security Survey Module based on eight       child-specific questions. Personal food insecurity was assessed with       five additional questions. Obesity was defined, using physical       measurements, as body mass index (calculated as kg/m2) greater than       or equal to the age- and sex-specific 95th percentile of the Centers       for Disease Control and Prevention growth charts. Logistic       regressions adjusted for sex, race/ethnic group, poverty level, and       survey year were conducted to describe associations between obesity       and food insecurity.</p>  </div>  <div>   <head> RESULTS:</head>   <p>Obesity was significantly associated with personal food insecurity       for children aged 6 to 11 years (odds ratio=1.81; 95% CI 1.33 to       2.48), but not in children aged 2 to 5 years (odds ratio=0.88; 95%       CI 0.51 to 1.51). Child-level food insecurity was not associated       with obesity among 2- to 5-year-olds or 6- to 11-year-olds.</p>  </div>  <div>   <head> CONCLUSIONS:</head>   <p>Personal food insecurity is associated with an increased risk of       obesity only in children aged 6 to 11 years. Personal       food-insecurity measures may give different results than aggregate       food-insecurity measures in children.</p>  </div> </div></front>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `gap`<span id="gap"/>
 
 
**gap** indicates a point where material has been omitted in a transcription, whether for editorial reasons described in the TEI header, as part of sampling practice, or because the material is illegible, invisible, or inaudible. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-gap.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.timed](#att.timed)  (`@start`, `@end`)  [att.editLike](#att.editLike)  (`@evidence`, `@instant`)  [att.dimensions](#att.dimensions)  (`@unit`, `@quantity`, `@extent`, `@precision`, `@scope`) ( [att.ranging](#att.ranging)  (`@atLeast`, `@atMost`, `@min`, `@max`, `@confidence`)) 
 
 
`@reason` gives the reason for omission 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.enumerated separated by whitespace
*  **Suggested values include:**: 
 
     *    **cancelled** [No description available]
     *    **deleted** [No description available]
     *    **editorial** for features omitted from transcription due to editorial policy
     *    **illegible** [No description available]
     *    **inaudible** [No description available]
     *    **irrelevant** [No description available]
     *    **sampling** [No description available]
 
 
 
`@agent` in the case of text omitted because of damage, categorizes the cause of the damage, if it can be identified. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Sample values include:**: 
 
     *    **rubbing** damage results from rubbing of the leaf edges
     *    **mildew** damage results from mildew on the leaf surface
     *    **smoke** damage results from smoke
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [lg](#lg)  [list](#list)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence) 
 
**textstructure:** [back](#back)  [body](#body)  [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [epigraph](#epigraph)  [front](#front)  [opener](#opener)  [text](#text)  [titlePage](#titlePage)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
Empty element
 
 
 
 
 
#### **Note**
 
The  [gap](#gap) ,  [unclear](#unclear) , and `del` core tag elements may be closely allied in use with the `damage` and  [supplied](#supplied)  elements, available when using the additional tagset for transcription of primary sources. See section  [11.3.3.2. Use of the gap, del, damage, unclear, and supplied Elements in Combination](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/PH.html#PHCOMB)  for discussion of which element is appropriate for which circumstance. The  [gap](#gap)  tag simply signals the editors decision to omit or inability to transcribe a span of text. Other information, such as the interpretation that text was deliberately erased or covered, should be indicated using the relevant tags, such as `del` in the case of deliberate deletion. 
 
 
 
 
 
#### **Example**
 
 
```
 
<gap quantity="4" unit="chars" reason="illegible"/>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<gap quantity="1" unit="essay" reason="sampling"/>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<del> <gap atLeast="4" atMost="8" unit="chars"  reason="illegible"/></del>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<gap extent="several lines" reason="lost"/>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `gi`<span id="gi"/>
 
 
**gi** (element name) contains the name (generic identifier) of an element. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-gi.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
`@scheme` supplies the name of the scheme in which this name is defined. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Sample values include:**: 
 
     *    **TEI** this element is part of the TEI scheme. [Default] 
     *    **DBK** (docbook) this element is part of the Docbook scheme.
     *    **XX** (unknown) this element is part of an unknown scheme.
     *    **Schematron** this element is from Schematron.
     *    **HTML** this element is from the HTML scheme.
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
Empty element
 
 
 
 
 
#### **Example**
 
 
```
 
<p>The <gi>xhtml:li</gi> element is roughly analogous to the <gi>item</gi> element, as is the<gi scheme="DBK">
                              listItem</gi> element.</p>
 
```
This example shows the use of both a namespace prefix and the scheme attribute as alternative ways of indicating that the  [gi](#gi)  in question is not a TEI element name: in practice only one method should be adopted. 
 
 
 
 
 
 
 ----- 
 
### `head`<span id="head"/>
 
 
**head** (heading) contains any type of heading, for example the title of a section, or the heading of a list, glossary, manuscript description, etc. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-head.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.placement](#att.placement)  (`@place`)  [att.written](#att.written)  (`@hand`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list)  [listBibl](#listBibl) 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [front](#front) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The  [head](#head)  element is used for headings at all levels; software which treats (e.g.) chapter headings, section headings, and list titles differently must determine the proper processing of a  [head](#head)  element based on its structural position. A  [head](#head)  occurring as the first element of a list is the title of that list; one occurring as the first element of a `div1` is the title of that chapter or section. 
 
 
 
 
 
#### **Example**
 
The most common use for the  [head](#head)  element is to mark the headings of sections. In older writings, the headings or incipits may be rather longer than usual in modern works. If a section has an explicit ending as well as a heading, it should be marked as a  [trailer](#trailer) , as in this example: 
```
 
<div1 n="I" type="book">
                               <head>In the name of Christ here begins the first book of the ecclesiastical history of   Georgius Florentinus, known as Gregory, Bishop of Tours.</head> <div2 type="section">
                                <head>In the name of Christ here begins Book I of the history.</head>  <p>Proposing as I do ...</p>  <p>From the Passion of our Lord until the death of Saint Martin four hundred and twelve     years passed.</p>  <trailer>Here ends the first Book, which covers five thousand, five hundred and ninety-six     years from the beginning of the world down to the death of Saint Martin.</trailer> </div2></div1>
 
```
 
 
 
 
 
 
#### **Example**
 
When headings are not inline with the running text (see e.g.  [the heading "Secunda conclusio"](http://diglib.hab.de/show_image.php?dir=drucke/ed000364&amp;pointer=34) ) they might however be encoded as if. The actual placement in the source document can be captured with the place attribute. 
```
 
<div type="subsection">
                               <head place="margin">
                              Secunda conclusio</head> <p>  <lb n="1251"/>  <hi rend="large">
                              Potencia: habitus: et actus: recipiunt speciem ab obiectis<supplied>.</supplied>  </hi>  <lb n="1252"/>Probatur sic. Omne importans necessariam habitudinem ad proprium   [...] </p></div>
 
```
 
 
 
 
 
 
#### **Example**
 
The  [head](#head)  element is also used to mark headings of other units, such as lists: 
```
 
With a few exceptions, connectives are equally useful in all kinds of discourse: description, narration, exposition, argument. <list rend="bulleted">
                               <head>Connectives</head> <item>above</item> <item>accordingly</item> <item>across from</item> <item>adjacent to</item> <item>again</item> <item><!-- ... --> </item></list>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `hi`<span id="hi"/>
 
 
**hi** (highlighted) marks a word or phrase as graphically distinct from the surrounding text, for reasons concerning which no claim is made. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-hi.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.written](#att.written)  (`@hand`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<hi rend="gothic">
                              And this Indenture further witnesseth</hi> that the said <hi rend="italic">
                              Walter Shandy</hi>, merchant, in consideration of the said intended marriage ...
                        
 
```
 
 
 
 
 
 
 
 ----- 
 
### `hyphenation`<span id="hyphenation"/>
 
 
**hyphenation** summarizes the way in which hyphenation in a source text has been treated in an encoded version of it. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-hyphenation.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`) 
 
 
`@eol` (end-of-line) indicates whether or not end-of-line hyphenation has been retained in a text. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **all** all end-of-line hyphenation has been retained, even though the lineation of the original
                                                may not have been.
                                             
     *    **some** end-of-line hyphenation has been retained in some cases. [Default] 
     *    **hard** all soft end-of-line hyphenation has been removed: any remaining end-of-line hyphenation
                                                should be retained.
                                             
     *    **none** all end-of-line hyphenation has been removed: any remaining hyphenation occurred within
                                                the line.
                                             
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [editorialDecl](#editorialDecl) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [p](#p) 
 
 
 
 
 
#### **Example**
 
 
```
 
<hyphenation eol="some">
                               <p>End-of-line hyphenation silently removed where appropriate</p></hyphenation>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `idno`<span id="idno"/>
 
 
**idno** (identifier) supplies any form of identifier used to identify some object, such as a bibliographic item, a person, a title, an organization, etc. in a standardized way. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-idno.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.sortable](#att.sortable)  (`@sortKey`)  [att.datable](#att.datable)  (`@calendar`, `@period`) ( [att.datable.w3c](#att.datable.w3c)  (`@when`, `@notBefore`, `@notAfter`, `@from`, `@to`))  [att.typed](#att.typed)  (type, @subtype) 
 
 
`@type` categorizes the identifier, for example as an ISBN, Social Security number, etc. 
 
 
*  **Derived from**:  [att.typed](#att.typed) 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Suggested values include:**: 
 
     *    **ISBN** International Standard Book Number: a 13- or (if assigned prior to 2007) 10-digit
                                                identifying number assigned by the publishing industry to a published book or similar
                                                item, registered with the International ISBN Agency.
     *    **ISSN** International Standard Serial Number: an eight-digit number to uniquely identify a
                                                serial publication.
                                             
     *    **DOI** Digital Object Identifier: a unique string of letters and numbers assigned to an electronic
                                                document.
                                             
     *    **URI** Uniform Resource Identifier: a string of characters to uniquely identify a resource
                                                which usually contains indication of the means of accessing that resource, the name
                                                of its host, and its filepath.
                                             
     *    **VIAF** A data number in the Virtual Internet Authority File assigned to link different names
                                                in catalogs around the world for the same entity.
                                             
     *    **ESTC** English Short-Title Catalogue number: an identifying number assigned to a document
                                                in English printed in the British Isles or North America before 1801.
                                             
     *    **OCLC** OCLC control number (record number) for the union catalog record in WorldCat, a union
                                                catalog for member libraries in the Online Computer Library Center global cooperative.
                                             
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [idno](#idno)  [language](#language)  [licence](#licence)  [publicationStmt](#publicationStmt)  [rendition](#rendition)  [seriesStmt](#seriesStmt) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [idno](#idno) character data
 
 
 
 
 
#### **Note**
 
 [idno](#idno)  should be used for labels which identify an object or concept in a formal cataloguing system such as a database or an RDF store, or in a distributed system such as the World Wide Web. Some suggested values for type on  [idno](#idno)  are ISBN, ISSN, DOI, and URI. 
 
 
 
 
 
#### **Example**
 
 
```
 
<idno type="ISBN">
                              978-1-906964-22-1</idno><idno type="ISSN">
                              0143-3385</idno><idno type="DOI">
                              10.1000/123</idno><idno type="URI">
                              http://www.worldcat.org/oclc/185922478</idno><idno type="URI">
                              http://authority.nzetc.org/463/</idno><idno type="LT">
                              Thomason Tract E.537(17)</idno><idno type="Wing">
                              C695</idno><idno type="oldCat">
                               <g ref="#sym"/>345</idno>
 
```
In the last case, the identifier includes a non-Unicode character which is defined elsewhere by means of a `glyph` or `char` element referenced here as `#sym`. 
 
 
 
 
 
 
 ----- 
 
### `item`<span id="item"/>
 
 
**item** contains one component of a list. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-item.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.sortable](#att.sortable)  (`@sortKey`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [list](#list) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
May contain simple prose or a sequence of chunks.Whatever string of characters is used to label a list item in the copy text may be used as the value of the global n attribute, but it is not required that numbering be recorded explicitly. In ordered lists, the n attribute on the  [item](#item)  element is by definition synonymous with the use of the `label` element to record the enumerator of the list item. In glossary lists, however, the term being defined should be given with the `label` element, not n. 
 
 
 
 
 
#### **Example**
 
 
```
 
<list rend="numbered">
                               <head>Here begin the chapter headings of Book IV</head> <item n="4.1">
                              The death of Queen Clotild.</item> <item n="4.2">
                              How King Lothar wanted to appropriate one third of the Church revenues.</item> <item n="4.3">
                              The wives and children of Lothar.</item> <item n="4.4">
                              The Counts of the Bretons.</item> <item n="4.5">
                              Saint Gall the Bishop.</item> <item n="4.6">
                              The priest Cato.</item> <item> ...</item></list>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `keywords`<span id="keywords"/>
 
 
**keywords** contains a list of keywords or phrases identifying the topic or nature of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-keywords.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
`@scheme` identifies the controlled vocabulary within which the set of keywords concerned is defined, for example by a `taxonomy` element, or by some other resource. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [textClass](#textClass) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [list](#list)  [term](#term) 
 
 
 
 
 
#### **Note**
 
Each individual keyword (including compound subject headings) should be supplied as a  [term](#term)  element directly within the  [keywords](#keywords)  element. An alternative usage, in which each  [term](#term)  appears within a  [item](#item)  inside a  [list](#list)  is permitted for backwards compatibility, but is deprecated. If no control list exists for the keywords used, then no value should be supplied for the scheme attribute. 
 
 
 
 
 
#### **Example**
 
 
```
 
<keywords scheme="http://classificationweb.net">
                               <term>Babbage, Charles</term> <term>Mathematicians - Great Britain - Biography</term></keywords>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<keywords> <term>Fermented beverages</term> <term>Central Andes</term> <term>Schinus molle</term> <term>Molle beer</term> <term>Indigenous peoples</term> <term>Ethnography</term> <term>Archaeology</term></keywords>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `l`<span id="l"/>
 
 
**l** (verse line) contains a single, possibly incomplete, line of verse. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-l.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.fragmentable](#att.fragmentable)  (`@part`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [corr](#corr)  [emph](#emph)  [head](#head)  [hi](#hi)  [item](#item)  [lg](#lg)  [note](#note)  [orig](#orig)  [p](#p)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [licence](#licence) 
 
**textstructure:** [body](#body)  [div](#div)  [epigraph](#epigraph)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<l met="x/x/x/x/x/" real="/xx/x/x/x/">
                              Shall I compare thee to a summer's day?</l>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `language`<span id="language"/>
 
 
**language** characterizes a single language or sublanguage used within a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-language.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
`@ident` (identifier) Supplies a language code constructed as defined in  [BCP 47](https://tools.ietf.org/html/bcp47)  which is used to identify the language documented by this element, and which is referenced by the global xml:lang attribute. 
 
 
*  **Status**: Required
*  **Datatype**: teidata.language
 
 
 
`@usage` specifies the approximate percentage (by volume) of the text which uses this language. 
 
 
*  **Status**: Optional
*  **Datatype**: nonNegativeInteger
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [langUsage](#langUsage) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [choice](#choice)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [pb](#pb)  [ref](#ref)  [term](#term)  [title](#title) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) character data
 
 
 
 
 
#### **Note**
 
Particularly for sublanguages, an informal prose characterization should be supplied as content for the element. 
 
 
 
 
 
#### **Example**
 
 
```
 
<langUsage> <language ident="en-US" usage="75">
                              modern American English</language> <language ident="i-az-Arab" usage="20">
                              Azerbaijani in Arabic script</language> <language ident="x-lap" usage="05">
                              Pig Latin</language></langUsage>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `langUsage`<span id="langUsage"/>
 
 
**langUsage** (language usage) describes the languages, sublanguages, registers, dialects, etc. represented within a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-langUsage.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [profileDesc](#profileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [p](#p) 
 
**header:** [language](#language) 
 
 
 
 
 
#### **Example**
 
 
```
 
<langUsage> <language ident="fr-CA" usage="60">
                              Québecois</language> <language ident="en-CA" usage="20">
                              Canadian business English</language> <language ident="en-GB" usage="20">
                              British English</language></langUsage>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `lb`<span id="lb"/>
 
 
**lb** (line beginning) marks the beginning of a new (typographic) line in some edition or version of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-lb.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.edition](#att.edition)  (`@ed`, `@edRef`)  [att.spanning](#att.spanning)  (`@spanTo`)  [att.breaking](#att.breaking)  (`@break`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence) 
 
**textstructure:** [back](#back)  [body](#body)  [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [epigraph](#epigraph)  [front](#front)  [opener](#opener)  [text](#text)  [titlePage](#titlePage)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
Empty element
 
 
 
 
 
#### **Note**
 
By convention,  [lb](#lb)  elements should appear at the point in the text where a new line starts. The n attribute, if used, indicates the number or other value associated with the text between this point and the next  [lb](#lb)  element, typically the sequence number of the line within the page, or other appropriate unit. This element is intended to be used for marking actual line breaks on a manuscript or printed page, at the point where they occur; it should not be used to tag structural units such as lines of verse (for which the  [l](#l)  element is available) except in circumstances where structural units cannot otherwise be marked. The type attribute may be used to characterize the line break in any respect. The more specialized attributes break, ed, or edRef should be preferred when the intent is to indicate whether or not the line break is word-breaking, or to note the source from which it derives. 
 
 
 
 
 
#### **Example**
 
This example shows typographical line breaks within metrical lines, where they occur at different places in different editions: 
```
 
<l>Of Mans First Disobedience,<lb ed="1674"/> and<lb ed="1667"/> the Fruit</l><l>Of that Forbidden Tree, whose<lb ed="1667 1674"/> mortal tast</l><l>Brought Death into the World,<lb ed="1667"/> and all<lb ed="1674"/> our woe,</l>
 
```
 
 
 
 
 
 
#### **Example**
 
This example encodes typographical line breaks as a means of preserving the visual appearance of a title page. The break attribute is used to show that the line break does not (as elsewhere) mark the start of a new word. 
```
 
<titlePart> <lb/>With Additions, ne-<lb break="no"/>ver before Printed.</titlePart>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `lg`<span id="lg"/>
 
 
**lg** (line group) contains one or more verse lines functioning as a formal unit, e.g. a stanza, refrain, verse paragraph, etc. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-lg.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.divLike](#att.divLike)  (`@org`, `@sample`) ( [att.fragmentable](#att.fragmentable)  (`@part`))  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.declaring](#att.declaring)  (`@decls`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [corr](#corr)  [emph](#emph)  [head](#head)  [hi](#hi)  [item](#item)  [lg](#lg)  [note](#note)  [orig](#orig)  [p](#p)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [licence](#licence) 
 
**textstructure:** [body](#body)  [div](#div)  [epigraph](#epigraph)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [gap](#gap)  [head](#head)  [l](#l)  [lb](#lb)  [lg](#lg)  [milestone](#milestone)  [note](#note)  [pb](#pb) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [epigraph](#epigraph)  [opener](#opener)  [trailer](#trailer) 
 
 
 
 
 
#### **Note**
 
contains verse lines or nested line groups only, possibly prefixed by a heading.
 
 
 
 
 
#### **Example**
 
 
```
 
<lg type="free">
                               <l>Let me be my own fool</l> <l>of my own making, the sum of it</l></lg><lg type="free">
                               <l>is equivocal.</l> <l>One says of the drunken farmer:</l></lg><lg type="free">
                               <l>leave him lay off it. And this is</l> <l>the explanation.</l></lg>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `licence`<span id="licence"/>
 
 
**licence** contains information about a licence or other legal agreement applicable to the text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-licence.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.pointing](#att.pointing)  (`@targetLang`, `@target`, `@evaluate`)  [att.datable](#att.datable)  (`@calendar`, `@period`) ( [att.datable.w3c](#att.datable.w3c)  (`@when`, `@notBefore`, `@notAfter`, `@from`, `@to`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [availability](#availability) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
A  [licence](#licence)  element should be supplied for each licence agreement applicable to the text in question. The target attribute may be used to reference a full version of the licence. The when, notBefore, notAfter, from or to attributes may be used in combination to indicate the date or dates of applicability of the licence. 
 
 
 
 
 
#### **Example**
 
 
```
 
<licence target="http://www.nzetc.org/tm/scholarly/tei-NZETC-Help.html#licensing">
                               Licence: Creative Commons Attribution-Share Alike 3.0 New Zealand Licence</licence>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<availability> <licence target="http://creativecommons.org/licenses/by/3.0/"  notBefore="2013-01-01">
                                <p>The Creative Commons Attribution 3.0 Unported (CC BY 3.0) Licence     applies to this document.</p>  <p>The licence was added on January 1, 2013.</p> </licence></availability>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `list`<span id="list"/>
 
 
**list** contains any sequence of items organized as a list. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-list.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.sortable](#att.sortable)  (`@sortKey`)  [att.typed](#att.typed)  (type, @subtype) 
 
 
`@type` describes the nature of the items in the list. 
 
 
*  **Derived from**:  [att.typed](#att.typed) 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Suggested values include:**: 
 
     *    **gloss** each list item glosses some term or concept, which is given by a label element preceding the list item.
                                             
     *    **index** each list item is an entry in an index such as the alphabetical topical index at the
                                                back of a print volume.
                                             
     *    **instructions** each list item is a step in a sequence of instructions, as in a recipe.
     *    **litany** each list item is one of a sequence of petitions, supplications or invocations, typically
                                                in a religious ritual.
                                             
     *    **syllogism** each list item is part of an argument consisting of two or more propositions and a
                                                final conclusion derived from them.
                                             
*  **Note**: Previous versions of these Guidelines recommended the use of type on  [list](#list)  to encode the rendering or appearance of a list (whether it was bulleted, numbered, etc.). The current recommendation is to use the rend or style attributes for these aspects of a list, while using type for the more appropriate task of characterizing the nature of the content of a list. 
*  **Note**: The formal syntax of the element declarations allows `label` tags to be omitted from lists tagged &lt;list type="gloss"&gt;; this is however a semantic error. 
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [corr](#corr)  [emph](#emph)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [note](#note)  [orig](#orig)  [p](#p)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [title](#title)  [unclear](#unclear) 
 
**header:** [abstract](#abstract)  [change](#change)  [keywords](#keywords)  [licence](#licence)  [rendition](#rendition)  [revisionDesc](#revisionDesc)  [sourceDesc](#sourceDesc) 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [epigraph](#epigraph)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [gap](#gap)  [head](#head)  [item](#item)  [lb](#lb)  [milestone](#milestone)  [note](#note)  [pb](#pb) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [epigraph](#epigraph)  [opener](#opener)  [trailer](#trailer) 
 
 
 
 
 
#### **Note**
 
May contain an optional heading followed by a series of items, or a series of label and item pairs, the latter being optionally preceded by one or two specialized headings. 
 
 
 
 
 
#### **Example**
 
 
```
 
<list rend="numbered">
                               <item>a butcher</item> <item>a baker</item> <item>a candlestick maker, with <list rend="bulleted">
                                 <item>rings on his fingers</item>   <item>bells on his toes</item>  </list> </item></list>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<list type="syllogism" rend="bulleted">
                               <item>All Cretans are liars.</item> <item>Epimenides is a Cretan.</item> <item>ERGO Epimenides is a liar.</item></list>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<list type="litany" rend="simple">
                               <item>God save us from drought.</item> <item>God save us from pestilence.</item> <item>God save us from wickedness in high places.</item> <item>Praise be to God.</item></list>
 
```
 
 
 
 
 
 
#### **Example**
 
The following example treats the short numbered clauses of Anglo-Saxon legal codes as lists of items. The text is from an ordinance of King Athelstan (924–939): 
```
 
<div1 type="section">
                               <head>Athelstan's Ordinance</head> <list rend="numbered">
                                <item n="1">
                              Concerning thieves. First, that no thief is to be spared who is caught with     the stolen goods, [if he is] over twelve years and [if the value of the goods
                           is] over     eightpence.  <list rend="numbered">
                                  <item n="1.1">
                              And if anyone does spare one, he is to pay for the thief with his         wergild — and the thief is to be no nearer a settlement on that account —
                           or to         clear himself by an oath of that amount.</item>    <item n="1.2">
                              If, however, he [the thief] wishes to defend himself or to escape, he is         not to be spared [whether younger or older than twelve].</item>    <item n="1.3">
                              If a thief is put into prison, he is to be in prison 40 days, and he may         then be redeemed with 120 shillings; and the kindred are to stand surety
                           for him         that he will desist for ever.</item>    <item n="1.4">
                              And if he steals after that, they are to pay for him with his wergild,         or to bring him back there.</item>    <item n="1.5">
                              And if he steals after that, they are to pay for him with his wergild,         whether to the king or to him to whom it rightly belongs; and everyone of
                           those who         supported him is to pay 120 shillings to the king as a fine.</item>   </list>  </item>  <item n="2">
                              Concerning lordless men. And we pronounced about these lordless men, from whom     no justice can be obtained, that one should order their kindred to fetch back
                           such a     person to justice and to find him a lord in public meeting.  <list rend="numbered">
                                  <item n="2.1">
                              And if they then will not, or cannot, produce him on that appointed day,         he is then to be a fugitive afterwards, and he who encounters him is to strike
                           him         down as a thief.</item>    <item n="2.2">
                              And he who harbours him after that, is to pay for him with his wergild         or to clear himself by an oath of that amount.</item>   </list>  </item>  <item n="3">
                              Concerning the refusal of justice. The lord who refuses justice and upholds     his guilty man, so that the king is appealed to, is to repay the value of the
                           goods and     120 shillings to the king; and he who appeals to the king before he demands justice
                           as     often as he ought, is to pay the same fine as the other would have done, if he
                           had     refused him justice.  <list rend="numbered">
                                  <item n="3.1">
                              And the lord who is an accessory to a theft by his slave, and it becomes         known about him, is to forfeit the slave and be liable to his wergild on
                           the first         occasionp if he does it more often, he is to be liable to pay all that he
                           owns.</item>    <item n="3.2">
                              And likewise any of the king's treasurers or of our reeves, who has been         an accessory of thieves who have committed theft, is to liable to the same.</item>   </list>  </item>  <item n="4">
                              Concerning treachery to a lord. And we have pronounced concerning treachery to     a lord, that he [who is accused] is to forfeit his life if he cannot deny it
                           or is     afterwards convicted at the three-fold ordeal.</item> </list></div1>
 
```
Note that nested lists have been used so the tagging mirrors the structure indicated by the two-level numbering of the clauses. The clauses could have been treated as a one-level list with irregular numbering, if desired. 
 
 
 
 
 
#### **Example**
 
 
```
 
<p>These decrees, most blessed Pope Hadrian, we propounded in the public council ...
                           and they confirmed them in our hand in your stead with the sign of the Holy Cross, and afterwards inscribed with a careful pen on the paper of this page, affixing thus the sign of
                           the Holy Cross.<list rend="simple">
                                <item>I, Eanbald, by the grace of God archbishop of the holy church of York, have     subscribed to the pious and catholic validity of this document with the sign
                           of the Holy     Cross.</item>  <item>I, Ælfwold, king of the people across the Humber, consenting have subscribed with     the sign of the Holy Cross.</item>  <item>I, Tilberht, prelate of the church of Hexham, rejoicing have subscribed with the     sign of the Holy Cross.</item>  <item>I, Higbald, bishop of the church of Lindisfarne, obeying have subscribed with the     sign of the Holy Cross.</item>  <item>I, Ethelbert, bishop of Candida Casa, suppliant, have subscribed with thef sign of     the Holy Cross.</item>  <item>I, Ealdwulf, bishop of the church of Mayo, have subscribed with devout will.</item>  <item>I, Æthelwine, bishop, have subscribed through delegates.</item>  <item>I, Sicga, patrician, have subscribed with serene mind with the sign of the Holy     Cross.</item> </list></p>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `listBibl`<span id="listBibl"/>
 
 
**listBibl** (citation list) contains a list of bibliographic citations of any kind. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-listBibl.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.sortable](#att.sortable)  (`@sortKey`)  [att.declarable](#att.declarable)  (`@default`)  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [corr](#corr)  [emph](#emph)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [listBibl](#listBibl)  [note](#note)  [orig](#orig)  [p](#p)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [sic](#sic)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [licence](#licence)  [rendition](#rendition)  [sourceDesc](#sourceDesc) 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [epigraph](#epigraph)  [front](#front)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [bibl](#bibl)  [head](#head)  [lb](#lb)  [listBibl](#listBibl)  [milestone](#milestone)  [pb](#pb) 
 
**header:** [biblFull](#biblFull) 
 
 
 
 
 
#### **Example**
 
 
```
 
<listBibl> <head>Works consulted</head> <bibl>Blain, Clements and Grundy: Feminist Companion to   Literature in English (Yale, 1990) </bibl> <biblStruct>  <analytic>   <title>The Interesting story of the Children in the Wood</title>  </analytic>  <monogr>   <title>The Penny Histories</title>   <author>Victor E Neuberg</author>   <imprint>    <publisher>OUP</publisher>    <date>1968</date>   </imprint>  </monogr> </biblStruct></listBibl>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `listChange`<span id="listChange"/>
 
 
**listChange** groups a number of change descriptions associated with either the creation of a source text or the revision of an encoded text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-listChange.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.sortable](#att.sortable)  (`@sortKey`)  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
`@ordered` indicates whether the ordering of its child  [change](#change)  elements is to be considered significant or not 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.truthValue
*  **Default**: true
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [creation](#creation)  [listChange](#listChange)  [revisionDesc](#revisionDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [change](#change)  [listChange](#listChange) 
 
 
 
 
 
#### **Note**
 
When this element appears within the  [creation](#creation)  element it documents the set of revision campaigns or stages identified during the evolution of the original text. When it appears within the  [revisionDesc](#revisionDesc)  element, it documents only changes made during the evolution of the encoded representation of that text. 
 
 
 
 
 
#### **Example**
 
 
```
 
<revisionDesc> <listChange>  <change when="1991-11-11" who="#LB">
                               deleted chapter 10 </change>  <change when="1991-11-02" who="#MSM">
                               completed first draft </change> </listChange></revisionDesc>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<profileDesc> <creation>  <listChange ordered="true">
                                 <change xml:id="CHG-1">
                              First stage, written in ink by a writer</change>   <change xml:id="CHG-2">
                              Second stage, written in Goethe's hand using pencil</change>   <change xml:id="CHG-3">
                              Fixation of the revised passages and further revisions by       Goethe using ink</change>   <change xml:id="CHG-4">
                              Addition of another stanza in a different hand,       probably at a later stage</change>  </listChange> </creation></profileDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `listPrefixDef`<span id="listPrefixDef"/>
 
 
**listPrefixDef** (list of prefix definitions) contains a list of definitions of prefixing schemes used in data.pointer values, showing how abbreviated URIs using each scheme may be expanded into full URIs. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-listPrefixDef.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [encodingDesc](#encodingDesc)  [listPrefixDef](#listPrefixDef) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [listPrefixDef](#listPrefixDef)  [prefixDef](#prefixDef) 
 
 
 
 
 
#### **Example**
 
In this example, two private URI scheme prefixes are defined and patterns are provided for dereferencing them. Each prefix is also supplied with a human-readable explanation in a  [p](#p)  element. 
```
 
<listPrefixDef> <prefixDef ident="psn"  matchPattern="([A-Z]+)"  replacementPattern="personography.xml#$1">
                                <p> Private URIs using the <code>psn</code>     prefix are pointers to <gi>person</gi>     elements in the personography.xml file.     For example, <code>psn:MDH</code>     dereferences to <code>personography.xml#MDH</code>.  </p> </prefixDef> <prefixDef ident="bibl"  matchPattern="([a-z]+[a-z0-9]*)"  replacementPattern="http://www.example.com/getBibl.xql?id=$1">
                                <p> Private URIs using the <code>bibl</code> prefix can be     expanded to form URIs which retrieve the relevant     bibliographical reference from www.example.com.  </p> </prefixDef></listPrefixDef>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `milestone`<span id="milestone"/>
 
 
**milestone** marks a boundary point separating any kind of section of a text, typically but not necessarily indicating a point at which some part of a standard reference system changes, where the change is not represented by a structural element. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-milestone.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.milestoneUnit](#att.milestoneUnit)  (`@unit`)  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.edition](#att.edition)  (`@ed`, `@edRef`)  [att.spanning](#att.spanning)  (`@spanTo`)  [att.breaking](#att.breaking)  (`@break`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence) 
 
**textstructure:** [back](#back)  [body](#body)  [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [epigraph](#epigraph)  [front](#front)  [opener](#opener)  [text](#text)  [titlePage](#titlePage)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
Empty element
 
 
 
 
 
#### **Note**
 
For this element, the global n attribute indicates the new number or other value for the unit which changes at this milestone. The special value unnumbered should be used in passages which fall outside the normal numbering scheme, such as chapter or other headings, poem numbers or titles, etc. The order in which  [milestone](#milestone)  elements are given at a given point is not normally significant. 
 
 
 
 
 
#### **Example**
 
 
```
 
<milestone n="23" ed="La" unit="Dreissiger"/> ... <milestone n="24" ed="AV" unit="verse"/> ...
                        
 
```
 
 
 
 
 
 
 
 ----- 
 
### `name`<span id="name"/>
 
 
**name** (name, proper noun) contains a proper noun or noun phrase. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-name.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.personal](#att.personal)  (`@full`, `@sort`) ( [att.naming](#att.naming)  (`@role`, `@nymRef`) ( [att.canonical](#att.canonical)  (`@key`, `@ref`)) )  [att.datable](#att.datable)  (`@calendar`, `@period`) ( [att.datable.w3c](#att.datable.w3c)  (`@when`, `@notBefore`, `@notAfter`, `@from`, `@to`))  [att.editLike](#att.editLike)  (`@evidence`, `@instant`)  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [respStmt](#respStmt)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
Proper nouns referring to people, places, and organizations may be tagged instead with `persName`, `placeName`, or `orgName`, when the TEI module for names and dates is included. 
 
 
 
 
 
#### **Example**
 
 
```
 
<name type="person">
                              Thomas Hoccleve</name><name type="place">
                              Villingaholt</name><name type="org">
                              Vetus Latina Institut</name><name type="person" ref="#HOC001">
                              Occleve</name>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `note`<span id="note"/>
 
 
**note** contains a note or annotation. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-note.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.placement](#att.placement)  (`@place`)  [att.pointing](#att.pointing)  (`@targetLang`, `@target`, `@evaluate`)  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.written](#att.written)  (`@hand`) 
 
 
`@anchored` indicates whether the copy text shows the exact place of reference for the note. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.truthValue
*  **Default**: true
*  **Note**: In modern texts, notes are usually anchored by means of explicit footnote or endnote symbols. An explicit indication of the phrase or line annotated may however be used instead (e.g. ‘page 218, lines 3–4’). The anchored attribute indicates whether any explicit location is given, whether by symbol or by prose cross-reference. The value true indicates that such an explicit location is indicated in the copy text; the value false indicates that the copy text does not indicate a specific place of attachment for the note. If the specific symbols used in the copy text at the location the note is anchored are to be recorded, use the n attribute. 
 
 
 
`@targetEnd` points to the end of the span to which the note is attached, if the note is not embedded in the text at that point. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  **Note**: This attribute is retained for backwards compatibility; it may be removed at a subsequent release of the Guidelines. The recommended way of pointing to a span of elements is by means of the range function of XPointer, as further described in  [16.2.4.6. range()](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/SA.html#SATSRN) . 
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [lg](#lg)  [list](#list)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [respStmt](#respStmt)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [notesStmt](#notesStmt) 
 
**textstructure:** [back](#back)  [body](#body)  [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [epigraph](#epigraph)  [front](#front)  [opener](#opener)  [text](#text)  [titlePage](#titlePage)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
In the following example, the translator has supplied a footnote containing an explanation of the term translated as "painterly": 
```
 
And yet it is not only in the great line of Italian renaissance art, but even in the painterly <note place="bottom" type="gloss" resp="#MDMH">
                               <term xml:lang="de">
                              Malerisch</term>. This word has, in the German, two distinct meanings, one objective, a quality residing in the object, the other subjective, a mode of apprehension and creation. To avoid confusion, they have been distinguished in English as<mentioned>picturesque</mentioned> and<mentioned>painterly</mentioned> respectively.</note> style of the Dutch genre painters of the seventeenth century that drapery has this psychological significance.<!-- elsewhere in the document --><respStmt xml:id="MDMH">
                               <resp>translation from German to English</resp> <name>Hottinger, Marie Donald Mackie</name></respStmt>
 
```
For this example to be valid, the code MDMH must be defined elsewhere, for example by means of a responsibility statement in the associated TEI header. 
 
 
 
 
 
#### **Example**
 
The global n attribute may be used to supply the symbol or number used to mark the note's point of attachment in the source text, as in the following example: 
```
 
Mevorakh b. Saadya's mother, the matriarch of the family during the second half of the eleventh century, <note n="126" anchored="true">
                               The alleged mention of Judah Nagid's mother in a letter from 1071 is, in fact, a reference
                           to Judah's children; cf. above, nn. 111 and 54. </note> is well known from Geniza documents published by Jacob Mann.
                        
 
```
However, if notes are numbered in sequence and their numbering can be reconstructed automatically by processing software, it may well be considered unnecessary to record the note numbers. 
 
 
 
 
 
 
 ----- 
 
### `notesStmt`<span id="notesStmt"/>
 
 
**notesStmt** (notes statement) collects together any notes providing information about a text additional to that recorded in other parts of the bibliographic description. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-notesStmt.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [biblFull](#biblFull)  [fileDesc](#fileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [note](#note)  [relatedItem](#relatedItem) 
 
 
 
 
 
#### **Note**
 
Information of different kinds should not be grouped together into the same note.
 
 
 
 
 
#### **Example**
 
 
```
 
<notesStmt> <note>Historical commentary provided by Mark Cohen</note> <note>OCR scanning done at University of Toronto</note></notesStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `num`<span id="num"/>
 
 
**num** (number) contains a number, written in any form. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-num.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.ranging](#att.ranging)  (`@atLeast`, `@atMost`, `@min`, `@max`, `@confidence`) 
 
 
`@type` indicates the type of numeric value. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Suggested values include:**: 
 
     *    **cardinal** absolute number, e.g. 21, 21.5
     *    **ordinal** ordinal number, e.g. 21st
     *    **fraction** fraction, e.g. one half or three-quarters
     *    **percentage** a percentage
*  **Note**: If a different typology is desired, other values can be used for this attribute.
 
 
 
`@value` supplies the value of the number in standard form. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.numeric
*  **Values**: a numeric value.
*  **Note**: The standard form used is defined by the TEI datatype data.numeric.
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
Detailed analyses of quantities and units of measure in historical documents may also use the feature structure mechanism described in chapter  [18. Feature Structures](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/FS.html#FS) . The  [num](#num)  element is intended for use in simple applications. 
 
 
 
 
 
#### **Example**
 
 
```
 
<p>I reached <num type="cardinal" value="21">
                              twenty-one</num> on my <num type="ordinal" value="21">
                              twenty-first</num> birthday</p><p>Light travels at <num value="3E10">
                              3×10<hi rend="sup">
                              10</hi> </num> cm per second.</p>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `opener`<span id="opener"/>
 
 
**opener** groups together dateline, byline, salutation, and similar phrases appearing as a preliminary group at the start of a division, especially of a letter. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-opener.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.written](#att.written)  (`@hand`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list) 
 
**textstructure:** [body](#body)  [div](#div) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**textstructure:** [byline](#byline)  [dateline](#dateline)  [epigraph](#epigraph) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<opener> <dateline>Walden, this 29. of August 1592</dateline></opener>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<opener> <dateline>  <name type="place">
                              Great Marlborough Street</name>  <date>November 11, 1848</date> </dateline> <salute>My dear Sir,</salute></opener><p>I am sorry to say that absence from town and other circumstances have prevented me
                           from earlier enquiring...</p>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `orig`<span id="orig"/>
 
 
**orig** (original form) contains a reading which is marked as following the original, rather than being normalized or corrected. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-orig.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [author](#author)  [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
If all that is desired is to call attention to the original version in the copy text,  [orig](#orig)  may be used alone: 
```
 
<l>But this will be a <orig>meere</orig> confusion</l><l>And hardly shall we all be <orig>vnderstoode</orig></l>
 
```
 
 
 
 
 
 
#### **Example**
 
More usually, an  [orig](#orig)  will be combined with a regularized form within a  [choice](#choice)  element: 
```
 
<l>But this will be a <choice>  <orig>meere</orig>  <reg>mere</reg> </choice> confusion</l><l>And hardly shall we all be <choice>  <orig>vnderstoode</orig>  <reg>understood</reg> </choice></l>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `p`<span id="p"/>
 
 
**p** (paragraph) marks paragraphs in prose. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-p.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declaring](#att.declaring)  (`@decls`)  [att.fragmentable](#att.fragmentable)  (`@part`)  [att.written](#att.written)  (`@hand`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [item](#item)  [note](#note)  [q](#q)  [quote](#quote) 
 
**header:** [abstract](#abstract)  [availability](#availability)  [change](#change)  [editionStmt](#editionStmt)  [editorialDecl](#editorialDecl)  [encodingDesc](#encodingDesc)  [hyphenation](#hyphenation)  [langUsage](#langUsage)  [licence](#licence)  [prefixDef](#prefixDef)  [projectDesc](#projectDesc)  [publicationStmt](#publicationStmt)  [seriesStmt](#seriesStmt)  [sourceDesc](#sourceDesc) 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [epigraph](#epigraph)  [front](#front) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<p>Hallgerd was outside. <q>There is blood on your axe,</q> she said. <q>What have you   done?</q></p><p> <q>I have now arranged that you can be married a second time,</q> replied Thjostolf.</p><p> <q>Then you must mean that Thorvald is dead,</q> she said.</p><p> <q>Yes,</q> said Thjostolf. <q>And now you must think up some plan for me.</q></p>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `pb`<span id="pb"/>
 
 
**pb** (page beginning) marks the beginning of a new page in a paginated document. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-pb.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.edition](#att.edition)  (`@ed`, `@edRef`)  [att.spanning](#att.spanning)  (`@spanTo`)  [att.breaking](#att.breaking)  (`@break`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence) 
 
**textstructure:** [back](#back)  [body](#body)  [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [epigraph](#epigraph)  [front](#front)  [opener](#opener)  [text](#text)  [titlePage](#titlePage)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
Empty element
 
 
 
 
 
#### **Note**
 
A  [pb](#pb)  element should appear at the start of the page which it identifies. The global n attribute indicates the number or other value associated with this page. This will normally be the page number or signature printed on it, since the physical sequence number is implicit in the presence of the  [pb](#pb)  element itself. The type attribute may be used to characterize the page break in any respect. The more specialized attributes break, ed, or edRef should be preferred when the intent is to indicate whether or not the page break is word-breaking, or to note the source from which it derives. 
 
 
 
 
 
#### **Example**
 
Page numbers may vary in different editions of a text.
```
 
<p> ... <pb n="145" ed="ed2"/><!-- Page 145 in edition "ed2" starts here --> ... <pb n="283" ed="ed1"/><!-- Page 283 in edition "ed1" starts here--> ... </p>
 
```
 
 
 
 
 
 
#### **Example**
 
A page break may be associated with a facsimile image of the page it introduces by means of the facs attribute 
```
 
<body> <pb n="1" facs="page1.png"/><!-- page1.png contains an image of the page;
                              the text it contains is encoded here --> <p><!-- ... --> </p> <pb n="2" facs="page2.png"/><!-- similarly, for page 2 --> <p><!-- ... --> </p></body>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `pc`<span id="pc"/>
 
 
**pc** (punctuation character) contains a character or string of characters regarded as constituting a single punctuation mark. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-pc.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.segLike](#att.segLike)  (`@function`) ( [att.datcat](#att.datcat)  (`@datcat`, `@valueDatcat`)) ( [att.fragmentable](#att.fragmentable)  (`@part`))  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.linguistic](#att.linguistic)  (`@lemma`, `@lemmaRef`, `@pos`, `@msd`, `@join`) 
 
 
`@force` indicates the extent to which this punctuation mark conventionally separates words or phrases 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **strong** the punctuation mark is a word separator
     *    **weak** the punctuation mark is not a word separator
     *    **inter** the punctuation mark may or may not be a word separator
 
 
 
`@unit` provides a name for the kind of unit delimited by this punctuation mark. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
 
 
 
`@pre` indicates whether this punctuation mark precedes or follows the unit it delimits. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.truthValue
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [choice](#choice)  [corr](#corr)  [orig](#orig)  [reg](#reg)  [sic](#sic)  [unclear](#unclear) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<phr> <w>do</w> <w>you</w> <w>understand</w> <pc type="interrogative">
                              ?</pc></phr>
 
```
 
 
 
 
 
 
#### **Example**
 
Example encoding of the German sentence Wir fahren in den Urlaub., encoded with attributes from  [att.linguistic](#att.linguistic)  discussed in section [ID AILALW in TEI Guidelines]. 
```
 
<s> <w pos="PPER" msd="1.Pl.*.Nom">
                              Wir</w> <w pos="VVFIN" msd="1.Pl.Pres.Ind">
                              fahren</w> <w pos="APPR" msd="--">
                              in</w> <w pos="ART" msd="Def.Masc.Akk.Sg.">
                              den</w> <w pos="NN" msd="Masc.Akk.Sg.">
                              Urlaub</w> <pc pos="$." msd="--" join="left">
                              .</pc></s>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `prefixDef`<span id="prefixDef"/>
 
 
**prefixDef** (prefix definition) defines a prefixing scheme used in data.pointer values, showing how abbreviated URIs using the scheme may be expanded into full URIs. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-prefixDef.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.patternReplacement](#att.patternReplacement)  (`@matchPattern`, `@replacementPattern`) 
 
 
`@ident` supplies a name which functions as the prefix for an abbreviated pointing scheme such as a private URI scheme. The prefix constitutes the text preceding the first colon. 
 
 
*  **Status**: Required
*  **Datatype**: teidata.prefix
*  **Note**: The value is limited to teidata.prefix so that it may be mapped directly to a URI prefix. 
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [listPrefixDef](#listPrefixDef) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [p](#p) 
 
 
 
 
 
#### **Note**
 
The abbreviated pointer may be dereferenced to produce either an absolute or a relative URI reference. In the latter case it is combined with the value of xml:base in force at the place where the pointing attribute occurs to form an absolute URI in the usual manner as prescribed by  [XML Base](http://www.w3.org/TR/xmlbase/) . 
 
 
 
 
 
#### **Example**
 
 
```
 
<prefixDef ident="ref" matchPattern="([a-z]+)" replacementPattern="../../references/references.xml#$1">
                               <p> In the context of this project, private URIs with   the prefix "ref" point to <gi>div</gi> elements in   the project's global references.xml file. </p></prefixDef>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `profileDesc`<span id="profileDesc"/>
 
 
**profileDesc** (text-profile description) provides a detailed description of non-bibliographic aspects of a text, specifically the languages and sublanguages used, the situation in which it was produced, the participants and their setting. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-profileDesc.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [biblFull](#biblFull)  [teiHeader](#teiHeader) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [abstract](#abstract)  [creation](#creation)  [langUsage](#langUsage)  [textClass](#textClass) 
 
 
 
 
 
#### **Note**
 
Although the content model permits it, it is rarely meaningful to supply multiple occurrences for any of the child elements of  [profileDesc](#profileDesc)  unless these are documenting multiple texts. 
 
 
 
 
 
#### **Example**
 
 
```
 
<profileDesc> <langUsage>  <language ident="fr">
                              French</language> </langUsage> <textDesc n="novel">
                                <channel mode="w">
                              print; part issues</channel>  <constitution type="single"/>  <derivation type="original"/>  <domain type="art"/>  <factuality type="fiction"/>  <interaction type="none"/>  <preparedness type="prepared"/>  <purpose type="entertain" degree="high"/>  <purpose type="inform" degree="medium"/> </textDesc> <settingDesc>  <setting>   <name>Paris, France</name>   <time>Late 19th century</time>  </setting> </settingDesc></profileDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `projectDesc`<span id="projectDesc"/>
 
 
**projectDesc** (project description) describes in detail the aim or purpose for which an electronic file was encoded, together with any other relevant information concerning the process by which it was assembled or collected. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-projectDesc.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [encodingDesc](#encodingDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [p](#p) 
 
 
 
 
 
#### **Example**
 
 
```
 
<projectDesc> <p>Texts collected for use in the Claremont Shakespeare Clinic, June 1990</p></projectDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `publicationStmt`<span id="publicationStmt"/>
 
 
**publicationStmt** (publication statement) groups information concerning the publication or distribution of an electronic or other text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-publicationStmt.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [biblFull](#biblFull)  [fileDesc](#fileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [date](#date)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [ref](#ref) 
 
**header:** [authority](#authority)  [availability](#availability)  [distributor](#distributor)  [idno](#idno) 
 
 
 
 
 
#### **Note**
 
Where a publication statement contains several members of the model.publicationStmtPart.agency or model.publicationStmtPart.detail classes rather than one or more paragraphs or anonymous blocks, care should be taken to ensure that the repeated elements are presented in a meaningful order. It is a conformance requirement that elements supplying information about publication place, address, identifier, availability, and date be given following the name of the publisher, distributor, or authority concerned, and preferably in that order. 
 
 
 
 
 
#### **Example**
 
 
```
 
<publicationStmt> <publisher>C. Muquardt </publisher> <pubPlace>Bruxelles &amp; Leipzig</pubPlace> <date when="1846"/></publicationStmt>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<publicationStmt> <publisher>Chadwyck Healey</publisher> <pubPlace>Cambridge</pubPlace> <availability>  <p>Available under licence only</p> </availability> <date when="1992">
                              1992</date></publicationStmt>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<publicationStmt> <publisher>Zea Books</publisher> <pubPlace>Lincoln, NE</pubPlace> <date>2017</date> <availability>  <p>This is an open access work licensed under a Creative Commons Attribution 4.0 International
                           license.</p> </availability> <ptr target="http://digitalcommons.unl.edu/zeabook/55"/></publicationStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `publisher`<span id="publisher"/>
 
 
**publisher** provides the name of the organization responsible for the publication or distribution of a bibliographic item. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-publisher.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [publicationStmt](#publicationStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
Use the full form of the name by which a company is usually referred to, rather than any abbreviation of it which may appear on a title page 
 
 
 
 
 
#### **Example**
 
 
```
 
<imprint> <pubPlace>Oxford</pubPlace> <publisher>Clarendon Press</publisher> <date>1987</date></imprint>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `pubPlace`<span id="pubPlace"/>
 
 
**pubPlace** (publication place) contains the name of the place where a bibliographic item was published. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-pubPlace.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.naming](#att.naming)  (`@role`, `@nymRef`) ( [att.canonical](#att.canonical)  (`@key`, `@ref`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [publicationStmt](#publicationStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<publicationStmt> <publisher>Oxford University Press</publisher> <pubPlace>Oxford</pubPlace> <date>1989</date></publicationStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `q`<span id="q"/>
 
 
**q** (quoted) contains material which is distinguished from the surrounding text using quotation marks or a similar method, for any one of a variety of reasons including, but not limited to: direct speech or thought, technical terms or jargon, authorial distance, quotations from elsewhere, and passages that are mentioned but not used. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-q.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.ascribed.directed](#att.ascribed.directed)  (`@toWhom`) ( [att.ascribed](#att.ascribed)  (`@who`)) 
 
 
`@type` may be used to indicate whether the offset passage is spoken or thought, or to characterize it more finely. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Suggested values include:**: 
 
     *    **spoken** representation of speech
     *    **thought** representation of thought, e.g. internal monologue
     *    **written** quotation from a written source
     *    **soCalled** authorial distance
     *    **foreign** [No description available]
     *    **distinct** linguistically distinct
     *    **term** technical term
     *    **emph** rhetorically emphasized
     *    **mentioned** refering to itself, not its normal referent
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [corr](#corr)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [body](#body)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [epigraph](#epigraph)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
May be used to indicate that a passage is distinguished from the surrounding text for reasons concerning which no claim is made. When used in this manner,  [q](#q)  may be thought of as syntactic sugar for  [hi](#hi)  with a value of rend that indicates the use of such mechanisms as quotation marks. 
 
 
 
 
 
#### **Example**
 
 
```
 
It is spelled <q>Tübingen</q> — to enter the letter <q>u</q> with an umlaut hold down the <q>option</q> key and press <q>0 0 f c</q>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `quote`<span id="quote"/>
 
 
**quote** (quotation) contains a phrase or passage attributed by the narrator or author to some agency external to the text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-quote.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.notated](#att.notated)  (`@notation`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [corr](#corr)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [body](#body)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [epigraph](#epigraph)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
If a bibliographic citation is supplied for the source of a quotation, the two may be grouped using the `cit` element. 
 
 
 
 
 
#### **Example**
 
 
```
 
Lexicography has shown little sign of being affected by the work of followers of J.R. Firth, probably best summarized in his slogan, <quote>You shall know a word by the company it keeps</quote><ref>(Firth, 1957)</ref>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `ref`<span id="ref"/>
 
 
**ref** (reference) defines a reference to another location, possibly modified by additional text or comment. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-ref.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.pointing](#att.pointing)  (`@targetLang`, `@target`, `@evaluate`)  [att.internetMedia](#att.internetMedia)  (`@mimeType`)  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.declaring](#att.declaring)  (`@decls`)  [att.cReferencing](#att.cReferencing)  (`@cRef`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [publicationStmt](#publicationStmt)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The target and cRef attributes are mutually exclusive. 
 
 
 
 
 
#### **Example**
 
 
```
 
See especially <ref target="http://www.natcorp.ox.ac.uk/Texts/A02.xml#s2">
                              the second sentence</ref>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
See also <ref target="#locution">
                              s.v. <term>locution</term></ref>.
                        
 
```
 
 
 
 
 
 
 
 ----- 
 
### `reg`<span id="reg"/>
 
 
**reg** (regularization) contains a reading which has been regularized or normalized in some sense. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-reg.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.editLike](#att.editLike)  (`@evidence`, `@instant`)  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [author](#author)  [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
If all that is desired is to call attention to the fact that the copy text has been regularized,  [reg](#reg)  may be used alone: 
```
 
<q>Please <reg>knock</reg> if an <reg>answer</reg> is <reg>required</reg></q>
 
```
 
 
 
 
 
 
#### **Example**
 
It is also possible to identify the individual responsible for the regularization, and, using the  [choice](#choice)  and  [orig](#orig)  elements, to provide both the original and regularized readings: 
```
 
<q>Please <choice>  <reg resp="#LB">
                              knock</reg>  <orig>cnk</orig> </choice> if an <choice>  <reg>answer</reg>  <orig>nsr</orig> </choice> is <choice>  <reg>required</reg>  <orig>reqd</orig> </choice></q>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `relatedItem`<span id="relatedItem"/>
 
 
**relatedItem** contains or references some other bibliographic item which is related to the present one in some specified manner, for example as a constituent or alternative version of it. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-relatedItem.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
`@target` points to the related bibliographic element by means of an absolute or relative URI reference 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [notesStmt](#notesStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [bibl](#bibl)  [listBibl](#listBibl)  [ref](#ref) 
 
**header:** [biblFull](#biblFull) 
 
 
 
 
 
#### **Note**
 
If the target attribute is used to reference the related bibliographic item, the element must be empty. 
 
 
 
 
 
#### **Example**
 
 
```
 
<biblStruct> <monogr>  <author>Shirley, James</author>  <title type="main">
                              The gentlemen of Venice</title>  <imprint>   <pubPlace>New York</pubPlace>   <publisher>Readex Microprint</publisher>   <date>1953</date>  </imprint>  <extent>1 microprint card, 23 x 15 cm.</extent> </monogr> <series>  <title>Three centuries of drama: English, 1642–1700</title> </series> <relatedItem type="otherForm">
                                <biblStruct>   <monogr>    <author>Shirley, James</author>    <title type="main">
                              The gentlemen of Venice</title>    <title type="sub">
                              a tragi-comedie presented at the private house in Salisbury         Court by Her Majesties servants</title>    <imprint>     <pubPlace>London</pubPlace>     <publisher>H. Moseley</publisher>     <date>1655</date>    </imprint>    <extent>78 p.</extent>   </monogr>  </biblStruct> </relatedItem></biblStruct>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `rendition`<span id="rendition"/>
 
 
**rendition** supplies information about the rendition or appearance of one or more elements in the source text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-rendition.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.styleDef](#att.styleDef)  (`@scheme`, `@schemeVersion`) 
 
 
`@scope` where CSS is used, provides a way of defining ‘pseudo-elements’, that is, styling rules applicable to specific sub-portions of an element. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Sample values include:**: 
 
     *    **first-line** styling applies to the first line of the target element
     *    **first-letter** styling applies to the first letter of the target element
     *    **before** styling should be applied immediately before the content of the target element
     *    **after** styling should be applied immediately after the content of the target element
 
 
 
`@selector` contains a selector or series of selectors specifying the elements to which the contained style description applies, expressed in the language specified in the scheme attribute. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  
```
 
<rendition scheme="css" selector="text, front, back, body, div, p, ab">
                                                 display: block;</rendition>
 
```
 [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-rendition.html) ] : 
*  
```
 
<rendition scheme="css" selector="*[rend*=italic]">
                                                 font-style: italic;</rendition>
 
```
 [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-rendition.html) ] : 
*  **Note**: Since the default value of the scheme attribute is assumed to be CSS, the default expectation for this attribute, in the absence of scheme, is that CSS selector syntax will be used. 
*  **Note**: While rendition is used to point from an element in the transcribed source to a  [rendition](#rendition)  element in the header which describes how it appears, the selector attribute allows the encoder to point in the other direction: from a  [rendition](#rendition)  in the header to a collection of elements which all share the same renditional features. In both cases, the intention is to record the appearance of the source text, not to prescribe any particular output rendering. 
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
—
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [bibl](#bibl)  [choice](#choice)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [hi](#hi)  [list](#list)  [listBibl](#listBibl)  [name](#name)  [num](#num)  [q](#q)  [quote](#quote)  [ref](#ref)  [term](#term)  [title](#title) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<tagsDecl> <rendition xml:id="r-center" scheme="css">
                              text-align: center;</rendition> <rendition xml:id="r-small" scheme="css">
                              font-size: small;</rendition> <rendition xml:id="r-large" scheme="css">
                              font-size: large;</rendition> <rendition xml:id="initcaps"  scope="first-letter" scheme="css">
                              font-size: xx-large</rendition></tagsDecl>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `resp`<span id="resp"/>
 
 
**resp** (responsibility) contains a phrase describing the nature of a person's intellectual responsibility, or an organization's role in the production or distribution of a work. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-resp.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`)  [att.datable](#att.datable)  (`@calendar`, `@period`) ( [att.datable.w3c](#att.datable.w3c)  (`@when`, `@notBefore`, `@notAfter`, `@from`, `@to`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [respStmt](#respStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [choice](#choice)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [pb](#pb)  [ref](#ref)  [term](#term)  [title](#title) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) character data
 
 
 
 
 
#### **Note**
 
The attribute ref, inherited from the class  [att.canonical](#att.canonical)  may be used to indicate the kind of responsibility in a normalized form by referring directly to a standardized list of responsibility types, such as that maintained by a naming authority, for example the list maintained at  [http://www.loc.gov/marc/relators/relacode.html](http://www.loc.gov/marc/relators/relacode.html)  for bibliographic usage. 
 
 
 
 
 
#### **Example**
 
 
```
 
<respStmt> <resp ref="http://id.loc.gov/vocabulary/relators/com.html">
                              compiler</resp> <name>Edward Child</name></respStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `respStmt`<span id="respStmt"/>
 
 
**respStmt** (statement of responsibility) supplies a statement of responsibility for the intellectual content of a text, edition, recording, or series, where the specialized elements for authors, editors, etc. do not suffice or do not apply. May also be used to encode information about individuals or organizations which have played a role in the production or distribution of a bibliographic work. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-respStmt.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [bibl](#bibl) 
 
**header:** [editionStmt](#editionStmt)  [seriesStmt](#seriesStmt)  [titleStmt](#titleStmt) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [name](#name)  [note](#note)  [resp](#resp) 
 
 
 
 
 
#### **Example**
 
 
```
 
<respStmt> <resp>transcribed from original ms</resp> <persName>Claus Huitfeldt</persName></respStmt>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<respStmt> <resp>converted to XML encoding</resp> <name>Alan Morrison</name></respStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `revisionDesc`<span id="revisionDesc"/>
 
 
**revisionDesc** (revision description) summarizes the revision history for a file. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-revisionDesc.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.docStatus](#att.docStatus)  (`@status`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [teiHeader](#teiHeader) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [list](#list) 
 
**header:** [change](#change)  [listChange](#listChange) 
 
 
 
 
 
#### **Note**
 
If present on this element, the status attribute should indicate the current status of the document. The same attribute may appear on any  [change](#change)  to record the status at the time of that change. Conventionally  [change](#change)  elements should be given in reverse date order, with the most recent change at the start of the list. 
 
 
 
 
 
#### **Example**
 
 
```
 
<revisionDesc status="embargoed">
                               <change when="1991-11-11" who="#LB">
                               deleted chapter 10 </change></revisionDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `seriesStmt`<span id="seriesStmt"/>
 
 
**seriesStmt** (series statement) groups information about the series, if any, to which a publication belongs. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-seriesStmt.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [biblFull](#biblFull)  [fileDesc](#fileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [editor](#editor)  [p](#p)  [respStmt](#respStmt)  [title](#title) 
 
**header:** [idno](#idno) 
 
 
 
 
 
#### **Example**
 
 
```
 
<seriesStmt> <title>Machine-Readable Texts for the Study of Indian Literature</title> <respStmt>  <resp>ed. by</resp>  <name>Jan Gonda</name> </respStmt> <biblScope unit="volume">
                              1.2</biblScope> <idno type="ISSN">
                              0 345 6789</idno></seriesStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `sic`<span id="sic"/>
 
 
**sic** (Latin for thus or so) contains text reproduced although apparently incorrect or inaccurate. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-sic.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [author](#author)  [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
for his nose was as sharp as a pen, and <sic>a Table</sic> of green fields.
                        
 
```
 
 
 
 
 
 
#### **Example**
 
If all that is desired is to call attention to the apparent problem in the copy text,  [sic](#sic)  may be used alone: 
```
 
I don't know, Juan. It's so far in the past now — how <sic>we can</sic> prove or disprove anyone's theories?
                        
 
```
 
 
 
 
 
 
#### **Example**
 
It is also possible, using the  [choice](#choice)  and  [corr](#corr)  elements, to provide a corrected reading: 
```
 
I don't know, Juan. It's so far in the past now — how <choice> <sic>we can</sic> <corr>can we</corr></choice> prove or disprove anyone's theories?
                        
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
for his nose was as sharp as a pen, and <choice> <sic>a Table</sic> <corr>a' babbld</corr></choice> of green fields.
                        
 
```
 
 
 
 
 
 
 
 ----- 
 
### `sourceDesc`<span id="sourceDesc"/>
 
 
**sourceDesc** (source description) describes the source from which an electronic text was derived or generated, typically a bibliographic description in the case of a digitized text, or a phrase such as "born digital" for a text which has no previous existence. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-sourceDesc.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [biblFull](#biblFull)  [fileDesc](#fileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [bibl](#bibl)  [list](#list)  [listBibl](#listBibl)  [p](#p) 
 
**header:** [biblFull](#biblFull) 
 
 
 
 
 
#### **Example**
 
 
```
 
<sourceDesc> <bibl>  <title level="a">
                              The Interesting story of the Children in the Wood</title>. In <author>Victor E Neuberg</author>, <title>The Penny Histories</title>. <publisher>OUP</publisher>  <date>1968</date>. </bibl></sourceDesc>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<sourceDesc> <p>Born digital: no previous source exists.</p></sourceDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `supplied`<span id="supplied"/>
 
 
**supplied** signifies text supplied by the transcriber or editor for any reason; for example because the original cannot be read due to physical damage, or because of an obvious omission by the author or scribe. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-supplied.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.editLike](#att.editLike)  (`@evidence`, `@instant`)  [att.dimensions](#att.dimensions)  (`@unit`, `@quantity`, `@extent`, `@precision`, `@scope`) ( [att.ranging](#att.ranging)  (`@atLeast`, `@atMost`, `@min`, `@max`, `@confidence`)) 
 
 
`@reason` one or more words indicating why the text has had to be supplied, e.g. overbinding, faded-ink, lost-folio, omitted-in-original. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.word separated by whitespace
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [author](#author)  [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The `damage`,  [gap](#gap) , `del`,  [unclear](#unclear)  and  [supplied](#supplied)  elements may be closely allied in use. See section  [11.3.3.2. Use of the gap, del, damage, unclear, and supplied Elements in Combination](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/PH.html#PHCOMB)  for discussion of which element is appropriate for which circumstance. 
 
 
 
 
 
#### **Example**
 
 
```
 
I am dr Sr yr<supplied reason="illegible" source="#amanuensis_copy">
                              very humble Servt</supplied> Sydney Smith
                        
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<supplied reason="omitted-in-original">
                              Dedication</supplied> to the duke of Bejar
                        
 
```
 
 
 
 
 
 
 
 ----- 
 
### `TEI`<span id="TEI"/>
 
 
**TEI** (TEI document) contains a single TEI-conformant document, combining a single TEI header with one or more members of the model.resourceLike class. Multiple  [TEI](#TEI)  elements may be combined to form a `teiCorpus` element. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-TEI.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
`@version` specifies the version number of the TEI Guidelines against which this document is valid. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.version
*  **Note**: Major editions of the Guidelines have long been informally referred to by a name made up of the letter P (for Proposal) followed by a digit. The current release is one of the many releases of the fifth major edition of the Guidelines, known as P5. This attribute may be used to associate a TEI document with a specific release of the P5 Guidelines, in the absence of a more precise association provided by the source attribute on the associated `schemaSpec`. 
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
—
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [teiHeader](#teiHeader) 
 
**textstructure:** [text](#text) 
 
 
 
 
 
#### **Note**
 
This element is required. It is customary to specify the TEI namespace `http://www.tei-c.org/ns/1.0` on it, using the xmlns attribute. 
 
 
 
 
 
#### **Example**
 
 
```
 
<TEI version="3.3.0" xmlns="http://www.tei-c.org/ns/1.0"> <teiHeader>  <fileDesc>   <titleStmt>    <title>The shortest TEI Document Imaginable</title>   </titleStmt>   <publicationStmt>    <p>First published as part of TEI P2, this is the P5         version using a name space.</p>   </publicationStmt>   <sourceDesc>    <p>No source: this is an original work.</p>   </sourceDesc>  </fileDesc> </teiHeader> <text>  <body>   <p>This is about the shortest TEI document imaginable.</p>  </body> </text></TEI>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<TEI version="2.9.1" xmlns="http://www.tei-c.org/ns/1.0"> <teiHeader>  <fileDesc>   <titleStmt>    <title>A TEI Document containing four page images </title>   </titleStmt>   <publicationStmt>    <p>Unpublished demonstration file.</p>   </publicationStmt>   <sourceDesc>    <p>No source: this is an original work.</p>   </sourceDesc>  </fileDesc> </teiHeader> <facsimile>  <graphic url="page1.png"/>  <graphic url="page2.png"/>  <graphic url="page3.png"/>  <graphic url="page4.png"/> </facsimile></TEI>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `teiHeader`<span id="teiHeader"/>
 
 
**teiHeader** (TEI header) supplies descriptive and declarative metadata associated with a digital resource or set of resources. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-teiHeader.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [TEI](#TEI) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [encodingDesc](#encodingDesc)  [fileDesc](#fileDesc)  [profileDesc](#profileDesc)  [revisionDesc](#revisionDesc) 
 
 
 
 
 
#### **Note**
 
One of the few elements unconditionally required in any TEI document.
 
 
 
 
 
#### **Example**
 
 
```
 
<teiHeader> <fileDesc>  <titleStmt>   <title>Shakespeare: the first folio (1623) in electronic form</title>   <author>Shakespeare, William (1564–1616)</author>   <respStmt>    <resp>Originally prepared by</resp>    <name>Trevor Howard-Hill</name>   </respStmt>   <respStmt>    <resp>Revised and edited by</resp>    <name>Christine Avern-Carr</name>   </respStmt>  </titleStmt>  <publicationStmt>   <distributor>Oxford Text Archive</distributor>   <address>    <addrLine>13 Banbury Road, Oxford OX2 6NN, UK</addrLine>   </address>   <idno type="OTA">
                              119</idno>   <availability>    <p>Freely available on a non-commercial basis.</p>   </availability>   <date when="1968">
                              1968</date>  </publicationStmt>  <sourceDesc>   <bibl>The first folio of Shakespeare, prepared by Charlton Hinman (The Norton Facsimile,       1968)</bibl>  </sourceDesc> </fileDesc> <encodingDesc>  <projectDesc>   <p>Originally prepared for use in the production of a series of old-spelling       concordances in 1968, this text was extensively checked and revised for use
                           during the       editing of the new Oxford Shakespeare (Wells and Taylor, 1989).</p>  </projectDesc>  <editorialDecl>   <correction>    <p>Turned letters are silently corrected.</p>   </correction>   <normalization>    <p>Original spelling and typography is retained, except that long s and ligatured         forms are not encoded.</p>   </normalization>  </editorialDecl>  <refsDecl xml:id="ASLREF">
                                 <cRefPattern matchPattern="(\S+) ([^.]+)\.(.*)"    replacementPattern="#xpath(//div1[@n='$1']/div2/[@n='$2']//lb[@n='$3'])">
                                  <p>A reference is created by assembling the following, in the reverse order as that         listed here: <list>      <item>the <att>n</att> value of the preceding <gi>lb</gi>      </item>      <item>a period</item>      <item>the <att>n</att> value of the ancestor <gi>div2</gi>      </item>      <item>a space</item>      <item>the <att>n</att> value of the parent <gi>div1</gi>      </item>     </list>    </p>   </cRefPattern>  </refsDecl> </encodingDesc> <revisionDesc>  <list>   <item>    <date when="1989-04-12">
                              12 Apr 89</date> Last checked by CAC</item>   <item>    <date when="1989-03-01">
                              1 Mar 89</date> LB made new file</item>  </list> </revisionDesc></teiHeader>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `term`<span id="term"/>
 
 
**term** contains a single-word, multi-word, or symbolic designation which is regarded as a technical term. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-term.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declaring](#att.declaring)  (`@decls`)  [att.pointing](#att.pointing)  (`@targetLang`, `@target`, `@evaluate`)  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.canonical](#att.canonical)  (`@key`, `@ref`)  [att.sortable](#att.sortable)  (`@sortKey`)  [att.cReferencing](#att.cReferencing)  (`@cRef`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [keywords](#keywords)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [lb](#lb)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
When this element appears within an `index` element, it is understood to supply the form under which an index entry is to be made for that location. Elsewhere, it is understood simply to indicate that its content is to be regarded as a technical or specialised term. It may be associated with a `gloss` element by means of its ref attribute; alternatively a `gloss` element may point to a  [term](#term)  element by means of its target attribute. In formal terminological work, there is frequently discussion over whether terms must be atomic or may include multi-word lexical items, symbolic designations, or phraseological units. The  [term](#term)  element may be used to mark any of these. No position is taken on the philosophical issue of what a term can be; the looser definition simply allows the  [term](#term)  element to be used by practitioners of any persuasion. As with other members of the  [att.canonical](#att.canonical)  class, instances of this element occuring in a text may be associated with a canonical definition, either by means of a URI (using the ref attribute), or by means of some system-specific code value (using the key attribute). Because the mutually exclusive target and cRef attributes overlap with the function of the ref attribute, they are deprecated and may be removed at a subsequent release. 
 
 
 
 
 
#### **Example**
 
 
```
 
A computational device that infers structure from grammatical strings of words is known as a <term>parser</term>, and much of the history of NLP over the last 20 years has been occupied with the design of parsers.
                        
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
We may define <term xml:id="TDPV1" rend="sc">
                              discoursal point of view</term> as <gloss target="#TDPV1">
                              the relationship, expressed through discourse structure, between the implied author or some other addresser,
                           and the fiction.</gloss>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
We may define <term ref="#TDPV2" rend="sc">
                              discoursal point of view</term> as <gloss xml:id="TDPV2">
                              the relationship, expressed through discourse structure, between the implied author or some other addresser,
                           and the fiction.</gloss>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
We discuss Leech's concept of <term ref="myGlossary.xml#TDPV2" rend="sc">
                              discoursal point of view</term> below. 
                        
 
```
 
 
 
 
 
 
 
 ----- 
 
### `text`<span id="text"/>
 
 
**text** contains a single text of any kind, whether unitary or composite, for example a poem or drama, a collection of essays, a novel, a dictionary, or a corpus sample. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-text.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declaring](#att.declaring)  (`@decls`)  [att.typed](#att.typed)  (`@type`, `@subtype`)  [att.written](#att.written)  (`@hand`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [TEI](#TEI) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [gap](#gap)  [lb](#lb)  [milestone](#milestone)  [note](#note)  [pb](#pb) 
 
**textstructure:** [back](#back)  [body](#body)  [front](#front) 
 
 
 
 
 
#### **Note**
 
This element should not be used to represent a text which is inserted at an arbitrary point within the structure of another, for example as in an embedded or quoted narrative; the `floatingText` is provided for this purpose. 
 
 
 
 
 
#### **Example**
 
 
```
 
<text> <front>  <docTitle>   <titlePart>Autumn Haze</titlePart>  </docTitle> </front> <body>  <l>Is it a dragonfly or a maple leaf</l>  <l>That settles softly down upon the water?</l> </body></text>
 
```
 
 
 
 
 
 
#### **Example**
 
The body of a text may be replaced by a group of nested texts, as in the following schematic: 
```
 
<text> <front><!-- front matter for the whole group --> </front> <group>  <text><!-- first text -->  </text>  <text><!-- second text -->  </text> </group></text>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `textClass`<span id="textClass"/>
 
 
**textClass** (text classification) groups information which describes the nature or topic of a text in terms of a standard classification scheme, thesaurus, etc. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-textClass.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.declarable](#att.declarable)  (`@default`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [profileDesc](#profileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**header:** [catRef](#catRef)  [keywords](#keywords) 
 
 
 
 
 
#### **Example**
 
 
```
 
<taxonomy> <category xml:id="acprose">
                                <catDesc>Academic prose</catDesc> </category><!-- other categories here --></taxonomy><!-- ... --><textClass> <catRef target="#acprose"/> <classCode scheme="http://www.udcc.org">
                              001.9</classCode> <keywords scheme="http://authorities.loc.gov">
                                <list>   <item>End of the world</item>   <item>History - philosophy</item>  </list> </keywords></textClass>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `title`<span id="title"/>
 
 
**title** contains a title for any kind of work. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-title.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.canonical](#att.canonical)  (`@key`, `@ref`)  [att.datable](#att.datable)  (`@calendar`, `@period`) ( [att.datable.w3c](#att.datable.w3c)  (`@when`, `@notBefore`, `@notAfter`, `@from`, `@to`))  [att.typed](#att.typed)  (type, @subtype) 
 
 
`@type` classifies the title according to some convenient typology. 
 
 
*  **Derived from**:  [att.typed](#att.typed) 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Sample values include:**: 
 
     *    **main** main title
     *    **sub** (subordinate) subtitle, title of part
     *    **alt** (alternate) alternate title, often in another language, by which the work is also
                                                known
                                             
     *    **short** abbreviated form of title
     *    **desc** (descriptive) descriptive paraphrase of the work functioning as a title
*  **Note**: This attribute is provided for convenience in analysing titles and processing them according to their type; where such specialized processing is not necessary, there is no need for such analysis, and the entire title, including subtitles and any parallel titles, may be enclosed within a single  [title](#title)  element. 
 
 
 
`@level` indicates the bibliographic level for a title, that is, whether it identifies an article, book, journal, series, or unpublished material. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **a** (analytic) the title applies to an analytic item, such as an article, poem, or other
                                                work published as part of a larger item.
                                             
     *    **m** (monographic) the title applies to a monograph such as a book or other item considered
                                                to be a distinct publication, including single volumes of multi-volume works
                                             
     *    **j** (journal) the title applies to any serial or periodical publication such as a journal,
                                                magazine, or newspaper
                                             
     *    **s** (series) the title applies to a series of otherwise distinct publications such as
                                                a collection
                                             
     *    **u** (unpublished) the title applies to any unpublished material (including theses and
                                                dissertations unless published by a commercial press)
                                             
*  **Note**: The level of a title is sometimes implied by its context: for example, a title appearing directly within an `analytic` element is ipso facto of level ‘a’, and one appearing within a `series` element of level ‘s’. For this reason, the level attribute is not required in contexts where its value can be unambiguously inferred. Where it is supplied in such contexts, its value should not contradict the value implied by its parent element. 
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [bibl](#bibl)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition)  [seriesStmt](#seriesStmt)  [titleStmt](#titleStmt) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The attributes key and ref, inherited from the class  [att.canonical](#att.canonical)  may be used to indicate the canonical form for the title; the former, by supplying (for example) the identifier of a record in some external library system; the latter by pointing to an XML element somewhere containing the canonical form of the title. 
 
 
 
 
 
#### **Example**
 
 
```
 
<title>Information Technology and the Research Process: Proceedings of a conference held at Cranfield Institute of Technology, UK, 18–21 July 1989</title>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<title>Hardy's Tess of the D'Urbervilles: a machine readable edition</title>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<title type="full">
                               <title type="main">
                              Synthèse</title> <title type="sub">
                              an international journal for   epistemology, methodology and history of   science</title></title>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `titlePage`<span id="titlePage"/>
 
 
**titlePage** (title page) contains the title page of a text, appearing within the front or back matter. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-titlePage.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
`@type` classifies the title page according to any convenient typology. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Note**: This attribute allows the same element to be used for volume title pages, series title pages, etc., as well as for the ‘main’ title page of a work. 
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [back](#back)  [front](#front) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [gap](#gap)  [lb](#lb)  [milestone](#milestone)  [note](#note)  [pb](#pb) 
 
**textstructure:** [byline](#byline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [epigraph](#epigraph)  [titlePart](#titlePart) 
 
 
 
 
 
#### **Example**
 
 
```
 
<titlePage> <docTitle>  <titlePart type="main">
                              THOMAS OF Reading.</titlePart>  <titlePart type="alt">
                              OR, The sixe worthy yeomen of the West.</titlePart> </docTitle> <docEdition>Now the fourth time corrected and enlarged</docEdition> <byline>By T.D.</byline> <figure>  <head>TP</head>  <p>Thou shalt labor till thou returne to duste</p>  <figDesc>Printers Ornament used by TP</figDesc> </figure> <docImprint>Printed at <name type="place">
                              London</name> for <name>T.P.</name>  <date>1612.</date> </docImprint></titlePage>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `titlePart`<span id="titlePart"/>
 
 
**titlePart** contains a subsection or division of the title of a work, as indicated on a title page. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-titlePart.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
`@type` specifies the role of this subdivision of the title. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Suggested values include:**: 
 
     *    **main** main title of the work [Default] 
     *    **sub** (subordinate) subtitle of the work
     *    **alt** (alternate) alternative title of the work
     *    **short** abbreviated form of title
     *    **desc** (descriptive) descriptive paraphrase of the work
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**textstructure:** [back](#back)  [docTitle](#docTitle)  [front](#front)  [titlePage](#titlePage) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<docTitle> <titlePart type="main">
                              THE FORTUNES   AND MISFORTUNES Of the FAMOUS   Moll Flanders, &amp;c. </titlePart> <titlePart type="desc">
                              Who was BORN in NEWGATE,   And during a Life of continu'd Variety for   Threescore Years, besides her Childhood, was   Twelve Year a <hi>Whore</hi>, five times a <hi>Wife</hi> (wherof   once to her own Brother) Twelve Year a <hi>Thief,</hi>   Eight Year a Transported <hi>Felon</hi> in <hi>Virginia</hi>,   at last grew <hi>Rich</hi>, liv'd <hi>Honest</hi>, and died a <hi>Penitent</hi>.</titlePart></docTitle>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `titleStmt`<span id="titleStmt"/>
 
 
**titleStmt** (title statement) groups information about the title of a work and those responsible for its content. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-titleStmt.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**header:** [biblFull](#biblFull)  [fileDesc](#fileDesc) 
 
 
 
 
 
#### **May contain**
 
 
 
**core:** [author](#author)  [editor](#editor)  [respStmt](#respStmt)  [title](#title) 
 
 
 
 
 
#### **Example**
 
 
```
 
<titleStmt> <title>Capgrave's Life of St. John Norbert: a machine-readable transcription</title> <respStmt>  <resp>compiled by</resp>  <name>P.J. Lucas</name> </respStmt></titleStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `trailer`<span id="trailer"/>
 
 
**trailer** contains a closing title or footer appearing at the end of a division of a text. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-trailer.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.typed](#att.typed)  (`@type`, `@subtype`) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [lg](#lg)  [list](#list) 
 
**textstructure:** [back](#back)  [body](#body)  [div](#div)  [front](#front) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Example**
 
 
```
 
<trailer>Explicit pars tertia</trailer>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<trailer> <l>In stead of FINIS this advice <hi>I</hi> send,</l> <l>Let Rogues and Thieves beware of <lb/>  <hi>Hamans</hi> END.</l></trailer>
 
```
From EEBO A87070
 
 
 
 
 
 
 ----- 
 
### `unclear`<span id="unclear"/>
 
 
**unclear** contains a word, phrase, or passage which cannot be transcribed with certainty because it is illegible or inaudible in the source. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-unclear.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global) `@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`))  [att.editLike](#att.editLike)  (`@evidence`, `@instant`)  [att.dimensions](#att.dimensions)  (`@unit`, `@quantity`, `@extent`, `@precision`, `@scope`) ( [att.ranging](#att.ranging)  (`@atLeast`, `@atMost`, `@min`, `@max`, `@confidence`)) 
 
 
`@reason` indicates why the material is hard to transcribe. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.enumerated separated by whitespace
*  **Suggested values include:**: 
 
     *    **illegible** [No description available]
     *    **inaudible** [No description available]
     *    **faded** [No description available]
     *    **background_noise** [No description available]
     *    **eccentric_ductus** [No description available]
*  
```
 
<div> <head>Rx</head> <p>500 mg <unclear reason="illegible">
                                                placebo</unclear> </p></div>
 
```
 [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-unclear.html) ] : 
*  **Note**: One or more words may be used to describe the reason; usually each word will refer to a single cause. 
 
 
 
`@agent` Where the difficulty in transcription arises from damage, categorizes the cause of the damage, if it can be identified. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Sample values include:**: 
 
     *    **rubbing** damage results from rubbing of the leaf edges
     *    **mildew** damage results from mildew on the leaf surface
     *    **smoke** damage results from smoke
 
 
 
 
 
 
 
 
 
 
#### **Contained by**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [author](#author)  [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [change](#change)  [distributor](#distributor)  [edition](#edition)  [licence](#licence) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
 
 
**analysis:** [pc](#pc) 
 
**core:** [bibl](#bibl)  [choice](#choice)  [corr](#corr)  [date](#date)  [emph](#emph)  [foreign](#foreign)  [gap](#gap)  [hi](#hi)  [l](#l)  [lb](#lb)  [lg](#lg)  [list](#list)  [listBibl](#listBibl)  [milestone](#milestone)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [pb](#pb)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [biblFull](#biblFull)  [idno](#idno) 
 
**tagdocs:** [att](#att)  [code](#code)  [gi](#gi)  [val](#val) 
 
**transcr:** [supplied](#supplied) character data
 
 
 
 
 
#### **Note**
 
The same element is used for all cases of uncertainty in the transcription of element content, whether for written or spoken material. For other aspects of certainty, uncertainty, and reliability of tagging and transcription, see chapter  [21. Certainty, Precision, and Responsibility](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/CE.html#CE) . The `damage`,  [gap](#gap) , `del`,  [unclear](#unclear)  and  [supplied](#supplied)  elements may be closely allied in use. See section  [11.3.3.2. Use of the gap, del, damage, unclear, and supplied Elements in Combination](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/PH.html#PHCOMB)  for discussion of which element is appropriate for which circumstance. The hand attribute points to a definition of the hand concerned, as further discussed in section  [11.3.2.1. Document Hands](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/PH.html#PHDH) . 
 
 
 
 
 
#### **Example**
 
 
```
 
<u> ...and then <unclear reason="background-noise">
                              Nathalie</unclear> said ... </u>
 
```
 
 
 
 
 
 
 
 ----- 
 
### `val`<span id="val"/>
 
 
**val** (value) contains a single attribute value. [ [TEI Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-val.html) ] 
 
 
#### **Attributes**
 
Attributes  [att.global](#att.global)  (`@xml:id`, `@n`, `@xml:lang`, `@xml:base`, `@xml:space`) ( [att.global.rendition](#att.global.rendition)  (`@rend`, `@style`, `@rendition`)) ( [att.global.analytic](#att.global.analytic)  (`@ana`)) ( [att.global.facs](#att.global.facs)  (`@facs`)) ( [att.global.change](#att.global.change)  (`@change`)) ( [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)) ( [att.global.source](#att.global.source)  (`@source`)) 
 
 
 
 
 
#### **Contained by**
 
 
 
**core:** [author](#author)  [corr](#corr)  [date](#date)  [editor](#editor)  [emph](#emph)  [foreign](#foreign)  [head](#head)  [hi](#hi)  [item](#item)  [l](#l)  [name](#name)  [note](#note)  [num](#num)  [orig](#orig)  [p](#p)  [pubPlace](#pubPlace)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [resp](#resp)  [sic](#sic)  [term](#term)  [title](#title)  [unclear](#unclear) 
 
**header:** [authority](#authority)  [change](#change)  [creation](#creation)  [distributor](#distributor)  [edition](#edition)  [language](#language)  [licence](#licence)  [rendition](#rendition) 
 
**textstructure:** [byline](#byline)  [closer](#closer)  [dateline](#dateline)  [docAuthor](#docAuthor)  [docDate](#docDate)  [opener](#opener)  [titlePart](#titlePart)  [trailer](#trailer) 
 
**transcr:** [supplied](#supplied) 
 
 
 
 
 
#### **May contain**
 
Character data only
 
 
 
 
 
#### **Example**
 
 
```
 
<val>unknown</val>
 
```
 
 
 
 
 
 
 
## Schema wea: Attribute classes
 
 ----- 
 
### att.ascribed<span id="att.ascribed"/>
 
 
**att.ascribed** provides attributes for elements representing speech or action that can be ascribed to a specific individual. 
 
 
#### **Members**
 
 [att.ascribed.directed](#att.ascribed.directed)  [ [q](#q) ]  [change](#change) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@who` indicates the person, or group of people, to whom the element content is ascribed. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  In the following example from Hamlet, speeches (`sp`) in the body of the play are linked to `castItem` elements in the `castList` using the who attribute. 
```
 
<castItem type="role">
                                                 <role xml:id="Barnardo">
                                                Bernardo</role></castItem><castItem type="role">
                                                 <role xml:id="Francisco">
                                                Francisco</role> <roleDesc>a soldier</roleDesc></castItem><!-- ... --><sp who="#Barnardo">
                                                 <speaker>Bernardo</speaker> <l n="1">
                                                Who's there?</l></sp><sp who="#Francisco">
                                                 <speaker>Francisco</speaker> <l n="2">
                                                Nay, answer me: stand, and unfold yourself.</l></sp>
 
```
: 
*  **Note**: For transcribed speech, this will typically identify a participant or participant group; in other contexts, it will point to any identified `person` element. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.ascribed.directed<span id="att.ascribed.directed"/>
 
 
**att.ascribed.directed** provides attributes for elements representing speech or action that can be directed at a group or individual. 
 
 
#### **Members**
 
 [q](#q) 
 
 
 
 
 
#### **Attributes**
 
Attributes  [att.ascribed](#att.ascribed) `@who`) 
 
 
`@toWhom` indicates the person, or group of people, to whom a speech act or action is directed. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  In the following example from Mary Pix's The False Friend, speeches (`sp`) in the body of the play are linked to `castItem` elements in the `castList` using the toWhom attribute, which is used to specify who the speech is directed to. Additionally, the `stage` includes toWhom to indicate the directionality of the action. 
```
 
<castItem type="role">
                                                 <role xml:id="emil">
                                                Emilius.</role></castItem><castItem type="role">
                                                 <role xml:id="lov">
                                                Lovisa</role></castItem><castItem type="role">
                                                 <role xml:id="serv">
                                                A servant</role></castItem><!-- ... --><sp who="#emil" toWhom="#lov">
                                                 <speaker>Emil.</speaker> <l n="1">
                                                My love!</l></sp><sp who="#lov" toWhom="#emil">
                                                 <speaker>Lov.</speaker> <l n="2">
                                                I have no Witness of my Noble Birth</l> <stage who="emil" toWhom="#serv">
                                                Pointing to her Woman.</stage> <l>But that poor helpless wretch——</l></sp>
 
```
: 
*  **Note**: To indicate the recipient of written correspondence, use the elements used in section  [2.4.6. Correspondence Description](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/HD.html#HD44CD) , rather than a toWhom attribute. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.breaking<span id="att.breaking"/>
 
 
**att.breaking** provides an attribute to indicate whether or not the element concerned is considered to mark the end of an orthographic token in the same way as whitespace. 
 
 
#### **Members**
 
 [lb](#lb)  [milestone](#milestone)  [pb](#pb) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@break` indicates whether or not the element bearing this attribute should be considered to mark the end of an orthographic token in the same way as whitespace. 
 
 
*  **Status**: Recommended
*  **Datatype**: teidata.enumerated
*  **Sample values include**: 
 
     *    **yes** the element bearing this attribute is considered to mark the end of any adjacent orthographic
                                                token irrespective of the presence of any adjacent whitespace
                                             
     *    **no** the element bearing this attribute is considered not to mark the end of any adjacent
                                                orthographic token irrespective of the presence of any adjacent whitespace
                                             
     *    **maybe** the encoding does not take any position on this issue.
*  In the following lines from the Dream of the Rood, linebreaks occur in the middle of the words lāðost and reord-berendum. 
```
 
<ab> ...eƿesa tome iu icƿæs ȝeƿorden ƿita heardoſt . leodum la<lb break="no"/> ðost ærþan ichim lifes ƿeȝ rihtne ȝerymde reord be<lb break="no"/> rendum hƿæt me þaȝeƿeorðode ƿuldres ealdor ofer...</ab>
 
```
: 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.canonical<span id="att.canonical"/>
 
 
**att.canonical** provides attributes which can be used to associate a representation such as a name or title with canonical information about the object being named or referenced. 
 
 
#### **Members**
 
 [att.naming](#att.naming)  [ [att.personal](#att.personal)  [ [name](#name) ]  [author](#author)  [editor](#editor)  [pubPlace](#pubPlace) ]  [authority](#authority)  [date](#date)  [distributor](#distributor)  [docAuthor](#docAuthor)  [docTitle](#docTitle)  [publisher](#publisher)  [resp](#resp)  [respStmt](#respStmt)  [term](#term)  [title](#title) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@key` provides an externally-defined means of identifying the entity (or entities) being named, using a coded value of some kind. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  
```
 
<author> <name key="name 427308"  type="organisation">
                                                [New Zealand Parliament, Legislative Council]</name></author>
 
```
: 
*  
```
 
<author> <name key="Hugo, Victor (1802-1885)"  ref="http://www.idref.fr/026927608">
                                                Victor Hugo</name></author>
 
```
: 
*  **Note**: The value may be a unique identifier from a database, or any other externally-defined string identifying the referent. No particular syntax is proposed for the values of the key attribute, since its form will depend entirely on practice within a given project. For the same reason, this attribute is not recommended in data interchange, since there is no way of ensuring that the values used by one project are distinct from those used by another. In such a situation, a preferable approach for magic tokens which follows standard practice on the Web is to use a ref attribute whose value is a tag URI as defined in RFC 4151. 
 
 
 
`@ref` (reference) provides an explicit means of locating a full definition or identity for the entity being named by means of one or more URIs. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  
```
 
<name ref="http://viaf.org/viaf/109557338" type="person">
                                                Seamus Heaney</name>
 
```
: 
*  **Note**: The value must point directly to one or more XML elements or other resources by means of one or more URIs, separated by whitespace. If more than one is supplied the implication is that the name identifies several distinct entities. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.cReferencing<span id="att.cReferencing"/>
 
 
**att.cReferencing** provides an attribute which may be used to supply a canonical reference as a means of identifying the target of a pointer. 
 
 
#### **Members**
 
 [ref](#ref)  [term](#term) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@cRef` (canonical reference) specifies the destination of the pointer by supplying a canonical reference expressed using the scheme defined in a `refsDecl` element in the TEI header 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  **Note**: The value of cRef should be constructed so that when the algorithm for the resolution of canonical references (described in section  [16.2.5. Canonical References](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/SA.html#SACR) ) is applied to it the result is a valid URI reference to the intended target. The `refsDecl` to use may be indicated with the decls attribute. Currently these Guidelines only provide for a single canonical reference to be encoded on any given `ptr` element. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.datable<span id="att.datable"/>
 
 
**att.datable** provides attributes for normalization of elements that contain dates, times, or datable events. 
 
 
#### **Members**
 
 [change](#change)  [creation](#creation)  [date](#date)  [idno](#idno)  [licence](#licence)  [name](#name)  [resp](#resp)  [title](#title) 
 
 
 
 
 
#### **Attributes**
 
Attributes  [att.datable.w3c](#att.datable.w3c) `@when`, `@notBefore`, `@notAfter`, `@from`, `@to`) 
 
 
`@calendar` indicates the system or calendar to which the date represented by the content of this element belongs. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
*  
```
 
He was born on <date calendar="#gregorian">
                                                Feb. 22, 1732</date> (<date calendar="#julian" when="1732-02-22">
                                                 Feb. 11, 1731/32, O.S.</date>).
                                          
 
```
: 
*  **Note**: Note that the calendar attribute (unlike datingMethod defined in att.datable.custom) defines the calendar system of the date in the original material defined by the parent element, not the calendar to which the date is normalized. 
 
 
 
`@period` supplies a pointer to some location defining a named period of time within which the datable item is understood to have occurred. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
 
 
 
 
 
 
 
 
 
 
#### **Note**
 
This ‘superclass’ provides attributes that can be used to provide normalized values of temporal information. By default, the attributes from the  [att.datable.w3c](#att.datable.w3c)  class are provided. If the module for names &amp; dates is loaded, this class also provides attributes from the att.datable.iso and att.datable.custom classes. In general, the possible values of attributes restricted to the W3C datatypes form a subset of those values available via the ISO 8601 standard. However, the greater expressiveness of the ISO datatypes may not be needed, and there exists much greater software support for the W3C datatypes. 
 
 
 
 
 
 
 ----- 
 
### att.datable.w3c<span id="att.datable.w3c"/>
 
 
**att.datable.w3c** provides attributes for normalization of elements that contain datable events conforming to the W3C XML Schema Part 2: Datatypes Second Edition. 
 
 
#### **Members**
 
 [att.datable](#att.datable)  [ [change](#change)  [creation](#creation)  [date](#date)  [idno](#idno)  [licence](#licence)  [name](#name)  [resp](#resp)  [title](#title) ] 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@when` supplies the value of the date or time in a standard form, e.g. yyyy-mm-dd. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.temporal.w3c
*  Examples of W3C date, time, and date &amp; time formats.
```
 
<p> <date when="1945-10-24">
                                                24 Oct 45</date> <date when="1996-09-24T07:25:00Z">
                                                September 24th, 1996 at 3:25 in the morning</date> <time when="1999-01-04T20:42:00-05:00">
                                                Jan 4 1999 at 8 pm</time> <time when="14:12:38">
                                                fourteen twelve and 38 seconds</time> <date when="1962-10">
                                                October of 1962</date> <date when="--06-12">
                                                June 12th</date> <date when="---01">
                                                the first of the month</date> <date when="--08">
                                                August</date> <date when="2006">
                                                MMVI</date> <date when="0056">
                                                AD 56</date> <date when="-0056">
                                                56 BC</date></p>
 
```
: 
*  
```
 
This list begins in the year 1632, more precisely on Trinity Sunday, i.e. the Sunday after Pentecost, in that year the<date calendar="#julian" when="1632-06-06">
                                                27th of May (old style)</date>.
                                          
 
```
: 
*  
```
 
<opener> <dateline>  <placeName>Dorchester, Village,</placeName>  <date when="1828-03-02">
                                                March 2d. 1828.</date> </dateline> <salute>To   Mrs. Cornell,</salute> Sunday <time when="12:00:00">
                                                noon.</time></opener>
 
```
: 
 
 
 
`@notBefore` specifies the earliest possible date for the event in standard form, e.g. yyyy-mm-dd. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.temporal.w3c
 
 
 
`@notAfter` specifies the latest possible date for the event in standard form, e.g. yyyy-mm-dd. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.temporal.w3c
 
 
 
`@from` indicates the starting point of the period in standard form, e.g. yyyy-mm-dd. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.temporal.w3c
 
 
 
`@to` indicates the ending point of the period in standard form, e.g. yyyy-mm-dd. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.temporal.w3c
 
 
 
 
 
 
 
 
 
 
#### **Example**
 
 
```
 
<date from="1863-05-28" to="1863-06-01">
                              28 May through 1 June 1863</date>
 
```
 
 
 
 
 
 
#### **Note**
 
The value of these attributes should be a normalized representation of the date, time, or combined date &amp; time intended, in any of the standard formats specified by XML Schema Part 2: Datatypes Second Edition, using the Gregorian calendar. The most commonly-encountered format for the date portion of a temporal attribute is `yyyy-mm-dd`, but `yyyy`, `--mm`, `---dd`, `yyyy-mm`, or `--mm-dd` may also be used. For the time part, the form `hh:mm:ss` is used. Note that this format does not currently permit use of the value 0000 to represent the year 1 BCE; instead the value -0001 should be used. 
 
 
 
 
 
 
 ----- 
 
### att.datcat<span id="att.datcat"/>
 
 
**att.datcat** provides the dcr:datacat and dcr:ValueDatacat attributes which are used to align XML elements or attributes with the appropriate Data Categories (DCs) defined by the ISO 12620:2009 standard and stored in the Web repository called ISOCat at  [http://www.isocat.org/](http://www.isocat.org/) . 
 
 
#### **Members**
 
 [att.segLike](#att.segLike)  [ [pc](#pc) ] 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@datcat` contains a PID (persistent identifier) that aligns the given element with the appropriate Data Category (or categories) in ISOcat. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
 
 
 
`@valueDatcat` contains a PID (persistent identifier) that aligns the content of the given element or the value of the given attribute with the appropriate simple Data Category (or categories) in ISOcat. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
 
 
 
 
 
 
 
 
 
 
#### **Example**
 
In this example dcr:datcat relates the feature name to the data category "partOfSpeech" and dcr:valueDatcat the feature value to the data category "commonNoun". Both these data categories reside in the ISOcat DCR at  [www.isocat.org](http://www.isocat.org) , which is the DCR used by ISO TC37 and hosted by its registration authority, the MPI for Psycholinguistics in Nijmegen. 
```
 
<fs> <f name="POS"  dcr:datcat="http://www.isocat.org/datcat/DC-1345" fVal="#commonNoun"  dcr:valueDatcat="http://www.isocat.org/datcat/DC-1256"/></fs>
 
```
 
 
 
 
 
 
#### **Note**
 
ISO 12620:2009 is a standard describing the data model and procedures for a Data Category Registry (DCR). Data categories are defined as elementary descriptors in a linguistic structure. In the DCR data model each data category gets assigned a unique Peristent IDentifier (PID), i.e., an URI. Linguistic resources or preferably their schemas that make use of data categories from a DCR should refer to them using this PID. For XML-based resources, like TEI documents, ISO 12620:2009 normative Annex A gives a small Data Category Reference XML vocabulary (also available online at  [http://www.isocat.org/12620/](http://www.isocat.org/12620/) ), which provides two attributes, dcr:datcat and dcr:valueDatcat. 
 
 
 
 
 
 
 ----- 
 
### att.declarable<span id="att.declarable"/>
 
 
**att.declarable** provides attributes for those elements in the TEI header which may be independently selected by means of the special purpose decls attribute. 
 
 
#### **Members**
 
 [availability](#availability)  [bibl](#bibl)  [biblFull](#biblFull)  [editorialDecl](#editorialDecl)  [hyphenation](#hyphenation)  [langUsage](#langUsage)  [listBibl](#listBibl)  [projectDesc](#projectDesc)  [sourceDesc](#sourceDesc)  [textClass](#textClass) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@default` indicates whether or not this element is selected by default when its parent is selected. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.truthValue
*  **Legal values are:**: 
 
     *    **true** This element is selected if its parent is selected
     *    **false** This element can only be selected explicitly, unless it is the only one of its kind,
                                                in which case it is selected if its parent is selected. [Default] 
 
 
 
 
 
 
 
 
 
 
#### **Note**
 
The rules governing the association of declarable elements with individual parts of a TEI text are fully defined in chapter  [15.3. Associating Contextual Information with a Text](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/CC.html#CCAS) . Only one element of a particular type may have a default attribute with a value of true. 
 
 
 
 
 
 
 ----- 
 
### att.declaring<span id="att.declaring"/>
 
 
**att.declaring** provides attributes for elements which may be independently associated with a particular declarable element within the header, thus overriding the inherited default for that element. 
 
 
#### **Members**
 
 [back](#back)  [body](#body)  [div](#div)  [front](#front)  [lg](#lg)  [p](#p)  [ref](#ref)  [term](#term)  [text](#text) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@decls` identifies one or more declarable elements within the header, which are understood to apply to the element bearing this attribute and its content. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
 
 
 
 
 
 
 
 
 
 
#### **Note**
 
The rules governing the association of declarable elements with individual parts of a TEI text are fully defined in chapter  [15.3. Associating Contextual Information with a Text](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/CC.html#CCAS) . 
 
 
 
 
 
 
 ----- 
 
### att.dimensions<span id="att.dimensions"/>
 
 
**att.dimensions** provides attributes for describing the size of physical objects. 
 
 
#### **Members**
 
 [date](#date)  [gap](#gap)  [supplied](#supplied)  [unclear](#unclear) 
 
 
 
 
 
#### **Attributes**
 
Attributes  [att.ranging](#att.ranging) `@atLeast`, `@atMost`, `@min`, `@max`, `@confidence`) 
 
 
`@unit` names the unit used for the measurement 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Suggested values include:**: 
 
     *    **cm** (centimetres) 
     *    **mm** (millimetres) 
     *    **in** (inches) 
     *    **lines** lines of text
     *    **chars** (characters) characters of text
 
 
 
`@quantity` specifies the length in the units specified 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.numeric
 
 
 
`@extent` indicates the size of the object concerned using a project-specific vocabulary combining quantity and units in a single string of words. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  
```
 
<gap extent="5 words"/>
 
```
: 
*  
```
 
<height extent="half the page"/>
 
```
: 
 
 
 
`@precision` characterizes the precision of the values specified by the other attributes. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.certainty
 
 
 
`@scope` where the measurement summarizes more than one observation, specifies the applicability of this measurement. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Sample values include:**: 
 
     *    **all** measurement applies to all instances.
     *    **most** measurement applies to most of the instances inspected.
     *    **range** measurement applies to only the specified range of instances.
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.divLike<span id="att.divLike"/>
 
 
**att.divLike** provides attributes common to all elements which behave in the same way as divisions. 
 
 
#### **Members**
 
 [div](#div)  [lg](#lg) 
 
 
 
 
 
#### **Attributes**
 
Attributes  [att.fragmentable](#att.fragmentable) `@part`) 
 
 
`@org` (organization) specifies how the content of the division is organized. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **composite** no claim is made about the sequence in which the immediate contents of this division
                                                are to be processed, or their inter-relationships.
                                             
     *    **uniform** the immediate contents of this element are regarded as forming a logical unit, to
                                                be processed in sequence. [Default] 
 
 
 
`@sample` indicates whether this division is a sample of the original source and if so, from which part. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **initial** division lacks material present at end in source.
     *    **medial** division lacks material at start and end.
     *    **final** division lacks material at start.
     *    **unknown** position of sampled material within original unknown.
     *    **complete** division is not a sample. [Default] 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.docStatus<span id="att.docStatus"/>
 
 
**att.docStatus** provides attributes for use on metadata elements describing the status of a document. 
 
 
#### **Members**
 
 [bibl](#bibl)  [biblFull](#biblFull)  [change](#change)  [revisionDesc](#revisionDesc) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@status` describes the status of a document either currently or, when associated with a dated element, at the time indicated. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Sample values include:**: 
 
     *    **approved** [No description available]
     *    **candidate** [No description available]
     *    **cleared** [No description available]
     *    **deprecated** [No description available]
     *    **draft**  [Default] 
     *    **embargoed** [No description available]
     *    **expired** [No description available]
     *    **frozen** [No description available]
     *    **galley** [No description available]
     *    **proposed** [No description available]
     *    **published** [No description available]
     *    **recommendation** [No description available]
     *    **submitted** [No description available]
     *    **unfinished** [No description available]
     *    **withdrawn** [No description available]
 
 
 
 
 
 
 
 
 
 
#### **Example**
 
 
```
 
<revisionDesc status="published">
                               <change when="2010-10-21"  status="published"/> <change when="2010-10-02" status="cleared"/> <change when="2010-08-02"  status="embargoed"/> <change when="2010-05-01" status="frozen"  who="#MSM"/> <change when="2010-03-01" status="draft"  who="#LB"/></revisionDesc>
 
```
 
 
 
 
 
 
 
 ----- 
 
### att.edition<span id="att.edition"/>
 
 
**att.edition** provides attributes identifying the source edition from which some encoded feature derives. 
 
 
#### **Members**
 
 [lb](#lb)  [milestone](#milestone)  [pb](#pb) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@ed` (edition) supplies a sigil or other arbitrary identifier for the source edition in which the associated feature (for example, a page, column, or line break) occurs at this point in the text. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.word separated by whitespace
 
 
 
`@edRef` (edition reference) provides a pointer to the source edition in which the associated feature (for example, a page, column, or line break) occurs at this point in the text. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
 
 
 
 
 
 
 
 
 
 
#### **Example**
 
 
```
 
<l>Of Mans First Disobedience,<lb ed="1674"/> and<lb ed="1667"/> the Fruit</l><l>Of that Forbidden Tree, whose<lb ed="1667 1674"/> mortal tast</l><l>Brought Death into the World,<lb ed="1667"/> and all<lb ed="1674"/> our woe,</l>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<listBibl> <bibl xml:id="stapledon1937">
                                <author>Olaf Stapledon</author>, <title>Starmaker</title>, <publisher>Methuen</publisher>, <date>1937</date> </bibl> <bibl xml:id="stapledon1968">
                                <author>Olaf Stapledon</author>, <title>Starmaker</title>, <publisher>Dover</publisher>, <date>1968</date> </bibl></listBibl><!-- ... --><p>Looking into the future aeons from the supreme moment of the cosmos, I saw the populations still with all their strength maintaining the<pb n="411" edRef="#stapledon1968"/>essentials of their ancient culture, still living their personal lives in zest and endless novelty of action, … I saw myself still preserving, though with increasing difficulty, my lucid con-<pb n="291" edRef="#stapledon1937"/>sciousness;</p>
 
```
 
 
 
 
 
 
 
 ----- 
 
### att.editLike<span id="att.editLike"/>
 
 
**att.editLike** provides attributes describing the nature of an encoded scholarly intervention or interpretation of any kind. 
 
 
#### **Members**
 
 [corr](#corr)  [date](#date)  [gap](#gap)  [name](#name)  [reg](#reg)  [supplied](#supplied)  [unclear](#unclear) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@evidence` indicates the nature of the evidence supporting the reliability or accuracy of the intervention or interpretation. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.enumerated separated by whitespace
*  **Suggested values include:**: 
 
     *    **internal** there is internal evidence to support the intervention.
     *    **external** there is external evidence to support the intervention.
     *    **conjecture** the intervention or interpretation has been made by the editor, cataloguer, or scholar
                                                on the basis of their expertise.
                                             
 
 
 
`@instant` indicates whether this is an instant revision or not. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.xTruthValue
*  **Default**: false
 
 
 
 
 
 
 
 
 
 
#### **Note**
 
The members of this attribute class are typically used to represent any kind of editorial intervention in a text, for example a correction or interpretation, or to date or localize manuscripts etc. 
 
 
 
 
 
#### **Note**
 
Each pointer on the source (if present) corresponding to a witness or witness group should reference a bibliographic citation such as a `witness`, `msDesc`, or  [bibl](#bibl)  element, or another external bibliographic citation, documenting the source concerned. 
 
 
 
 
 
 
 ----- 
 
### att.fragmentable<span id="att.fragmentable"/>
 
 
**att.fragmentable** provides an attribute for representing fragmentation of a structural element, typically as a consequence of some overlapping hierarchy. 
 
 
#### **Members**
 
 [att.divLike](#att.divLike)  [ [div](#div)  [lg](#lg) ]  [att.segLike](#att.segLike)  [ [pc](#pc) ]  [l](#l)  [p](#p) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@part` specifies whether or not its parent element is fragmented in some way, typically by some other overlapping structure: for example a speech which is divided between two or more verse stanzas, a paragraph which is split across a page division, a verse line which is divided between two speakers. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **Y** (yes) the element is fragmented in some (unspecified) respect
     *    **N** (no) the element is not fragmented, or no claim is made as to its completeness [Default] 
     *    **I** (initial) this is the initial part of a fragmented element
     *    **M** (medial) this is a medial part of a fragmented element
     *    **F** (final) this is the final part of a fragmented element
*  **Note**: The values I, M, or F should be used only where it is clear how the element may be be reconstituted. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.global<span id="att.global"/>
 
 
**att.global** provides attributes common to all elements in the TEI encoding scheme. 
 
 
#### **Members**
 
 [TEI](#TEI)  [abstract](#abstract)  [att](#att)  [author](#author)  [authority](#authority)  [availability](#availability)  [back](#back)  [bibl](#bibl)  [biblFull](#biblFull)  [body](#body)  [byline](#byline)  [catRef](#catRef)  [category](#category)  [change](#change)  [choice](#choice)  [closer](#closer)  [code](#code)  [corr](#corr)  [creation](#creation)  [date](#date)  [dateline](#dateline)  [distributor](#distributor)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [edition](#edition)  [editionStmt](#editionStmt)  [editor](#editor)  [editorialDecl](#editorialDecl)  [emph](#emph)  [encodingDesc](#encodingDesc)  [epigraph](#epigraph)  [fileDesc](#fileDesc)  [foreign](#foreign)  [front](#front)  [gap](#gap)  [gi](#gi)  [head](#head)  [hi](#hi)  [hyphenation](#hyphenation)  [idno](#idno)  [item](#item)  [keywords](#keywords)  [l](#l)  [langUsage](#langUsage)  [language](#language)  [lb](#lb)  [lg](#lg)  [licence](#licence)  [list](#list)  [listBibl](#listBibl)  [listChange](#listChange)  [listPrefixDef](#listPrefixDef)  [milestone](#milestone)  [name](#name)  [note](#note)  [notesStmt](#notesStmt)  [num](#num)  [opener](#opener)  [orig](#orig)  [p](#p)  [pb](#pb)  [pc](#pc)  [prefixDef](#prefixDef)  [profileDesc](#profileDesc)  [projectDesc](#projectDesc)  [pubPlace](#pubPlace)  [publicationStmt](#publicationStmt)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [rendition](#rendition)  [resp](#resp)  [respStmt](#respStmt)  [revisionDesc](#revisionDesc)  [seriesStmt](#seriesStmt)  [sic](#sic)  [sourceDesc](#sourceDesc)  [supplied](#supplied)  [teiHeader](#teiHeader)  [term](#term)  [text](#text)  [textClass](#textClass)  [title](#title)  [titlePage](#titlePage)  [titlePart](#titlePart)  [titleStmt](#titleStmt)  [trailer](#trailer)  [unclear](#unclear)  [val](#val) 
 
 
 
 
 
#### **Attributes**
 
Attributes  [att.global.rendition](#att.global.rendition) `@rend`, `@style`, `@rendition`)  [att.global.analytic](#att.global.analytic)  (`@ana`)  [att.global.facs](#att.global.facs)  (`@facs`)  [att.global.change](#att.global.change)  (`@change`)  [att.global.responsibility](#att.global.responsibility)  (`@cert`, `@resp`)  [att.global.source](#att.global.source)  (`@source`) 
 
 
`@xml:id` (identifier) provides a unique identifier for the element bearing the attribute. 
 
 
*  **Status**: Optional
*  **Datatype**: ID
*  **Note**: The xml:id attribute may be used to specify a canonical reference for an element; see section  [3.10. Reference Systems](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/CO.html#CORS) . 
 
 
 
`@n` (number) gives a number (or other label) for an element, which is not necessarily unique within the document. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  **Note**: The value of this attribute is always understood to be a single token, even if it contains space or other punctuation characters, and need not be composed of numbers only. It is typically used to specify the numbering of chapters, sections, list items, etc.; it may also be used in the specification of a standard reference system for the text. 
 
 
 
`@xml:lang` (language) indicates the language of the element content using a ‘tag’ generated according to  [BCP 47](http://www.rfc-editor.org/rfc/bcp/bcp47.txt) . 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.language
*  
```
 
<p> … The consequences of this rapid depopulation were the loss of the last<foreign xml:lang="rap">
                                                ariki</foreign> or chief (Routledge 1920:205,210) and their connections to ancestral territorial organization.</p>
 
```
: 
*  **Note**: The xml:lang value will be inherited from the immediately enclosing element, or from its parent, and so on up the document hierarchy. It is generally good practice to specify xml:lang at the highest appropriate level, noticing that a different default may be needed for the teiHeader from that needed for the associated resource element or elements, and that a single TEI document may contain texts in many languages. The authoritative list of registered language subtags is maintained by IANA and is available at  [http://www.iana.org/assignments/language-subtag-registry](http://www.iana.org/assignments/language-subtag-registry) . For a good general overview of the construction of language tags, see  [http://www.w3.org/International/articles/language-tags/](http://www.w3.org/International/articles/language-tags/) , and for a practical step-by-step guide, see  [https://www.w3.org/International/questions/qa-choosing-language-tags.en.php](https://www.w3.org/International/questions/qa-choosing-language-tags.en.php) . The value used must conform with BCP 47. If the value is a private use code (i.e., starts with x- or contains -x-), a  [language](#language)  element with a matching value for its ident attribute should be supplied in the TEI header to document this value. Such documentation may also optionally be supplied for non-private-use codes, though these must remain consistent with their  (IETF)Internet Engineering Task Force definitions. 
 
 
 
`@xml:base` provides a base URI reference with which applications can resolve relative URI references into absolute URI references. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
*  
```
 
<div type="bibl">
                                                 <head>Bibliography</head> <listBibl xml:base="http://www.lib.ucdavis.edu/BWRP/Works/">
                                                  <bibl>   <author>    <name>Landon, Letitia Elizabeth</name>   </author>   <ref target="LandLVowOf.sgm">
                                                    <title>The Vow of the Peacock</title>   </ref>  </bibl>  <bibl>   <author>    <name>Compton, Margaret Clephane</name>   </author>   <ref target="NortMIrene.sgm">
                                                    <title>Irene, a Poem in Six Cantos</title>   </ref>  </bibl>  <bibl>   <author>    <name>Taylor, Jane</name>   </author>   <ref target="TaylJEssay.sgm">
                                                    <title>Essays in Rhyme on Morals and Manners</title>   </ref>  </bibl> </listBibl></div>
 
```
: 
 
 
 
`@xml:space` signals an intention about how white space should be managed by applications. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **default** signals that the application's default white-space processing modes are acceptable
     *    **preserve** indicates the intent that applications preserve all white space
*  **Note**: The  [XML specification](http://www.w3.org/TR/REC-xml/#sec-white-space)  provides further guidance on the use of this attribute. Note that many parsers may not handle xml:space correctly. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.global.analytic<span id="att.global.analytic"/>
 
 
**att.global.analytic** provides additional global attributes for associating specific analyses or interpretations with appropriate portions of a text. 
 
 
#### **Members**
 
 [att.global](#att.global)  [ [TEI](#TEI)  [abstract](#abstract)  [att](#att)  [author](#author)  [authority](#authority)  [availability](#availability)  [back](#back)  [bibl](#bibl)  [biblFull](#biblFull)  [body](#body)  [byline](#byline)  [catRef](#catRef)  [category](#category)  [change](#change)  [choice](#choice)  [closer](#closer)  [code](#code)  [corr](#corr)  [creation](#creation)  [date](#date)  [dateline](#dateline)  [distributor](#distributor)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [edition](#edition)  [editionStmt](#editionStmt)  [editor](#editor)  [editorialDecl](#editorialDecl)  [emph](#emph)  [encodingDesc](#encodingDesc)  [epigraph](#epigraph)  [fileDesc](#fileDesc)  [foreign](#foreign)  [front](#front)  [gap](#gap)  [gi](#gi)  [head](#head)  [hi](#hi)  [hyphenation](#hyphenation)  [idno](#idno)  [item](#item)  [keywords](#keywords)  [l](#l)  [langUsage](#langUsage)  [language](#language)  [lb](#lb)  [lg](#lg)  [licence](#licence)  [list](#list)  [listBibl](#listBibl)  [listChange](#listChange)  [listPrefixDef](#listPrefixDef)  [milestone](#milestone)  [name](#name)  [note](#note)  [notesStmt](#notesStmt)  [num](#num)  [opener](#opener)  [orig](#orig)  [p](#p)  [pb](#pb)  [pc](#pc)  [prefixDef](#prefixDef)  [profileDesc](#profileDesc)  [projectDesc](#projectDesc)  [pubPlace](#pubPlace)  [publicationStmt](#publicationStmt)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [rendition](#rendition)  [resp](#resp)  [respStmt](#respStmt)  [revisionDesc](#revisionDesc)  [seriesStmt](#seriesStmt)  [sic](#sic)  [sourceDesc](#sourceDesc)  [supplied](#supplied)  [teiHeader](#teiHeader)  [term](#term)  [text](#text)  [textClass](#textClass)  [title](#title)  [titlePage](#titlePage)  [titlePart](#titlePart)  [titleStmt](#titleStmt)  [trailer](#trailer)  [unclear](#unclear)  [val](#val) ] 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@ana` (analysis) indicates one or more elements containing interpretations of the element on which the ana attribute appears. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  **Note**: When multiple values are given, they may reflect either multiple divergent interpretations of an ambiguous text, or multiple mutually consistent interpretations of the same passage in different contexts. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.global.change<span id="att.global.change"/>
 
 
**att.global.change** supplies the change attribute, allowing its member elements to specify one or more states or revision campaigns with which they are associated. 
 
 
#### **Members**
 
 [att.global](#att.global)  [ [TEI](#TEI)  [abstract](#abstract)  [att](#att)  [author](#author)  [authority](#authority)  [availability](#availability)  [back](#back)  [bibl](#bibl)  [biblFull](#biblFull)  [body](#body)  [byline](#byline)  [catRef](#catRef)  [category](#category)  [change](#change)  [choice](#choice)  [closer](#closer)  [code](#code)  [corr](#corr)  [creation](#creation)  [date](#date)  [dateline](#dateline)  [distributor](#distributor)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [edition](#edition)  [editionStmt](#editionStmt)  [editor](#editor)  [editorialDecl](#editorialDecl)  [emph](#emph)  [encodingDesc](#encodingDesc)  [epigraph](#epigraph)  [fileDesc](#fileDesc)  [foreign](#foreign)  [front](#front)  [gap](#gap)  [gi](#gi)  [head](#head)  [hi](#hi)  [hyphenation](#hyphenation)  [idno](#idno)  [item](#item)  [keywords](#keywords)  [l](#l)  [langUsage](#langUsage)  [language](#language)  [lb](#lb)  [lg](#lg)  [licence](#licence)  [list](#list)  [listBibl](#listBibl)  [listChange](#listChange)  [listPrefixDef](#listPrefixDef)  [milestone](#milestone)  [name](#name)  [note](#note)  [notesStmt](#notesStmt)  [num](#num)  [opener](#opener)  [orig](#orig)  [p](#p)  [pb](#pb)  [pc](#pc)  [prefixDef](#prefixDef)  [profileDesc](#profileDesc)  [projectDesc](#projectDesc)  [pubPlace](#pubPlace)  [publicationStmt](#publicationStmt)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [rendition](#rendition)  [resp](#resp)  [respStmt](#respStmt)  [revisionDesc](#revisionDesc)  [seriesStmt](#seriesStmt)  [sic](#sic)  [sourceDesc](#sourceDesc)  [supplied](#supplied)  [teiHeader](#teiHeader)  [term](#term)  [text](#text)  [textClass](#textClass)  [title](#title)  [titlePage](#titlePage)  [titlePart](#titlePart)  [titleStmt](#titleStmt)  [trailer](#trailer)  [unclear](#unclear)  [val](#val) ] 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@change` points to one or more  [change](#change)  elements documenting a state or revision campaign to which the element bearing this attribute and its children have been assigned by the encoder. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.global.facs<span id="att.global.facs"/>
 
 
**att.global.facs** provides an attribute used to express correspondence between an element containing transcribed text and all or part of an image representing that text. 
 
 
#### **Members**
 
 [att.global](#att.global)  [ [TEI](#TEI)  [abstract](#abstract)  [att](#att)  [author](#author)  [authority](#authority)  [availability](#availability)  [back](#back)  [bibl](#bibl)  [biblFull](#biblFull)  [body](#body)  [byline](#byline)  [catRef](#catRef)  [category](#category)  [change](#change)  [choice](#choice)  [closer](#closer)  [code](#code)  [corr](#corr)  [creation](#creation)  [date](#date)  [dateline](#dateline)  [distributor](#distributor)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [edition](#edition)  [editionStmt](#editionStmt)  [editor](#editor)  [editorialDecl](#editorialDecl)  [emph](#emph)  [encodingDesc](#encodingDesc)  [epigraph](#epigraph)  [fileDesc](#fileDesc)  [foreign](#foreign)  [front](#front)  [gap](#gap)  [gi](#gi)  [head](#head)  [hi](#hi)  [hyphenation](#hyphenation)  [idno](#idno)  [item](#item)  [keywords](#keywords)  [l](#l)  [langUsage](#langUsage)  [language](#language)  [lb](#lb)  [lg](#lg)  [licence](#licence)  [list](#list)  [listBibl](#listBibl)  [listChange](#listChange)  [listPrefixDef](#listPrefixDef)  [milestone](#milestone)  [name](#name)  [note](#note)  [notesStmt](#notesStmt)  [num](#num)  [opener](#opener)  [orig](#orig)  [p](#p)  [pb](#pb)  [pc](#pc)  [prefixDef](#prefixDef)  [profileDesc](#profileDesc)  [projectDesc](#projectDesc)  [pubPlace](#pubPlace)  [publicationStmt](#publicationStmt)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [rendition](#rendition)  [resp](#resp)  [respStmt](#respStmt)  [revisionDesc](#revisionDesc)  [seriesStmt](#seriesStmt)  [sic](#sic)  [sourceDesc](#sourceDesc)  [supplied](#supplied)  [teiHeader](#teiHeader)  [term](#term)  [text](#text)  [textClass](#textClass)  [title](#title)  [titlePage](#titlePage)  [titlePart](#titlePart)  [titleStmt](#titleStmt)  [trailer](#trailer)  [unclear](#unclear)  [val](#val) ] 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@facs` (facsimile) points to all or part of an image which corresponds with the content of the element. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.global.rendition<span id="att.global.rendition"/>
 
 
**att.global.rendition** provides rendering attributes common to all elements in the TEI encoding scheme. 
 
 
#### **Members**
 
 [att.global](#att.global)  [ [TEI](#TEI)  [abstract](#abstract)  [att](#att)  [author](#author)  [authority](#authority)  [availability](#availability)  [back](#back)  [bibl](#bibl)  [biblFull](#biblFull)  [body](#body)  [byline](#byline)  [catRef](#catRef)  [category](#category)  [change](#change)  [choice](#choice)  [closer](#closer)  [code](#code)  [corr](#corr)  [creation](#creation)  [date](#date)  [dateline](#dateline)  [distributor](#distributor)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [edition](#edition)  [editionStmt](#editionStmt)  [editor](#editor)  [editorialDecl](#editorialDecl)  [emph](#emph)  [encodingDesc](#encodingDesc)  [epigraph](#epigraph)  [fileDesc](#fileDesc)  [foreign](#foreign)  [front](#front)  [gap](#gap)  [gi](#gi)  [head](#head)  [hi](#hi)  [hyphenation](#hyphenation)  [idno](#idno)  [item](#item)  [keywords](#keywords)  [l](#l)  [langUsage](#langUsage)  [language](#language)  [lb](#lb)  [lg](#lg)  [licence](#licence)  [list](#list)  [listBibl](#listBibl)  [listChange](#listChange)  [listPrefixDef](#listPrefixDef)  [milestone](#milestone)  [name](#name)  [note](#note)  [notesStmt](#notesStmt)  [num](#num)  [opener](#opener)  [orig](#orig)  [p](#p)  [pb](#pb)  [pc](#pc)  [prefixDef](#prefixDef)  [profileDesc](#profileDesc)  [projectDesc](#projectDesc)  [pubPlace](#pubPlace)  [publicationStmt](#publicationStmt)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [rendition](#rendition)  [resp](#resp)  [respStmt](#respStmt)  [revisionDesc](#revisionDesc)  [seriesStmt](#seriesStmt)  [sic](#sic)  [sourceDesc](#sourceDesc)  [supplied](#supplied)  [teiHeader](#teiHeader)  [term](#term)  [text](#text)  [textClass](#textClass)  [title](#title)  [titlePage](#titlePage)  [titlePart](#titlePart)  [titleStmt](#titleStmt)  [trailer](#trailer)  [unclear](#unclear)  [val](#val) ] 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@rend` (rendition) indicates how the element in question was rendered or presented in the source text. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.word separated by whitespace
*  
```
 
<head rend="align(center) case(allcaps)">
                                                 <lb/>To The <lb/>Duchesse <lb/>of <lb/>Newcastle,<lb/>On Her <lb/> <hi rend="case(mixed)">
                                                New Blazing-World</hi>. </head>
 
```
: 
*  **Note**: These Guidelines make no binding recommendations for the values of the rend attribute; the characteristics of visual presentation vary too much from text to text and the decision to record or ignore individual characteristics varies too much from project to project. Some potentially useful conventions are noted from time to time at appropriate points in the Guidelines. The values of the rend attribute are a set of sequence-indeterminate individual tokens separated by whitespace. 
 
 
 
`@style` contains an expression in some formal style definition language which defines the rendering or presentation used for this element in the source text 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  
```
 
<head style="text-align: center; font-variant: small-caps">
                                                 <lb/>To The <lb/>Duchesse <lb/>of <lb/>Newcastle, <lb/>On Her<lb/> <hi style="font-variant: normal">
                                                New Blazing-World</hi>. </head>
 
```
: 
*  **Note**: Unlike the attribute values of rend, which uses whitespace as a separator, the style attribute may contain whitespace. This attribute is intended for recording inline stylistic information concerning the source, not any particular output. The formal language in which values for this attribute are expressed may be specified using the `styleDefDecl` element in the TEI header. If style and rendition are both present on an element, then style overrides or complements rendition. style should not be used in conjunction with rend, because the latter does not employ a formal style definition language. 
 
 
 
`@rendition` points to a description of the rendering or presentation used for this element in the source text. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  
```
 
<head rendition="#ac #sc">
                                                 <lb/>To The <lb/>Duchesse <lb/>of <lb/>Newcastle, <lb/>On Her<lb/> <hi rendition="#normal">
                                                New Blazing-World</hi>. </head><!-- elsewhere... --><rendition xml:id="sc" scheme="css">
                                                font-variant: small-caps</rendition><rendition xml:id="normal" scheme="css">
                                                font-variant: normal</rendition><rendition xml:id="ac" scheme="css">
                                                text-align: center</rendition>
 
```
: 
*  **Note**: The rendition attribute is used in a very similar way to the class attribute defined for XHTML but with the important distinction that its function is to describe the appearance of the source text, not necessarily to determine how that text should be presented on screen or paper. If rendition is used to refer to a style definition in a formal language like CSS, it is recommended that it not be used in conjunction with rend. Where both rendition and rend are supplied, the latter is understood to override or complement the former. Each URI provided should indicate a  [rendition](#rendition)  element defining the intended rendition in terms of some appropriate style language, as indicated by the scheme attribute. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.global.responsibility<span id="att.global.responsibility"/>
 
 
**att.global.responsibility** provides attributes indicating the agent responsible for some aspect of the text, the markup or something asserted by the markup, and the degree of certainty associated with it. 
 
 
#### **Members**
 
 [att.global](#att.global)  [ [TEI](#TEI)  [abstract](#abstract)  [att](#att)  [author](#author)  [authority](#authority)  [availability](#availability)  [back](#back)  [bibl](#bibl)  [biblFull](#biblFull)  [body](#body)  [byline](#byline)  [catRef](#catRef)  [category](#category)  [change](#change)  [choice](#choice)  [closer](#closer)  [code](#code)  [corr](#corr)  [creation](#creation)  [date](#date)  [dateline](#dateline)  [distributor](#distributor)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [edition](#edition)  [editionStmt](#editionStmt)  [editor](#editor)  [editorialDecl](#editorialDecl)  [emph](#emph)  [encodingDesc](#encodingDesc)  [epigraph](#epigraph)  [fileDesc](#fileDesc)  [foreign](#foreign)  [front](#front)  [gap](#gap)  [gi](#gi)  [head](#head)  [hi](#hi)  [hyphenation](#hyphenation)  [idno](#idno)  [item](#item)  [keywords](#keywords)  [l](#l)  [langUsage](#langUsage)  [language](#language)  [lb](#lb)  [lg](#lg)  [licence](#licence)  [list](#list)  [listBibl](#listBibl)  [listChange](#listChange)  [listPrefixDef](#listPrefixDef)  [milestone](#milestone)  [name](#name)  [note](#note)  [notesStmt](#notesStmt)  [num](#num)  [opener](#opener)  [orig](#orig)  [p](#p)  [pb](#pb)  [pc](#pc)  [prefixDef](#prefixDef)  [profileDesc](#profileDesc)  [projectDesc](#projectDesc)  [pubPlace](#pubPlace)  [publicationStmt](#publicationStmt)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [rendition](#rendition)  [resp](#resp)  [respStmt](#respStmt)  [revisionDesc](#revisionDesc)  [seriesStmt](#seriesStmt)  [sic](#sic)  [sourceDesc](#sourceDesc)  [supplied](#supplied)  [teiHeader](#teiHeader)  [term](#term)  [text](#text)  [textClass](#textClass)  [title](#title)  [titlePage](#titlePage)  [titlePart](#titlePart)  [titleStmt](#titleStmt)  [trailer](#trailer)  [unclear](#unclear)  [val](#val) ] 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@cert` (certainty) signifies the degree of certainty associated with the intervention or interpretation. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.probCert
 
 
 
`@resp` (responsible party) indicates the agency responsible for the intervention or interpretation, for example an editor or transcriber. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  **Note**: To reduce the ambiguity of a resp pointing directly to a person or organization, we recommend that resp be used to point not to an agent (`person` or `org`) but to a  [respStmt](#respStmt) ,  [author](#author) ,  [editor](#editor)  or similar element which clarifies the exact role played by the agent. Pointing to multiple  [respStmt](#respStmt) s allows the encoder to specify clearly each of the roles played in part of a TEI file (creating, transcribing, encoding, editing, proofing etc.). 
 
 
 
 
 
 
 
 
 
 
#### **Example**
 
 
```
 
Blessed are the<choice> <sic>cheesemakers</sic> <corr resp="#editor" cert="high">
                              peacemakers</corr></choice>: for they shall be called the children of God.
                        
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<!-- in the <text> ... --><lg><!-- ... --> <l>Punkes, Panders, baſe extortionizing   sla<choice>   <sic>n</sic>   <corr resp="#JENS1_transcriber">
                              u</corr>  </choice>es,</l><!-- ... --></lg><!-- in the <teiHeader> ... --><!-- ... --><respStmt xml:id="JENS1_transcriber">
                               <resp when="2014">
                              Transcriber</resp> <name>Janelle Jenstad</name></respStmt>
 
```
 
 
 
 
 
 
 
 ----- 
 
### att.global.source<span id="att.global.source"/>
 
 
**att.global.source** provides an attribute used by elements to point to an external source. 
 
 
#### **Members**
 
 [att.global](#att.global)  [ [TEI](#TEI)  [abstract](#abstract)  [att](#att)  [author](#author)  [authority](#authority)  [availability](#availability)  [back](#back)  [bibl](#bibl)  [biblFull](#biblFull)  [body](#body)  [byline](#byline)  [catRef](#catRef)  [category](#category)  [change](#change)  [choice](#choice)  [closer](#closer)  [code](#code)  [corr](#corr)  [creation](#creation)  [date](#date)  [dateline](#dateline)  [distributor](#distributor)  [div](#div)  [docAuthor](#docAuthor)  [docDate](#docDate)  [docTitle](#docTitle)  [edition](#edition)  [editionStmt](#editionStmt)  [editor](#editor)  [editorialDecl](#editorialDecl)  [emph](#emph)  [encodingDesc](#encodingDesc)  [epigraph](#epigraph)  [fileDesc](#fileDesc)  [foreign](#foreign)  [front](#front)  [gap](#gap)  [gi](#gi)  [head](#head)  [hi](#hi)  [hyphenation](#hyphenation)  [idno](#idno)  [item](#item)  [keywords](#keywords)  [l](#l)  [langUsage](#langUsage)  [language](#language)  [lb](#lb)  [lg](#lg)  [licence](#licence)  [list](#list)  [listBibl](#listBibl)  [listChange](#listChange)  [listPrefixDef](#listPrefixDef)  [milestone](#milestone)  [name](#name)  [note](#note)  [notesStmt](#notesStmt)  [num](#num)  [opener](#opener)  [orig](#orig)  [p](#p)  [pb](#pb)  [pc](#pc)  [prefixDef](#prefixDef)  [profileDesc](#profileDesc)  [projectDesc](#projectDesc)  [pubPlace](#pubPlace)  [publicationStmt](#publicationStmt)  [publisher](#publisher)  [q](#q)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [rendition](#rendition)  [resp](#resp)  [respStmt](#respStmt)  [revisionDesc](#revisionDesc)  [seriesStmt](#seriesStmt)  [sic](#sic)  [sourceDesc](#sourceDesc)  [supplied](#supplied)  [teiHeader](#teiHeader)  [term](#term)  [text](#text)  [textClass](#textClass)  [title](#title)  [titlePage](#titlePage)  [titlePart](#titlePart)  [titleStmt](#titleStmt)  [trailer](#trailer)  [unclear](#unclear)  [val](#val) ] 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@source` specifies the source from which some aspect of this element is drawn. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  **Note**: The source attribute points to an external source. When used on elements describing schema components such as `schemaSpec` or `moduleRef` it identifies the source from which declarations for the components of the object being defined may be obtained. On other elements it provides a pointer to the bibliographical source from which a quotation or citation is drawn. In either case, the location may be provided using any form of URI, for example an absolute URI, a relative URI, or private scheme URI that is expanded to an absolute URI as documented in a  [prefixDef](#prefixDef) . If more than one location is specified, the default assumption is that the required source should be obtained by combining the resources indicated. 
 
 
 
 
 
 
 
 
 
 
#### **Example**
 
 
```
 
<p><!-- ... --> As Willard McCarty (<bibl xml:id="mcc_2012">
                              2012, p.2</bibl>) tells us, <quote source="#mcc_2012">
                              ‘Collaboration’ is a problematic and should be a contested   term.</quote><!-- ... --></p>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<p><!-- ... --> <quote source="#chicago_15_ed">
                              Grammatical theories are in flux, and the more we learn, the   less we seem to know.</quote><!-- ... --></p><!-- ... --><bibl xml:id="chicago_15_ed">
                               <title level="m">
                              The Chicago Manual of Style</title>,<edition>15th edition</edition>. <pubPlace>Chicago</pubPlace>: <publisher>University of   Chicago Press</publisher> (<date>2003</date>), <biblScope unit="page">
                              p.147</biblScope>.</bibl>
 
```
 
 
 
 
 
 
#### **Example**
 
 
```
 
<elementRef key="p" source="tei:2.0.1"/>
 
```
Include in the schema an element named  [p](#p)  available from the TEI P5 2.0.1 release. 
 
 
 
 
 
#### **Example**
 
 
```
 
<schemaSpec ident="myODD" source="mycompiledODD.xml">
                              <!-- further declarations specifying the components required --></schemaSpec>
 
```
Create a schema using components taken from the file mycompiledODD.xml. 
 
 
 
 
 
 
 ----- 
 
### att.internetMedia<span id="att.internetMedia"/>
 
 
**att.internetMedia** provides attributes for specifying the type of a computer resource using a standard taxonomy. 
 
 
#### **Members**
 
 [ref](#ref) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@mimeType` (MIME media type) specifies the applicable multimedia internet mail extension (MIME) media type 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.word separated by whitespace
 
 
 
 
 
 
 
 
 
 
#### **Example**
 
In this example mimeType is used to indicate that the URL points to a TEI XML file encoded in UTF-8. 
```
 
<ref mimeType="application/tei+xml; charset=UTF-8" target="http://sourceforge.net/p/tei/code/HEAD/tree/trunk/P5/Source/guidelines-en.xml"/>
 
```
 
 
 
 
 
 
#### **Note**
 
This attribute class provides an attribute for describing a computer resource, typically available over the internet, using a value taken from a standard taxonomy. At present only a single taxonomy is supported, the Multipurpose Internet Mail Extensions (MIME) Media Type system. This typology of media types is defined by the Internet Engineering Task Force in  [RFC 2046](http://www.ietf.org/rfc/rfc2046.txt) . The  [list of types](http://www.iana.org/assignments/media-types/)  is maintained by the Internet Assigned Numbers Authority (IANA). The mimeType attribute must have a value taken from this list. 
 
 
 
 
 
 
 ----- 
 
### att.linguistic<span id="att.linguistic"/>
 
 
**att.linguistic** provides a set of attributes concerning linguistic features of tokens, for usage within token-level elements, specifically `w` and  [pc](#pc)  in the analysis module. 
 
 
#### **Members**
 
 [pc](#pc) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@lemma` provides a lemma (base form) for the word, typically uninflected and serving both as an identifier (e.g. in dictionary contexts, as a headword), and as a basis for potential inflections. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  
```
 
<w lemma="wife">
                                                wives</w>
 
```
: 
*  
```
 
<w lemma="Arznei">
                                                Artzeneyen</w>
 
```
: 
 
 
 
`@lemmaRef` provides a pointer to a definition of the lemma for the word, for example in an online lexicon. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
*  
```
 
<w type="verb" lemma="hit" lemmaRef="http://www.example.com/lexicon/hitvb.xml">
                                                hitt<m type="suffix">
                                                ing</m></w>
 
```
: 
 
 
 
`@pos` (part of speech) indicates the part of speech assigned to a token (i.e. information on whether it is a noun, adjective, or verb), usually according to some official reference vocabulary (e.g. for German: STTS, for English: CLAWS, for Polish: NKJP, etc.). 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  The German sentence ‘Wir fahren in den Urlaub.’ tagged with the Stuttgart-Tuebingen-Tagset (STTS). 
```
 
<s> <w pos="PPER">
                                                Wir</w> <w pos="VVFIN">
                                                fahren</w> <w pos="APPR">
                                                in</w> <w pos="ART">
                                                den</w> <w pos="NN">
                                                Urlaub</w> <w pos="$.">
                                                .</w></s>
 
```
: 
*  The English sentence ‘We're going to Brazil.’ tagged with the  [CLAWS-5](http://ucrel.lancs.ac.uk/claws5tags.html)  tagset, arranged inline (with significant whitespace). 
```
 
<p><w pos="PNP">
                                                We</w><w pos="VBB">
                                                're</w> <w pos="VVG">
                                                going</w> <w pos="PRP">
                                                to</w> <w pos="NP0">
                                                Brazil</w><pc pos="PUN">
                                                .</pc></p>
                                                     
                                          
 
```
: 
*  The English sentence ‘We're going on vacation to Brazil for a month!’ tagged with the  [CLAWS-7](http://ucrel.lancs.ac.uk/claws7tags.html)  tagset and arranged sequentially. 
```
 
<p> <w pos="PPIS2">
                                                We</w> <w pos="VBR">
                                                're</w> <w pos="VVG">
                                                going</w> <w pos="II">
                                                on</w> <w pos="NN1">
                                                vacation</w> <w pos="II">
                                                to</w> <w pos="NP1">
                                                Brazil</w> <w pos="IF">
                                                for</w> <w pos="AT1">
                                                a</w> <w pos="NNT1">
                                                month</w> <pc pos="!">
                                                !</pc></p>
 
```
: 
 
 
 
`@msd` (morphosyntactic description) supplies morphosyntactic information for a token, usually according to some official reference vocabulary (e.g. for German:  [STTS-large tagset](http://www.ims.uni-stuttgart.de/forschung/ressourcen/lexika/TagSets/stts-1999.pdf) ; for a feature description system designed as (pragmatically) universal, see  [Universal Features](http://universaldependencies.org/u/feat/index.html) ). 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  
```
 
<ab> <w pos="PPER" msd="1.Pl.*.Nom">
                                                Wir</w> <w pos="VVFIN" msd="1.Pl.Pres.Ind">
                                                fahren</w> <w pos="APPR" msd="--">
                                                in</w> <w pos="ART" msd="Def.Masc.Akk.Sg">
                                                den</w> <w pos="NN" msd="Masc.Akk.Sg">
                                                Urlaub</w> <pc pos="$." msd="--">
                                                .</pc></ab>
 
```
: 
 
 
 
`@join` when present, it provides information on whether the token in question is adjacent to another, and if so, on which side. The definition of this attribute is adapted from ISO MAF (Morpho-syntactic Annotation Framework), ISO 24611:2012. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.text
*  **Legal values are:**: 
 
     *    **no** (the token is not adjacent to another) 
     *    **left** (there is no whitespace on the left side of the token) 
     *    **right** (there is no whitespace on the right side of the token) 
     *    **both** (there is no whitespace on either side of the token) 
     *    **overlap** (the token overlaps with another; other devices (specifying the extent and the area
                                                of overlap) are needed to more precisely locate this token in the character stream)
                                                
                                             
*  The example below assumes that the lack of whitespace is marked redundantly, by using the appropriate values of join. 
```
 
<s> <pc join="right">
                                                "</pc> <w join="left">
                                                Friends</w> <w>will</w> <w>be</w> <w join="right">
                                                friends</w> <pc join="both">
                                                .</pc> <pc join="left">
                                                "</pc></s>
 
```
Note that a project may make a decision to only indicate lack of whitespace in one direction, or do that non-redundantly. The existing proposal is the broadest possible, on the assumption that we adopt the "streamable view", where all the information on the current element needs to be represented locally. : 
*  The English sentence ‘We're going on vacation.’ tagged with the CLAWS-5 tagset, arranged sequentially, tagged on the assumption that only the lack of the preceding whitespace is indicated. 
```
 
<p> <w pos="PNP">
                                                We</w> <w pos="VBB" join="left">
                                                're</w> <w pos="VVG">
                                                going</w> <w pos="PRP">
                                                on</w> <w pos="NN1">
                                                vacation</w> <pc pos="PUN" join="left">
                                                .</pc></p>
 
```
: 
 
 
 
 
 
 
 
 
 
 
#### **Note**
 
These attributes make it possible to encode simple language corpora and to add a layer of linguistic information to any tokenized resource. See section  [17.4.2. Lightweight Linguistic Annotation](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/AI.html#AILALW)  for discussion. 
 
 
 
 
 
 
 ----- 
 
### att.milestoneUnit<span id="att.milestoneUnit"/>
 
 
**att.milestoneUnit** provides an attribute to indicate the type of section which is changing at a specific milestone. 
 
 
#### **Members**
 
 [milestone](#milestone) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@unit` provides a conventional name for the kind of section changing at this milestone. 
 
 
*  **Status**: Required
*  **Datatype**: teidata.enumerated
*  **Suggested values include:**: 
 
     *    **page** physical page breaks (synonymous with the pb element).
                                             
     *    **column** column breaks.
     *    **line** line breaks (synonymous with the lb element).
                                             
     *    **book** any units termed book, liber, etc.
     *    **poem** individual poems in a collection.
     *    **canto** cantos or other major sections of a poem.
     *    **speaker** changes of speaker or narrator.
     *    **stanza** stanzas within a poem, book, or canto.
     *    **act** acts within a play.
     *    **scene** scenes within a play or act.
     *    **section** sections of any kind.
     *    **absent** passages not present in the reference edition.
     *    **unnumbered** passages present in the text, but not to be included as part of the reference.
*  
```
 
<milestone n="23" ed="La" unit="Dreissiger"/> ... <milestone n="24" ed="AV" unit="verse"/> ...
                                          
 
```
: 
*  **Note**: If the milestone marks the beginning of a piece of text not present in the reference edition, the special value absent may be used as the value of unit. The normal interpretation is that the reference edition does not contain the text which follows, until the next  [milestone](#milestone)  tag for the edition in question is encountered. In addition to the values suggested, other terms may be appropriate (e.g. Stephanus for the Stephanus numbers in Plato). 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.naming<span id="att.naming"/>
 
 
**att.naming** provides attributes common to elements which refer to named persons, places, organizations etc. 
 
 
#### **Members**
 
 [att.personal](#att.personal)  [ [name](#name) ]  [author](#author)  [editor](#editor)  [pubPlace](#pubPlace) 
 
 
 
 
 
#### **Attributes**
 
Attributes  [att.canonical](#att.canonical) `@key`, `@ref`) 
 
 
`@role` may be used to specify further information about the entity referenced by this name in the form of a set of whitespace-separated values, for example the occupation of a person, or the status of a place. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.enumerated separated by whitespace
 
 
 
`@nymRef` (reference to the canonical name) provides a means of locating the canonical form (nym) of the names associated with the object named by the element bearing it. 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  **Note**: The value must point directly to one or more XML elements by means of one or more URIs, separated by whitespace. If more than one is supplied, the implication is that the name is associated with several distinct canonical names. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.notated<span id="att.notated"/>
 
 
**att.notated** provides an attribute to indicate any specialised notation used for element content. 
 
 
#### **Members**
 
 [quote](#quote) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@notation` names the notation used for the content of the element. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.patternReplacement<span id="att.patternReplacement"/>
 
 
**att.patternReplacement** provides attributes for regular-expression matching and replacement. 
 
 
#### **Members**
 
 [prefixDef](#prefixDef) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@matchPattern` specifies a regular expression against which the values of other attributes can be matched. 
 
 
*  **Status**: Required
*  **Datatype**: teidata.pattern
*  **Note**: The syntax used should follow that defined by  [W3C XPath syntax](http://www.w3.org/TR/xpath-functions/#regex-syntax) . Note that parenthesized groups are used not only for establishing order of precedence and atoms for quantification, but also for creating subpatterns to be referenced by the replacementPattern attribute. 
 
 
 
`@replacementPattern` specifies a ‘replacement pattern’, that is, the skeleton of a relative or absolute URI containing references to groups in the matchPattern which, once subpattern substitution has been performed, complete the URI. 
 
 
*  **Status**: Required
*  **Datatype**: teidata.replacement
*  **Note**: The strings $1, $2 etc. are references to the corresponding group in the regular expression specified by matchPattern (counting open parenthesis, left to right). Processors are expected to replace them with whatever matched the corresponding group in the regular expression. If a digit preceded by a dollar sign is needed in the actual replacement pattern (as opposed to being used as a back reference), the dollar sign must be written as `%24`. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.personal<span id="att.personal"/>
 
 
**att.personal** (attributes for components of names usually, but not necessarily, personal names) common attributes for those elements which form part of a name usually, but not necessarily, a personal name. 
 
 
#### **Members**
 
 [name](#name) 
 
 
 
 
 
#### **Attributes**
 
Attributes  [att.naming](#att.naming) `@role`, `@nymRef`) ( [att.canonical](#att.canonical)  (`@key`, `@ref`)) 
 
 
`@full` indicates whether the name component is given in full, as an abbreviation or simply as an initial. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **yes** the name component is spelled out in full. [Default] 
     *    **abb** (abbreviated) the name component is given in an abbreviated form.
     *    **init** (initial letter) the name component is indicated only by one initial.
 
 
 
`@sort` specifies the sort order of the name component in relation to others within the name. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.count
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.placement<span id="att.placement"/>
 
 
**att.placement** provides attributes for describing where on the source page or object a textual element appears. 
 
 
#### **Members**
 
 [head](#head)  [note](#note) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@place` specifies where this item is placed. 
 
 
*  **Status**: Recommended
*  **Datatype**:  1–∞ occurrences of teidata.enumerated separated by whitespace
*  **Suggested values include:**: 
 
     *    **below** below the line
     *    **bottom** at the foot of the page
     *    **margin** in the margin (left, right, or both)
     *    **top** at the top of the page
     *    **opposite** on the opposite, i.e. facing, page
     *    **overleaf** on the other side of the leaf
     *    **above** above the line
     *    **end** at the end of e.g. chapter or volume.
     *    **inline** within the body of the text.
     *    **inspace** in a predefined space, for example left by an earlier scribe.
*  
```
 
<add place="margin">
                                                [An addition written in the margin]</add><add place="bottom opposite">
                                                [An addition written at the foot of the current page and also on the facing page]</add>
 
```
: 
*  
```
 
<note place="bottom">
                                                Ibid, p.7</note>
 
```
: 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.pointing<span id="att.pointing"/>
 
 
**att.pointing** provides a set of attributes used by all elements which point to other elements by means of one or more URI references. 
 
 
#### **Members**
 
 [catRef](#catRef)  [licence](#licence)  [note](#note)  [ref](#ref)  [term](#term) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@targetLang` specifies the language of the content to be found at the destination referenced by target, using a ‘language tag’ generated according to  [BCP 47](http://www.rfc-editor.org/rfc/bcp/bcp47.txt) . 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.language
*  
```
 
<linkGrp xml:id="pol-swh_aln_2.1-linkGrp">
                                                 <ptr xml:id="pol-swh_aln_2.1.1-ptr"  target="pol/UDHR/text.xml#pol_txt_1-head" type="tuv" targetLang="pl"/> <ptr xml:id="pol-swh_aln_2.1.2-ptr"  target="swh/UDHR/text.xml#swh_txt_1-head" type="tuv" targetLang="sw"/></linkGrp>
 
```
In the example above, the `linkGrp` combines pointers at parallel fragments of the Universal Declaration of Human Rights: one of them is in Polish, the other in Swahili. : 
*  **Note**: The value must conform to BCP 47. If the value is a private use code (i.e., starts with x- or contains -x-), a  [language](#language)  element with a matching value for its ident attribute should be supplied in the TEI header to document this value. Such documentation may also optionally be supplied for non-private-use codes, though these must remain consistent with their  (IETF)Internet Engineering Task Force definitions. 
 
 
 
`@target` specifies the destination of the reference by supplying one or more URI References 
 
 
*  **Status**: Optional
*  **Datatype**:  1–∞ occurrences of teidata.pointer separated by whitespace
*  **Note**: One or more syntactically valid URI references, separated by whitespace. Because whitespace is used to separate URIs, no whitespace is permitted inside a single URI. If a whitespace character is required in a URI, it should be escaped with the normal mechanism, e.g. `TEI%20Consortium`. 
 
 
 
`@evaluate` specifies the intended meaning when the target of a pointer is itself a pointer. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **all** if the element pointed to is itself a pointer, then the target of that pointer will
                                                be taken, and so on, until an element is found which is not a pointer.
                                             
     *    **one** if the element pointed to is itself a pointer, then its target (whether a pointer
                                                or not) is taken as the target of this pointer.
                                             
     *    **none** no further evaluation of targets is carried out beyond that needed to find the element
                                                specified in the pointer's target.
                                             
*  **Note**: If no value is given, the application program is responsible for deciding (possibly on the basis of user input) how far to trace a chain of pointers. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.ranging<span id="att.ranging"/>
 
 
**att.ranging** provides attributes for describing numerical ranges. 
 
 
#### **Members**
 
 [att.dimensions](#att.dimensions)  [ [date](#date)  [gap](#gap)  [supplied](#supplied)  [unclear](#unclear) ]  [num](#num) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@atLeast` gives a minimum estimated value for the approximate measurement. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.numeric
 
 
 
`@atMost` gives a maximum estimated value for the approximate measurement. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.numeric
 
 
 
`@min` where the measurement summarizes more than one observation or a range, supplies the minimum value observed. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.numeric
 
 
 
`@max` where the measurement summarizes more than one observation or a range, supplies the maximum value observed. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.numeric
 
 
 
`@confidence` specifies the degree of statistical confidence (between zero and one) that a value falls within the range specified by min and max, or the proportion of observed values that fall within that range. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.probability
 
 
 
 
 
 
 
 
 
 
#### **Example**
 
 
```
 
The MS. was lost in transmission by mail from <del rend="overstrike">
                               <gap reason="illegible"  extent="one or two letters" atLeast="1" atMost="2" unit="chars"/></del> Philadelphia to the Graphic office, New York.
 
```
 
 
 
 
 
 
 
 ----- 
 
### att.segLike<span id="att.segLike"/>
 
 
**att.segLike** provides attributes for elements used for arbitrary segmentation. 
 
 
#### **Members**
 
 [pc](#pc) 
 
 
 
 
 
#### **Attributes**
 
Attributes  [att.datcat](#att.datcat) `@datcat`, `@valueDatcat`)  [att.fragmentable](#att.fragmentable)  (`@part`) 
 
 
`@function` characterizes the function of the segment. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Note**: Attribute values will often vary depending on the type of element to which they are attached. For example, a `cl`, may take values such as coordinate, subject, adverbial etc. For a `phr`, such values as subject, predicate etc. may be more appropriate. Such constraints will typically be implemented by a project-defined customization. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.sortable<span id="att.sortable"/>
 
 
**att.sortable** provides attributes for elements in lists or groups that are sortable, but whose sorting key cannot be derived mechanically from the element content. 
 
 
#### **Members**
 
 [bibl](#bibl)  [biblFull](#biblFull)  [idno](#idno)  [item](#item)  [list](#list)  [listBibl](#listBibl)  [listChange](#listChange)  [term](#term) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@sortKey` supplies the sort key for this element in an index, list or group which contains it. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.word
*  
```
 
David's other principal backer, Josiah ha-Kohen <index indexName="NAMES">
                                                 <term sortKey="Azarya_Josiah_Kohen">
                                                Josiah ha-Kohen b. Azarya</term></index> b. Azarya, son of one of the last gaons of Sura was David's own first cousin.
                                          
 
```
: 
*  **Note**: The sort key is used to determine the sequence and grouping of entries in an index. It provides a sequence of characters which, when sorted with the other values, will produced the desired order; specifics of sort key construction are application-dependent Dictionary order often differs from the collation sequence of machine-readable character sets; in English-language dictionaries, an entry for 4-H will often appear alphabetized under ‘fourh’, and McCoy may be alphabetized under ‘maccoy’, while A1, A4, and A5 may all appear in numeric order ‘alphabetized’ between ‘a-’ and ‘AA’. The sort key is required if the orthography of the dictionary entry does not suffice to determine its location. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.spanning<span id="att.spanning"/>
 
 
**att.spanning** provides attributes for elements which delimit a span of text by pointing mechanisms rather than by enclosing it. 
 
 
#### **Members**
 
 [lb](#lb)  [milestone](#milestone)  [pb](#pb) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@spanTo` indicates the end of a span initiated by the element bearing this attribute. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
 
 
 
 
 
 
 
 
 
 
#### **Note**
 
The span is defined as running in document order from the start of the content of the pointing element to the end of the content of the element pointed to by the spanTo attribute (if any). If no value is supplied for the attribute, the assumption is that the span is coextensive with the pointing element. If no content is present, the assumption is that the starting point of the span is immediately following the element itself. 
 
 
 
 
 
 
 ----- 
 
### att.styleDef<span id="att.styleDef"/>
 
 
**att.styleDef** provides attributes to specify the name of a formal definition language used to provide formatting or rendition information. 
 
 
#### **Members**
 
 [rendition](#rendition) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@scheme` identifies the language used to describe the rendition. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Legal values are:**: 
 
     *    **css** Cascading Stylesheet Language
     *    **xslfo** Extensible Stylesheet Language Formatting Objects
     *    **free** Informal free text description
     *    **other** A user-defined rendition description language
*  **Note**: If no value for the @scheme attribute is provided, then the default assumption should be that CSS is in use. 
 
 
 
`@schemeVersion` supplies a version number for the style language provided in scheme. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.versionNumber
*  **Note**: If schemeVersion is used, then scheme should also appear, with a value other than free. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.timed<span id="att.timed"/>
 
 
**att.timed** provides attributes common to those elements which have a duration in time, expressed either absolutely or by reference to an alignment map. 
 
 
#### **Members**
 
 [gap](#gap) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@start` indicates the location within a temporal alignment at which this element begins. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
*  **Note**: If no value is supplied, the element is assumed to follow the immediately preceding element at the same hierarchic level. 
 
 
 
`@end` indicates the location within a temporal alignment at which this element ends. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
*  **Note**: If no value is supplied, the element is assumed to precede the immediately following element at the same hierarchic level. 
 
 
 
 
 
 
 
 
 
 
 
 ----- 
 
### att.typed<span id="att.typed"/>
 
**Members**
 
 [TEI](#TEI)  [bibl](#bibl)  [change](#change)  [corr](#corr)  [date](#date)  [div](#div)  [head](#head)  [lb](#lb)  [lg](#lg)  [listBibl](#listBibl)  [listChange](#listChange)  [milestone](#milestone)  [name](#name)  [note](#note)  [pb](#pb)  [pc](#pc)  [quote](#quote)  [ref](#ref)  [reg](#reg)  [relatedItem](#relatedItem)  [term](#term)  [text](#text)  [trailer](#trailer) 
 
 
 
#### **Attributes**
 
 
 
 
`@type` characterizes the element in some sense, using any convenient classification scheme or typology. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  
```
 
<div type="verse">
                                                 <head>Night in Tarras</head> <lg type="stanza">
                                                  <l>At evening tramping on the hot white road</l>  <l>…</l> </lg> <lg type="stanza">
                                                  <l>A wind sprang up from nowhere as the sky</l>  <l>…</l> </lg></div>
 
```
: 
*  **Note**: The type attribute is present on a number of elements, not all of which are members of  [att.typed](#att.typed) , usually because these elements restrict the possible values for the attribute in a specific way. 
 
 
 
`@subtype` provides a sub-categorization of the element, if needed 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.enumerated
*  **Note**: The subtype attribute may be used to provide any sub-classification for the element additional to that provided by its type attribute. 
 
 
 
 
 
 
 
 
 
 
#### **Note**
 
When appropriate, values from an established typology should be used. Alternatively a typology may be defined in the associated TEI header. If values are to be taken from a project-specific list, this should be defined using the `valList` element in the project-specific schema description, as described in  [23.3.1.4. Modification of Attribute and Attribute Value Lists](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/USE.html#MDMDAL)  . 
 
 
 
 
 
 
 ----- 
 
### att.written<span id="att.written"/>
 
 
**att.written** provides an attribute to indicate the hand in which the content of an element was written in the source being transcribed. 
 
 
#### **Members**
 
 [closer](#closer)  [div](#div)  [head](#head)  [hi](#hi)  [note](#note)  [opener](#opener)  [p](#p)  [text](#text) 
 
 
 
 
 
#### **Attributes**
 
 
 
 
`@hand` points to a `handNote` element describing the hand considered responsible for the content of the element concerned. 
 
 
*  **Status**: Optional
*  **Datatype**: teidata.pointer
 
 
 
 
 
 
 
 
 
 
