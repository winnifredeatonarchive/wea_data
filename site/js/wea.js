/*  Javascript for the Documentation */

/* 
  * Add an event listener for the onload event so that we can call the 
  * initStatic function
  */
if (window.addEventListener) window.addEventListener('load', init, false)
else if (window.attachEvent) window.attachEvent('onload', init);

var docId = document.getElementsByTagName('html')[0].getAttribute('id');
url = new URL(document.URL);
searchParams = url.searchParams;


function init(){
    addDocClass();
   if (searchParams.has("searchTokens")){
    highlightSearchMatches();
    } else {
        addEvents()
    }
    if (docId == 'search' || document.getElementById('searchResults') !== null){
            addSearch();
    }

/*    makeAsideResponsive();*/


}


function addEvents(){
    addHeaderSearch();
    addPopupClose();
    makeFootnotesResponsive();
    makeNamesResponsive();
    showHideTitles();
    makeNavClickable();
    if (document.getElementById('additional_info')){
            makeAdditionalInfoArrowClickable();
    }
    if (document.querySelectorAll('table')){
        makeTablesSortable();
    }

}

function makeNavClickable(){
    var navClicks = document.querySelectorAll("nav a[href^='#']");
    navClicks.forEach(function(n){
        n.addEventListener('click', toggleNav, true)
       });
    }
    
function toggleNav(){
      var e=arguments[0];
      /* Get rid of the #href functionality */
      e.preventDefault();
      var thisId = this.href.substring(this.href.lastIndexOf('#') + 1);
      var thisEl = document.getElementById(thisId);
      console.log(thisEl);
      toggleOpenClose(thisEl, true);
    
}    

function makeTablesSortable(){
    var th = document.querySelectorAll('th.sortable');
    th.forEach(function(t){
        t.addEventListener('click', sortTable, true)
    });
}

/* This is a fairly crude table sorting function that relies on the 
 * fact that our tables already have their sort key in place. Since each cell in a table
 * gets its own respective sort integer (i.e. where it fits in a sequence), the sorting
 * is trivial on the JS side. */
 
function sortTable(){
    /* this coliumn number */
    var cn = this.getAttribute('data-col');
    
    /* The table (we assume no nested tables) */
    var table = this.parentNode.parentNode.parentNode;
    
    /* The body of the table (there should be only 1) */
    var tbody = table.getElementsByTagName('tbody')[0];
    
    /* All of the already selected elements */
    var selected = table.getElementsByClassName('selected');
    
    /* Now iterate over the selected elements */
    
    for (var s=0; s < selected.length; s++){
    /* And so long as the selected element isn't this, then get rid of everything */
        if (!(selected[s] === this)){
           selected[s].classList.remove('up');
           selected[s].classList.remove('down');
           selected[s].classList.remove('selected');
        }
    }
    
    /* If it hasn't been selected yet, then select it. */
    if (!this.classList.contains('selected')){
        this.classList.add('selected');
     }
     
     /* Determine whether we should short ascending or descending */
    var alreadyAsc = this.classList.contains('up');
    var alreadyDesc = this.classList.contains('down');
    var asc;
    /* If it's neither up or down, then it should be sorted ascending */
    if (alreadyAsc) {
        asc = false;
    } else {
        asc = true;
    }
    
    /* UP means its sorting ascending; down descending */
    if (asc){
        this.classList.remove('down');
        this.classList.add('up');
    } else {
        this.classList.remove('up');
        this.classList.add('down');
    }
    /* Get all the rows in the body of the table */
    var rows = tbody.querySelectorAll('tr');
    
    /* Create an array from the rows */
    var rowArray = Array.from(rows);
    
    /* Now sort it by comparing the column with the row  */
    rowArray.sort(function(a,b){
       return a.getElementsByTagName('td')[cn-1].getAttribute('data-sort') - b.getElementsByTagName('td')[cn-1].getAttribute('data-sort')
       });
       
   /* Now figure out how to iterate */
   
   if (asc){
     for (var i=0; i<rows.length; i++){
        tbody.appendChild(rowArray[i]);
     }
   } else {
       for (var i=rows.length -1; i>-1; i--){
           tbody.appendChild(rowArray[i]);
       }
   }  

    }
    

