'use strict';


 /**
 * @fileOverview This is the code for the front-end of the JSON-based local
 *               search engine, originally written in March 2018 by Martin
 *               Holmes. It depends on the existence of pre-constructed JSON
 *               files, one for every token that has been indexed. It is designed
 *               to function as a site-level search engine that does not depend
 *               on any server-side processing.
 *
 *               It requires a JavaScript implementation of the Porter Stemmer,
 *               which I found here:
 *
 *               https://tartarus.org/martin/PorterStemmer/js.txt
 *
 * @author <a href="mailto:mholmes@uvic.ca">Martin Holmes</a>
 * @version 0.1.0
 */

/**
 * Root namespace
 * @namespace mdh
 */
var mdh = {};

/** @constant mdh.captions
 *            A set of captions for the interface. Can be made more 
 *            elaborate with multiple languages in future.
 *            An array of objects.
 *  @type {array}
*/
mdh.captions = [];
mdh.captions['en'] = {};
mdh.captions['en'].strSearchedFor             = 'Searched for: '
mdh.captions['en'].strDocumentsFound       = 'Documents found: ';

/** @constant mdh.stopwords
 *            An array of lower-cased stopwords. This is a conventional
 *            and common list, with one or two items added for this
 *            particular site.
 *  @type {array}
 *  @default
*/
mdh.stopwords = new Array('i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', 'her', 'hers', 'herself', 'it', 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or', 'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 'will', 'just', 'don', 'should', 'now');

/**
 * mdh.LocalSearch class is the basis for the whole
 *                 operation.
 *
 * @class mdh.LocalSearch handles the tokenizing and
 *                 stemming of input search terms, the
 *                 retrieval and storage (in an object)
 *                 of JSON data for stemmed terms, the
 *                 computation of the relevance order
 *                 for found pages, and the display and
 *                 paging of results.
 * @constructor
 */
mdh.LocalSearch = function(jsonDirectory, outputDivId){
  this.jsonDirectory = jsonDirectory;           //Prefix to use when retrieving JSON files; relative to host page.
  this.mainArray     = [];                      //Array of objects each of which is constructed from an AJAX retrieval of a JSON file.
  this.currTokens    = [];                      //The unstemmed versions of the tokens we're searching for.
  this.stemmedTokens = [];                      //The stemmed set of tokens for which we're currently retrieving JSON files.
  this.docTypes      = [];                      //Array which will hold the range of selected document types within which the user wants to search.
  this.searching     = false;                   //Avoid initiating a new search while still running one.
  this.index         = {};                      //Object used basically as associative array for retrieved JSON data.
  this.captionLang   = document.getElementsByTagName('html')[0].getAttribute('lang') || 'en'; //Document language.
  this.captions      = mdh.captions[this.captionLang]; //Pointer to the caption object we're going to use.
  this.outputDivId   = outputDivId;             //Id of the div that we'll use to show results.
  this.outputDiv     = document.getElementById(this.outputDivId);
  if (!this.outputDiv){this.showDebug('Output div with id ' + this.outputDivId + ' does not exist in the document.');}
};

/**
 * Function to tokenize a user-entered search string.
 *
 * @function mdh.LocalSearch.prototype.tokenizeSearch
 * @memberof mdh.LocalSearch.prototype
 * @description Takes an input string and tokenizes it, then checks
 *                     the resulting tokens, rejecting any which are
 *                     in the stopword list, and returning an array
 *                     of the remaining tokens.
 * @param {string} str The input search string.
 * @returns {string[]} The resulting tokens created.
 */
mdh.LocalSearch.prototype.tokenizeSearch = function(str){
  var rePunc, i, imax;
  rePunc = /\[\]'";:!\.,-/g;
  str = str.replace(rePunc, '').normalize('NFD').replace(/[\u0300-\u036f]/g, "");
  var tokens = str.split(/\s+/);
  var unstoppedTokens = [];
  for (i=0, imax=tokens.length; i<imax; i++){
    if ((tokens[i].length > 2)&&(mdh.stopwords.indexOf(tokens[i]) < 0)){
      unstoppedTokens.push(tokens[i]);
    }
  }
  return unstoppedTokens;
};

/**
 * Function to stem a single token. Depends on the external Porter
 *             Stemmer JS library by andargor and Christopher
 *             McKenzie.
 *
 * @function mdh.LocalSearch.prototype.stemToken
 * @memberof mdh.LocalSearch.prototype
 * @description Takes an input token and checks whether it
 *                       begins with a capital letter; if
 *                       so, it returns the token unchanged
 *                       on the assumption that it's a proper
 *                       noun. If not, it calls the stemmer
 *                       and returns a stemmed version.
 * @param {string} str The input token string.
 * @returns {string} The resulting token string.
 */
mdh.LocalSearch.prototype.stemToken = function(str,exact){
  
/* Exact string matching */
  if (exact){
      console.log('Exact string');
      return str;
  } 
  
  else if (str.match(/^[A-Z]/)){
    return str;
  }
  else{
    return stemmer(str);
  }
};

/**
 * Function that handles the entire search operation.
 *
 * @function mdh.LocalSearch.prototype.search
 * @memberof mdh.LocalSearch.prototype
 * @description Takes a user-input search string, and
 *              has it tokenized; checks whether the
 *              search object already has results for
 *              any of the tokens, and if not, makes
 *              AJAX calls to get them; sets up a
 *              callback for when all those AJAX calls
 *              are resolved.
 * @param {string} str The input search string.
 */