function addHeaderSearch(){

     var headerInput = document.getElementById('headerSearchForm');
     
     /* Add the main title search capacity */
     headerInput.addEventListener('input',titleSearch);
     var results = document.querySelectorAll('#siteMap .item');
     
     /* For every result item, add the addFocusEvent */
     results.forEach(function(r){
         r.addEventListener('focus', addFocusEvent)
         });
     
     /* And for the header input */
     headerInput.addEventListener('focus',addFocusEvent);
}

function removeOtherOpenNavs(){
    var openNavs = document.querySelectorAll('header .open');
    for (var i=0; i < openNavs.length; i++){
        toggleOpenClose(openNavs[i]);
    }
     clearTitleSearchResults();
}


/* A small function to add the keydown press; it likely doesn't need
 * to be a function, but we'll keep it like in case we need to remove it */
function addFocusEvent(){
       this.addEventListener('keydown',scrollThru);
}

/* Function to scroll through the search results using the arrow keys */
function scrollThru(){
       var e=arguments[0];
       var searchBox = document.getElementById('headerSearchForm');
       var results = document.querySelectorAll('#siteMap .result');
       var preSib, nextSib;
       
       /* If the focus is in the headerSEarchForm
        * then we just get the first and last result and set those
        * as the previous and next sibling */
       if (this.id == 'headerSearchForm'){
           nextSib = results[0];
           preSib = results[results.length -1];
       } else {
         /* 
          * Otherwise, actually use the right pre and next.
          */
          var preSib = getPreSib(this);
          var nextSib = getNextSib(this);
       }
       
       /* If either pre or nextSib variables are null,
        * then the previous/next choice is the search box */
       if (preSib == null){
           preSib = searchBox;
       }
       if (nextSib == null){
           nextSib = searchBox;
       }
       var key = e.key;
       
       /* Now do stuff on arrow up/down */
       if (key == 'ArrowUp'|| key == 'ArrowDown'){
          /* Prevent the default action (i.e. window scrolling) */
           e.preventDefault();
           
           /* If they've pressed up, go up. */
           if (key == 'ArrowUp'){
               preSib.focus();
           } 
           /* Otherwise, go down. */
           else {
             nextSib.focus();
           }
           /* Now unfocus the first thing. */
          this.blur();
       } else 
       /* If they've pressed enter, then they want to go to that page (other than the search form, of course) */
       if (key == 'Enter'){
         if (this.id == 'headerSearchForm'){
             return;
         } else {
             window.location = this.firstElementChild.href;  
         }
     
           
       }
        
}


/* Taken, with thanks, from: 
 * 
 * https://gomakethings.com/finding-the-next-and-previous-sibling-elements-that-match-a-selector-with-vanilla-js/
 *  */
 
 
function getPreSib(el){
    var pre = el.previousSibling;
    
    while (pre){
           if (pre.classList.contains('result')) return pre;
           pre = pre.previousSibling;
    }
}

function getNextSib(el){
        var next = el.nextSibling;
    while (next){
           if (next.classList.contains('result')) return next;
           next = next.nextSibling;
    }
}


function toggleOpenClose(el, removeAllNavs){
    if (el.classList.contains('open')){
        el.classList.remove('open');
        el.classList.add('closed');
    } else {
        el.classList.remove('closed');
        if (removeAllNavs){
        removeOtherOpenNavs();
        
        }
        el.classList.add('open');
    }
}

/* This will certainly need to be finessed quite a bit;
 * we'll maybe want to do some better investigation, probably by individual token
 * and we might need a way to expand the search results or to shove you over to the
 * main search page. */
function titleSearch(){
    clearTitleSearchResults();
    var value = this.value;
     if (/\S/.test(value)){
    var regex = new RegExp(value,'i');
    var siteMap = document.getElementById('siteMap');
    var items = siteMap.querySelectorAll('.item');
    var s = 0;
    var match = 0;
  /*  if (items.length > 0){
        document.getElementById('siteMap').classList.add('hasResults');
    }*/
    for (s; s < items.length; s++){
        var currItem = items[s];
        console.log(s);

        if (currItem.getElementsByTagName('a')[0].innerText.match(regex) !== null){
             if (match < 5){
                currItem.classList.add('result');
                currItem.setAttribute('tabindex',0);
             }
           match++;
        }
    }
    }     
    
    
    
}

function clearTitleSearchResults(){
    var results = document.querySelectorAll('.result');
    for (r=0; r < results.length; r++){
        console.log(results[r]);
        results[r].classList.remove('result');
        results[r].removeAttribute('tabindex');
    }
   /* document.getElementById('siteMap').classList.remove('hasResults');*/
}



function makeAdditionalInfoArrowClickable(){

    var addInfDiv = document.querySelectorAll('.additionalInfo');
    addInfDiv.forEach(function(a){
        a.classList.add('closed');
        var head = a.querySelectorAll('.additionalInfoHeader')[0];
        head.addEventListener('click', openCloseAI, true);
    });
}

function openCloseAI(){
    var div = this.parentNode;
    toggleOpenClose(div);
        
}

function showHideTitles(){
    var spansToShow = document.querySelectorAll('.showTitle');
    spansToShow.forEach(function(n){
        n.addEventListener('click', showPopup, true);
    });
}

function makeFootnotesResponsive(){
    var noteMarkers = document.querySelectorAll('a.noteMarker');
    noteMarkers.forEach(function(n){
        n.addEventListener('click',showPopup,true);
    });
}

function makeNamesResponsive(){
    var names = document.querySelectorAll('a[data-el=name]');
    names.forEach(function(n){
        n.addEventListener('click', showPopup, true);
    });
}

 /** 
   * Makes the specified popups (which can be a list of ids) popup
   * The list of ids must be space separated (id1 id2 etc)
   * author: jtakeda 
   */
  function showPopup(){
                 /* Close the existing popup, if necessary */
      /* Cross browser solution for event handling from https://stackoverflow.com/questions/9636400/event-equivalent-in-firefox#answer-15164880 */
      var e=arguments[0];
      var el = this;
      /* Stop the onclick from bubbling */
      e.stopPropagation();
      /* And prevent default action for links with @href */
      e.preventDefault();
      /* Declare empty var */
      var useTitle = false;
      var removeEvent = false;
      var id = '';
      /* If this is an annotation and the annotation button is checked */
      /* Sometimes the annotation/collation buttons aren't there (if, for instance, there are no collations in the document)
       * and we have to have a switch for that */
       
      if (this.classList.contains('noteMarker')){
          id = this.getAttribute('href').substring(1);
      } 
     /* Else if this is a name element and it has an @href that is a local pointer */
      else if (this.getAttribute('data-el') == 'name' && this.getAttribute('href').startsWith('#')){
          id=this.getAttribute('href').substring(1);
      } else if (this.getAttribute('title') && !(this.getAttribute('href'))){
          useTitle = true;
      }
      /* Otherwise, return */
      else{
          console.log ('ERROR: This element does not have a popup; removing the click event');
          removeEvent = true;
      }
     
      
      var popup = document.getElementById('popup');
      var popupContent = document.getElementById('popup_content');
      var showing = popup.getAttribute('data-showing');
      
          
      if (popup.classList.contains('showing')){
          closePopup();
          
      }
      var content;
      if (useTitle){
          var dummyDiv = document.createElement('div');
          dummyDiv.setAttribute('class','para');
          dummyDiv.innerHTML = this.getAttribute('title');
          content = dummyDiv;
      } else if (!(useTitle) && !(id == '')){
           var thisThing = document.getElementById(id);
            var clone = thisThing.cloneNode(true);
          content = clone;
      } else if (removeEvent){
          var dummyDiv = document.createElement('div');
          dummyDiv.setAttribute('class','para');
          dummyDiv.innerHTML = 'This popup is not available.';
          content = dummyDiv;
      }
   
      
      popupContent.appendChild(content);
            //Set the popup @data-showing to the ids
        windowResize = function(){
            resize(el, popup);
        }
        window.addEventListener('resize',windowResize, false);
        if (!(useTitle)){
              popup.setAttribute('data-showing',id);
        }
      
        //And set the display to block
        popup.classList.remove('hidden');
        popup.classList.add('showing');
        placeNote(this,popup);
        this.classList.add('clicked');
        if (removeEvent){
            this.removeEventListener('click',showPopup,true);
            this.classList.remove('showTitle');
        }

   }
   
   

  var resizeTimeout;
  var windowResize;

  function resize(el, popup) {

    // ignore resize events as long as an actualResizeHandler execution is in the queue
    if ( !resizeTimeout ) {
      resizeTimeout = setTimeout(function() {
        resizeTimeout = null;
        placeNote(el, popup);
       }, 9);
    }
  }
  