mdh.LocalSearch.prototype.search = function(str){
  var i, imax, tokensToFind = [], promises = [], emptyIndex;
  var self = this;
  var exact = str.match(/^\".+\"$/);
  this.stemmedTokens = [];
  if (exact){
      str = str.replace(/"/g,'');
  }
  try{
    this.showDebug(str);
    this.currTokens = this.tokenizeSearch(str);
    this.showDebug('Tokens are ' + this.currTokens.toString());
//For each token in the search string
    for (i=0, imax=this.currTokens.length; i<imax; i++){
        console.log(i);
//First stem the token
      this.stemmedTokens[i] = this.stemToken(this.currTokens[i], exact);
//Now check whether we already have an index entry for this token
      if (!this.index.hasOwnProperty(this.stemmedTokens[i])){
//If not, add it to the array of tokens we want to retrieve.
        tokensToFind.push(this.stemmedTokens[i]);
      }
    }
    this.showDebug('Stemmed tokens are ' + this.stemmedTokens.toString());
    
    this.showDebug('Stemmed tokens for which we do not yet have index entries are ' + tokensToFind.toString());

//If we do need to retrieve JSON index data, then do it
    if (tokensToFind.length > 0){
    
      //Set off fetch operations for the things we don't have yet.
      for (i=0, imax=tokensToFind.length; i<imax; i++){
      
      //We will add an empty entry for anything that's not found, so we don't have to retrieve it again.
        emptyIndex = {'token': tokensToFind[i], 'instances': []}; //used as return value when nothing retrieved.

      //We create an array of fetches to get the json file for each token, assuming it's there.
        promises[i] = fetch(this.jsonDirectory + tokensToFind[i] + '.json', {
                            credentials: 'same-origin',
                            cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
                            headers: {
                              'Accept': 'application/json'
                            },
                            method: 'GET',
                            redirect: 'follow', // *manual, follow, error
                            referrer: 'no-referrer' // *client, no-referrer
                      })
      //If we get a response, and it looks good
                      .then(function(response){
                        if ((response.status >= 200) &&
                            (response.status < 300) &&
                            (response.headers.get('content-type')) &&
                            (response.headers.get('content-type').includes('application/json'))) {
      //then we ask for response.json(), which is itself a promise, to which we add a .then to store the data.
                          return response.json().then(function(data){ self.found(data); }.bind(self));
                        }
                        else {
      //Otherwise, we store the pre-created emptyIndex, so we don't have to look for this token again
      //in a future search.
                          self.found(emptyIndex);
                        }
                      })
      //If something goes wrong, then we again try to store an empty index through the notFound function.
      //This is not really necessary -- we could call the found method instead -- but we may want to 
      //do better debugging in the future.
                      .catch(function(e, token){
                        self.showDebug('Failed to retrieve ' + token + ': ' + e);
                        self.notFound(token);
                      }.bind(self, tokensToFind[i]));
      }

  //Now set up a Promise.all to fire the rest of the work when all fetches have
  //completed or failed.
      Promise.all(promises).then(function(values) {
        this.getResults();
      }.bind(this));
    }
//Otherwise we can just do the search with the index data we already have.
    else{
      this.getResults();
    }
  }
  catch(e){
    console.error(e);
  }
};

/**
 * Function that deals with a successful AJAX retrieval
 *               operation -- in other words, a search
 *               for a token for which an index file
 *               exists.
 * 
 * @function mdh.LocalSearch.prototype.found
 * @memberof mdh.LocalSearch.prototype
 * @description Takes the index token for which a JSON
 *              file has been retrieved, and sets
 *              its index entry to to that parsed data.
 * @param {string} token The token for which an index
 *              file search has succeeded.
 * @param {string} data The JSON data retrieved for that
 *               token.
 */
mdh.LocalSearch.prototype.found = function(data){
  this.showDebug(Object.keys(data).toString());
  this.showDebug('Attempting to store results for ' + data.token);
  if (this.stemmedTokens.indexOf(data.token) > -1){
    this.index[data.token] = data;
    this.showDebug('Stored index data for ' + data.token);
  }
  else{
    this.showDebug('JSON retrieval failed: ' + data.toString());
  }
};

/**
 * Function that deals with a failed AJAX retrieval
 *               operation -- in other words, a search
 *               for a token that is not indexed.
 *
 * @function mdh.LocalSearch.prototype.notFound
 * @memberof mdh.LocalSearch.prototype
 * @description Takes the index token for which a JSON
 *              file has not been retrieved, and sets
 *              its index entry to null.
 * @param {string} token The token for which an index
 *              file search has failed.
 */
mdh.LocalSearch.prototype.notFound = function(token){
  this.showDebug('No data retrieved for token: ' + token);
  if (!this.index.hasOwnProperty(token)){
    this.index[token] = {'token': token, 'instances': []};
  }
};

/**
 * Function that triggers after index entries have
 *               been retrieved by AJAX, or once we
 *               have figured out that we don't need
 *               to retrieve anything because we already
 *               have the data we need to do the search.
 *
 * @function mdh.LocalSearch.prototype.getResults
 * @memberof mdh.LocalSearch.prototype
 * @description Uses the stemmedTokens member to retrieve
 *              index data for the search, to put all
 *              the hit pages into descending order of
 *              relevance, then triggers the display
 *              functionality.
 */

mdh.LocalSearch.prototype.getResults = function(){
  if (this.outputDiv == null){return;}
  var hits = {}, arrHits = [], i, imax, j, jmax, token, docId, hitCount, term, hit, p, ul, li, a;
  this.showDebug('Ready to get results for ' + this.stemmedTokens.toString());
  this.showDebug('Index contains: ' + Object.keys(this.index));
  for (i=0, imax = this.stemmedTokens.length; i < imax; i++){
    token = this.stemmedTokens[i];
    this.showDebug('This token: ' + token);
    if (this.index[token]){
      for (j=0, jmax = this.index[token].instances.length; j < jmax; j++){
        docId = this.index[token].instances[j].docId;
        if (docId in hits){
          hits[docId].count += this.index[token].instances[j].count;
          hits[docId].termCount += 1;
          hits[docId].contexts.push(this.index[token].instances[j].contexts);
        }
        else{
          hits[docId] = this.index[token].instances[j];
          hits[docId].termCount = 1;
          hits[docId].contexts = this.index[token].instances[j].contexts;
          
        }

      }

    }
  }
  
  //We've put our hits in an object so we could access them by docId, but 
  //now we need to sort them so we need to shift them into an array.
  for (hit in hits){
    arrHits.push(hits[hit]);
  }
  
 
  
  //Sort the results in descending order of count.
  arrHits.sort(function(a,b){
    if (a.termCount === b.termCount){
      return b.count - a.count;
    }
    else{
      return b.termCount - a.termCount;
    }
  });
    var htmlNS = 'http://www.w3.org/1999/xhtml';
  //Create output message and links
  var resultsDiv = document.createElementNS(htmlNS,'div');
  resultsDiv.classList.add('results');
  hitCount = 0;

  for (i = 0, imax = arrHits.length; i < imax; i++){
      var docResultsDiv = document.createElementNS(htmlNS,'div');
      var thisHit = arrHits[i];
      var thisDocId = thisHit.docId;
      var thisContexts = thisHit.contexts;
      console.log('Contexts length ' + thisContexts.length);
      
      this.showDebug(thisHit.docId + ': termCount: ' + thisHit.termCount + '; count: ' + thisHit.count + '; contexts: ' + thisHit.contexts);
      hitCount++;
      
      
      var div = document.createElementNS(htmlNS, 'div');
      a = document.createElementNS(htmlNS, 'a');
      var contextDiv = document.createElementNS(htmlNS,'div');
      for (var c = 0; c < thisContexts.length; c++){
          var currCon = thisContexts[c];
          var connDiv = document.createElementNS(htmlNS,'div');
          connDiv.classList.add('snippet');
          connDiv.innerHTML = currCon;
          contextDiv.appendChild(connDiv);
      }
      var cp = document.createElementNS(htmlNS, 'p');
      a.setAttribute('href', arrHits[i].docId + '.html');
      a.setAttribute('target', '_blank');
      //this.showDebug(hits[hit].docTitle);
      a.innerHTML = arrHits[i].docTitle;
      docResultsDiv.appendChild(a);
      docResultsDiv.appendChild(document.createTextNode(' (Score: ' + arrHits[i].count + ')'));
      docResultsDiv.appendChild(contextDiv);
      resultsDiv.appendChild(docResultsDiv);
  }
  while(this.outputDiv.firstChild){this.outputDiv.removeChild(this.outputDiv.firstChild);}
  this.outputDiv.appendChild(document.createTextNode(this.captions.strSearchedFor + ' ' + this.currTokens.join(', ')));
  this.outputDiv.appendChild(document.createElementNS('http://www.w3.org/1999/xhtml', 'br'));
  this.outputDiv.appendChild(document.createTextNode(this.captions.strDocumentsFound + ' ' + hitCount));
  this.outputDiv.appendChild(resultsDiv);
};



/**
 * Function to retrieve the range of selected document types
 * from checkboxes on the page.
 *
 * @function mdh.LocalSearch.prototype.getDocTypes
 * @memberof mdh.LocalSearch.prototype
 * @description Searches the page for input checkboxes and
 *              retrieves the values of all the checked ones
 *              into a string array. 
 * 
 */
/*mdh.LocalSearch.prototype.getDocTypes = function(){
  var i, imax, checkboxes;
  this.docTypes.length = 0;
  checkboxes = document.querySelectorAll('div[id="includes"] input[type="checkbox"]:checked');
  for (i = 0, imax = checkboxes.length; i < imax; i++){
    this.docTypes.push(checkboxes[i].getAttribute('name'));
  }
  this.showDebug(this.docTypes);
};
*/
/**
 * Function to retrieve the range of dates to filter by
 *               from select elements on the page. 
 *
 * @function mdh.LocalSearch.prototype.getDateRange
 * @memberof mdh.LocalSearch.prototype
 * @description Searches the page for date selectors and
 *              retrieves the values of them into an 
 *              object properties.
 * 
 */
/*mdh.LocalSearch.prototype.getDateRange = function(){
  var sel, searchYear, searchMonth, searchDay;
  this.startDate = '';
  this.endDate   = '';
  sel = document.querySelector('select[name="beginSearchDay"]');
  searchDay = sel.options[sel.selectedIndex].value;
  sel = document.querySelector('select[name="beginSearchMonth"]');
  searchMonth = sel.options[sel.selectedIndex].value;
  sel = document.querySelector('select[name="beginSearchYear"]');
  searchYear = sel.options[sel.selectedIndex].value;
  try{
    this.startDate = new Date(searchYear.concat('-', searchMonth, '-', searchDay));
  }
  catch(e){
    this.startDate = this.earliest;
  } 
  sel = document.querySelector('select[name="endSearchDay"]');
  searchDay = sel.options[sel.selectedIndex].value;
  sel = document.querySelector('select[name="endSearchMonth"]');
  searchMonth = sel.options[sel.selectedIndex].value;
  sel = document.querySelector('select[name="endSearchYear"]');
  searchYear = sel.options[sel.selectedIndex].value;
  try{
    this.endDate = new Date(searchYear.concat('-', searchMonth, '-', searchDay)); 
  }
  catch(e){
    this.endDate = this.latest;
  }
  this.showDebug('Start date: ' + this.startDate + '; end date: ' + this.endDate);
};*/

/**
 * Function to output debug information to the console.
 *
 * @function mdh.LocalSearch.prototype.showDebug
 * @memberof mdh.LocalSearch.prototype
 * @description Takes an input string and outputs it
 *                    to the console. The availability
 *                    of this function makes it easy to
 *                    turn debugging on and off simply
 *                    by commenting out the function
 *                    body.
 * @param {string} str The debug string to be written
 *                     to the console.
 */
mdh.LocalSearch.prototype.showDebug = function(str){
  console.log(str);
};

/* Create a search object. */
var searcher;
window.addEventListener('load', function(){searcher = new mdh.LocalSearch('js/search/', 'searchResults');});