function placeNote(elem, note) {

      var popupHeight = note.offsetHeight;
      var header = document.getElementsByTagName('header')[0];
      var headerHeight = header.getBoundingClientRect().top;
      var coords = elem.getBoundingClientRect();
      var popupArrowBorderWidth = window.getComputedStyle(note, 'before').getPropertyValue('border-width');
      var defaultValue = 7;
      var popupArrowWidth = parseInt(popupArrowBorderWidth,10);
      if (isNaN(popupArrowWidth)){
          console.log('WARNING: popupArrowWidth NAN; setting default value of ' + defaultValue);
          popupArrowWidth = defaultValue;
      }
      var middle = (coords.top + coords.bottom)/2;
      var h = middle - popupHeight/2;
      console.log(popupArrowWidth);
      var w = coords.left + elem.offsetWidth + popupArrowWidth;

      var x = window.pageXOffset + w + "px";
      var y = window.pageYOffset + h + "px";
            console.log(window.pageXOffset + "+" + w + "px" + "=" + x);
      console.log(y);


      note.style.left = x;
      note.style.top = y;
    }
  
/*  Taken from https://gomakethings.com/how-to-test-if-an-element-is-in-the-viewport-with-vanilla-javascript/ */
function inViewport (elem) {
    var bounding = elem.getBoundingClientRect();
    return (
        bounding.top >= 0 &&
        bounding.left >= 0 &&
        bounding.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
        bounding.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
};


function addDocClass(){
       var body = document.getElementsByTagName('body')[0];
       body.classList.add('JS');
}
function addSearch(){
     searcher = new mdh.LocalSearch('js/search/', 'searchResults');
     var searches = document.querySelectorAll('input[name=search]');
     console.log('Adding search functionality...');
     searches.forEach(function(s){
                s.addEventListener('keydown',initSearch)
           });
}

function initSearch(){
    var e=arguments[0];
    if (e.key === 'Enter'){
        console.log('Entered!');
        console.log('Searching for ' + this.value);
        searcher.search(this.value);
 }
}



function addPopupClose(){
    var closer = document.getElementById('popup_closer');
    closer.addEventListener('click', closePopup);
   
}


      /* Close popup */
      
function closePopup(){
    var popup = document.getElementById('popup');

    if (popup.classList.contains('showing')){
        console.log('Removing popup');
         popup.removeAttribute('style');
         popup.classList.remove('showing');
         popup.classList.add('hidden');
         popup.removeAttribute('data-showing');
         var popupContent = document.getElementById('popup_content');
         while (popupContent.hasChildNodes()){
        popupContent.removeChild(popupContent.lastChild)
        }
    }
         var c = document.querySelectorAll('.clicked');
             for (var i =0; i <c.length; i++){
                  c[i].classList.remove('clicked');
                  }
   
   
       window.removeEventListener('resize',windowResize, false);
}


/* This function takes in a query string "?searchTokens" and returns the highlighted tokens */
function highlightSearchMatches(){
    var searchTokensString = searchParams.get('searchTokens');
    var tokens = searchTokensString.split('|');
    for (t=0; t < tokens.length; t++){
        var thisToken = tokens[t].trim();
        console.log(thisToken);
        var ulDir;
        if (thisToken.match(/^[A-Z]/g)){
            ulDir ='upper/';
        } else {
            ulDir='lower/';
        }
        var url ="js/search/" + ulDir + thisToken + ".json";
        getJson(url, highlightTerms);


}
        
    }
    
    function getJson(url, callback){
     var json = new Array();
     console.log('REquesting ' + url);
     var xmlhttp = new XMLHttpRequest();
xmlhttp.open('GET', url, true);
xmlhttp.onreadystatechange = function() {
    if (xmlhttp.readyState == 4) {
        if(xmlhttp.status == 200) {
            var obj = JSON.parse(xmlhttp.responseText);
            callback(obj);
         }
    } else {
        addEvents();
    }
};

xmlhttp.send(null);
    }
    
    
    function highlightTerms(obj){
        var body = document.getElementsByTagName('body')[0];
        console.log(obj[0]);
        var instance;
        for (i=0; i < obj.instances.length; i++){
            thisInstanceId = obj.instances[i].docId;
            if (thisInstanceId == docId){
                instance = obj.instances[i]
            }
        }
        var forms = instance.forms;
        var matches;
        
        for (f=0; f < forms.length; f++){
            console.log(forms[f]);
            var pattern = new RegExp('(>|$|\\s)(' + forms[f] + ')([^\\w])','g');
            var replacement = "$1<span class='highlight'>$2</span>$3";
            console.log('Pattern: ' + pattern + "; Replace: " + replacement);
            body.innerHTML = body.innerHTML.replace(pattern,replacement);
        }
        
        /* Scroll the first match into view */        
        var firstMatch = document.querySelectorAll('.highlight')[0];
        scrollIntoViewWithOffset(firstMatch, true);
        
        /* Add dehighlight button */
        addUnhighlightButton();
        /* Now once this is done you can add event listeners */
        addEvents();
    }
    
    function addUnhighlightButton(){
        var buttonsDiv = document.createElement('div');
        buttonsDiv.setAttribute('id','searchButtons');
        buttonsDiv.setAttribute('data-hit', '1');
       
        var button = document.createElement('div');
        
        
        button.setAttribute('id','unhighlightButton');
        button.setAttribute('class','highlighted');
        button.setAttribute('data-count', document.querySelectorAll('span.highlight').length);
        button.addEventListener('click', toggleHighlight);
        var prevButton = document.createElement('div');
        prevButton.setAttribute('id', 'goToPrevSearch');
        var nextButton = document.createElement('div');
        nextButton.setAttribute('id', 'goToNextSearch');
        buttonsDiv.appendChild(button);
        nextButton.addEventListener('click', goToNextHit);
        prevButton.addEventListener('click', goToPrevHit);
        if (document.querySelectorAll('span.highlight').length > 1){
                    buttonsDiv.appendChild(prevButton);
                    buttonsDiv.appendChild(nextButton);
        }
        var header = document.getElementsByTagName('header')[0];
        header.parentNode.insertBefore(buttonsDiv, header.nextSibling);
    }
    
    
    function goToNextHit(){
        var buttonDiv = document.getElementById('searchButtons');
        var hits = document.querySelectorAll('span.highlight');
        var currHit = parseInt(buttonDiv.getAttribute('data-hit'),10);
        var instance; 
        console.log(hits.length);
        if (hits.length == (currHit)){
            instance = 0;
        } else {
            instance = currHit;
        }
        console.log('Going to ' + instance);
               
        scrollIntoViewWithOffset(hits[instance], false)
        buttonDiv.setAttribute('data-hit', instance + 1);
    }
    
     function goToPrevHit(){
        var buttonDiv = document.getElementById('searchButtons');
        var hits = document.querySelectorAll('span.highlight');
        var currHit = parseInt(buttonDiv.getAttribute('data-hit'),10);
        var instance; 
        if (currHit == 1){
            instance = hits.length - 1;
        } else {
            instance = currHit - 2;
        }
        
        console.log('Going to ' + instance);
       scrollIntoViewWithOffset( hits[instance], false)
        buttonDiv.setAttribute('data-hit', instance + 1);
    }
    
    function toggleHighlight(){
        var isHighlighted = this.classList.contains('highlighted');
        var his = document.querySelectorAll('span.highlight');
        
        for (var h=0; h < his.length ; h++){
            if (isHighlighted){
                 his[h].classList.add('deselected');
            } else {
                his[h].classList.remove('deselected');
            }
           
        }
        if (isHighlighted){
            this.classList.remove('highlighted');
            this.classList.add('unhighlighted');
        } else {
            this.classList.remove('unhighlighted');
            this.classList.add('highlighted');
        }
    }
    
    function scrollIntoViewWithOffset(el, smooth){
        var header = document.getElementsByTagName('header')[0];
        var hh = header.getBoundingClientRect().height;
        var scrollHeight = -hh + -10;
        el.scrollIntoView();
        window.scrollBy(0, scrollHeight);
        
    }

    
    
    function returnDoc(obj){
        return obj.docId == docId;
    }
   
    //* Now get the JSONs for each of these... */
    
    //* Now find the distinct forms for each of those JSONS */
    
    /* And highlight them. */
    
    function highlight(container,what,spanClass) {
    var content = container.innerHTML,
        pattern = new RegExp('(>[^<.]*)(' + what + ')([^<.]*)','g'),
        replaceWith = '$1<span ' + ( spanClass ? 'class="' + spanClass + '"' : '' ) + '">$2</span>$3',
        highlighted = content.replace(pattern,replaceWith);
    return (container.innerHTML = highlighted) !== content;
}



