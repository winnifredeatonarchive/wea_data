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
    if (document.querySelectorAll('img[data-src]')){
        lazyload();
    }
   if (searchParams.has("searchTokens")){
    highlightSearchMatches();
    } else {
        addEvents();
    }

/*    makeAsideResponsive();*/


}


window.addEventListener("beforeprint", setupPrint);
window.addEventListener("afterprint", undoPrint);

function lazyload(){
    var lazyLoadInstance = new LazyLoad({
    elements_selector: "img[data-src]"
});
}

function setupPrint(){
    var credits = document.getElementById('credits');
    
    if (!(credits.classList.contains('open'))){
        credits.classList.remove('closed');
        credits.classList.add('open');
        credits.classList.add('printonly');
    }
    
}


function undoPrint(){
    var credits = document.getElementById('credits');
    if (credits.classList.contains('open') && credits.classList.contains('printonly')){
        credits.classList.remove('open');
        credits.classList.remove('printonly');
        credits.classList.add('closed');
    }
}


function addEvents(){
    addHeaderSearch();
    addHeaderSearchSubmit();
    addPopupClose();
    makeFootnotesResponsive();
    makeNamesResponsive();
    makeCitationsResponsive();
    makeNavClickable();
    showHideTitles();
    makeBarsExpandable();
    if (document.querySelectorAll('table')){
        makeTablesSortable();
    }
    if (document.getElementById('tools')){
        makeToolbarResponsive();
    }
    if (docId == 'index'){
        initIndex();
    }
}


function addHeaderSearchSubmit(){
    
    var searchBtn = document.getElementById('nav_search_button');
    console.log(searchBtn);
    searchBtn.addEventListener('click', submitSearch, true);
}




function makeNavClickable(){
    var nav_toggle = document.getElementById('nav_toggle');
    nav_toggle.addEventListener('click', toggleNav, true);
    var navCloser = document.getElementById('nav_closer');
    navCloser.addEventListener('click', toggleNav, true);
    var overlayCloser = document.getElementById('header_overlay');
    overlayCloser.addEventListener('click',toggleNav,true);
}
 
 
function toggleNav(){
      var e=arguments[0];
      /* Get rid of the #href functionality */
      e.preventDefault();
      
      toggleOpenClose(document.getElementById('menu_main'), true);
      toggleOverlay();
}    

function toggleOverlay(){
    document.getElementsByTagName('body')[0].classList.toggle("overlay");
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

     var headerInput = document.getElementById('nav_search_input');
     
     /* Add the main title search capacity */
     headerInput.addEventListener('input',titleSearch);
     var results = document.querySelectorAll('#siteMap .item');
     
     /* For every result item, add the addFocusEvent */
     results.forEach(function(r){
         r.addEventListener('focus', addFocusEvent)
         });
     
     /* And for the header input */
     headerInput.addEventListener('focus',addFocusEvent);
     headerInput.addEventListener('keydown',submitSearch);
}

function submitSearch(){
    var e=arguments[0];
    var searchInput = document.getElementById('nav_search_input');
    if (this.tagName == 'A' || e.key == 'Enter' || this.tagName == 'BUTTON'){
        if (this.tagName == 'A'){
            e.preventDefault();
        }
        console.log(searchInput);
        var href = "search.html";
        if (!(searchInput.value === "")){
            href = "search.html?q=" + encodeURIComponent(searchInput.value);
        }
        window.location.href = href;
    }
     
}

function removeOtherOpenNavs(){
    var openNavs = document.querySelectorAll('header .open');
    for (var i=0; i < openNavs.length; i++){
        toggleOpenClose(openNavs[i]);
    }
     clearTitleSearchResults();
    document.getElementsByTagName('header')[0].classList.remove('closed');
    document.getElementsByTagName('header')[0].classList.remove('open');
    document.getElementsByTagName('header')[0].classList.add('closed');
}


/* A small function to add the keydown press; it likely doesn't need
 * to be a function, but we'll keep it like in case we need to remove it */
function addFocusEvent(){
      // this.addEventListener('keydown',scrollThruNew);
}

/*
function scrollThruNew(){
     var e=arguments[0];
     var searchBox = document.getElementById('nav_search');
     var results = document.querySelector('#siteMap .item.showing');
     console.log(results);
    
}


function prevInput (inputArray, currentInput, inputClass){
    for (i=0; i < inputArray.length - 1; i ++){
        if (currentInput == inputArray[1]){
            for (j = 1; j < inputArray.length - 1; j++){
                if (inputArray[i + j] && input[i +j].className == inputClass){
                    return inputArray[i-j];
                    break;
                }
            }
        }
    }
    
}

function nextInput(inputArray, currentInput, inputClass) {
    for (i = 0; i < inputArray.length - 1; i++) {
        if(currentInput == inputArray[i]) {
            for (j = 1; j < inputArray.length - i; j++) {
                //Check if the next element exists and if it has the desired class
                if(inputArray[i + j] && (inputArray[i + j].className == inputClass)) {
                    return inputArray[i + j];
                    break;
                }
            }
        }
    }   
}


/\* Function to scroll through the search results using the arrow keys *\/
function scrollThru(){
       var e=arguments[0];
       var searchBox = document.getElementById('headerSearchForm');
       var results = document.querySelectorAll('#siteMap > div > .showing');
       var preSib, nextSib;
       
       /\* If the focus is in the headerSEarchForm
        * then we just get the first and last result and set those
        * as the previous and next sibling *\/
       if (this.id == 'headerSearchForm'){
           nextSib = results[0];
           preSib = results[results.length -1];
       } else {
         /\* 
          * Otherwise, actually use the right pre and next.
          *\/
          var preSib = getPreSib(this);
          var nextSib = getNextSib(this);
       }
       
       /\* If either pre or nextSib variables are null,
        * then the previous/next choice is the search box *\/
       if (preSib == null){
           preSib = searchBox;
       }
       if (nextSib == null){
           nextSib = searchBox;
       }
       var key = e.key;
       
       /\* Now do stuff on arrow up/down *\/
       if (key == 'ArrowUp'|| key == 'ArrowDown'){
          /\* Prevent the default action (i.e. window scrolling) *\/
           e.preventDefault();
           
           /\* If they've pressed up, go up. *\/
           if (key == 'ArrowUp'){
               preSib.focus();
           } 
           /\* Otherwise, go down. *\/
           else {
             nextSib.focus();
           }
           /\* Now unfocus the first thing. *\/
          this.blur();
       } else 
       /\* If they've pressed enter, then they want to go to that page (other than the search form, of course) *\/
       if (key == 'Enter'){
         if (this.id == 'headerSearchForm'){
             return;
         } else {
             window.location = this.firstElementChild.href;  
         }
     
           
       }
        
}


/\* Taken, with thanks, from: 
 * 
 * https://gomakethings.com/finding-the-next-and-previous-sibling-elements-that-match-a-selector-with-vanilla-js/
 *  *\/
 
 
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
}*/


function toggleOpenClose(el, removeAllNavs){
    if (el.classList.contains('open')){
        el.classList.remove('open');
        el.classList.add('closed');
        if (el.id == 'headerSearch'){
            clearTitleSearchResults();
        }
    } else if (el.classList.contains('closed')){
        el.classList.remove('closed');
        if (removeAllNavs){
        removeOtherOpenNavs();
        }
        el.classList.add('open');
    } else if (el.getAttribute('id') == 'nav_main') {
        el.classList.add('open');
    } else {
        el.classList.add('closed');
    }
}

/* This will certainly need to be finessed quite a bit;
 * we'll maybe want to do some better investigation, probably by individual token
 * and we might need a way to expand the search results or to shove you over to the
 * main search page. */
function titleSearch(){
    var siteMap = document.getElementById('siteMap');
    clearTitleSearchResults();
    var inputValue = this.value;
    
    /* Quick check to see if there's content
     * in the search field */
    if (inputValue.length > 0){
        siteMap.classList.add('showing');
    } else if (siteMap.classList.contains('showing')) {
        siteMap.classList.remove('showing');
    }
    
    inputValue = inputValue.replace("'","’");
    console.log(inputValue);
    
    /* IF the string matches, then proceed */
    if (/\S/.test(inputValue)){
        var regex = new RegExp(inputValue,'i');
        var items = siteMap.querySelectorAll('.item');
        var s = 0;
        var match = 0;
        var basicInput = document.getElementById('siteMap_input');
        basicInput.classList.add('item');
        basicInput.classList.add('showing');
        basicInput.setAttribute('tabindex', 0);
        var searchLink = document.getElementById('siteMap_input_link');
        var searchString = "search.html?q=" + encodeURIComponent(inputValue);
        searchLink.setAttribute('href',searchString);
        var searchInputFill = document.getElementById('siteMap_input_fill');
        searchInputFill.innerHTML = inputValue;
  /*  if (items.length > 0){
        document.getElementById('siteMap').classList.add('hasResults');
    }*/
    
            for (s; s < items.length; s++){
                var currItem = items[s];

                if (currItem.getElementsByTagName('a')[0].innerText.match(regex) !== null){
                    if (match < 5){
                        currItem.classList.add('showing');
                        currItem.setAttribute('tabindex',0);
                        var parent = currItem.parentNode;
                        if (!parent.classList.contains('showing')){
                            parent.classList.add('showing');
                        } 
                    }
                match++; 
             }

        }
    }
 }
    
    


function clearTitleSearchResults(){
    var results = document.querySelectorAll('#nav_search .showing');
    for (r=0; r < results.length; r++){
        console.log(results[r]);
        results[r].classList.remove('showing');
        results[r].removeAttribute('tabindex');
    }
   /* document.getElementById('siteMap').classList.remove('hasResults');*/
}



function makeBarsExpandable(){

    var expandDiv = document.querySelectorAll('.expandable');
    expandDiv.forEach(function(e){
        e.firstElementChild.addEventListener('click', openCloseAI, true);
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
        n.classList.add('popup');
    });
}

function makeFootnotesResponsive(){
    var noteMarkers = document.querySelectorAll('a.noteMarker');
    noteMarkers.forEach(function(n){
        n.addEventListener('click',showPopup,true);
    });
}

function makeToolbarResponsive(){
    var toolbarItems = document.querySelectorAll('.toolbar_item');
    toolbarItems.forEach(function(t){
        if (t.getAttribute('href').startsWith('#')){
            t.addEventListener('click', showPopup, true);
        } 
    });
}

function makeNamesResponsive(){
    var names = document.querySelectorAll('a[data-el=name]');
    names.forEach(function(n){
        n.addEventListener('click', showPopup, true);
        n.classList.add('popup');
    });
}

function makeCitationsResponsive(){
    var citations = document.querySelectorAll("a[data-el='ref'][data-type='bibl']");
    citations.forEach(function(c){
        c.addEventListener('click', showPopup, true);
        c.classList.add('popup');
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
      var place;
            var popup = document.getElementById('popup');
      if (this.classList.contains('noteMarker')){
          id = this.getAttribute('href').substring(1);
          popup.setAttribute('data-place','right');
      } else if (this.classList.contains('toolbar_item')){
          id = this.getAttribute('href').substring(1);
          popup.setAttribute('data-place','right');
          popup.classList.add('toolbar');
      }
     /* Else if this is a name element and it has an @href that is a local pointer */
      else if (this.getAttribute('data-el') == 'name' && this.getAttribute('href').startsWith('#')){
          id=this.getAttribute('href').substring(1);
          popup.setAttribute('data-place','right');
      } else if (this.getAttribute('data-el') == 'ref' && this.getAttribute('data-type') == 'bibl' && this.getAttribute('href').startsWith('#')){
          id=this.getAttribute('href').substring(1);
          popup.setAttribute('data-place', 'right');
      }
      else if (this.getAttribute('data-el') == 'org' && this.getAttribute('href').startsWith('#')){
          id = this.getAttribute('href').substring(1);
          popup.setAttribute('data-place','right');
      } else if (this.getAttribute('title') && !(this.getAttribute('href'))){
          useTitle = true;
          popup.setAttribute('data-place','right');
      }
      /* Otherwise, return */
      else{
          console.log ('ERROR: This element does not have a popup; removing the click event');
          removeEvent = true;
      }
     
      

      var popupContent = document.getElementById('popup_content');
      var showing = popup.getAttribute('data-showing');

          
      if (popup.classList.contains('showing')){
          closePopup();
          console.log('I should close...'); 
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
        
        window.addEventListener('resize', closePopup, false);
        window.addEventListener('scroll', closePopup, false);
/*        window.addEventListener('resize',windowResize, false);*/
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

  function resize(el, popup, ev) {
    closePopup();
    // ignore resize events as long as an actualResizeHandler execution is in the queue
   /* if ( !resizeTimeout ) {
      resizeTimeout = setTimeout(function() {
        resizeTimeout = null;
        placeNote(el, popup);
       }, 9);
    }*/
  }
  





function placeNote(elem, note) {

/* PSUEDOCODE:
 * 
 * 1) Need to get height and width of rendered thing
 * 2) Depending on what the preferred placement (vertical or horizontal), check to see whether it can fit on the preferred side (down, right)
 * 3) Go through the hierarchy of preferences
 * 4) If none of them work, just do the preferred one
 *  */
      params = new getParams(elem, note);
      var popupHeight = params.height;
      var popupWidth = params.width;
      var place = note.getAttribute('data-place');
      var placePos = params.placePos;
      togglePopupPlaces(note, placePos);
      var header = document.getElementsByTagName('header')[0];
      var headerHeight = parseInt(window.getComputedStyle(header).getPropertyValue('height'),10);
      console.log('Header Height' + headerHeight);
      var coords = elem.getBoundingClientRect();
      
      var popupArrowBorderWidth = window.getComputedStyle(note, 'after').getPropertyValue('border-width');
      var popupArrowBorderHeight = window.getComputedStyle(note, 'before').getPropertyValue('border-width');
      var defaultValue = 7;
      var popupArrowWidth = (parseInt(popupArrowBorderWidth,10) || 7);
      var popupArrowHeight = (parseInt(popupArrowBorderHeight,10) || 7);

      
      console.log(params.longNote);
      if (placePos.match('bottom')){
      
            var elemXMiddle = (coords.left + coords.right)/2;
            var elemBottom = coords.bottom;
            var notePlace = window.scrollY + coords.bottom + popupArrowHeight;
            console.log(notePlace);
            note.style.top = notePlace + "px";
            if (placePos == 'bottom_right'){
               note.style.left = coords.left + "px";
            } else {
                console.log(coords.left + elem.offsetWidth);
               note.style.left = Math.max(coords.right - popupWidth, 0) + elem.offsetWidth +  "px";
            }


          
      } else if (placePos == 'right'){
          var middle = (coords.top + coords.bottom)/2;
          var h = middle - popupHeight/2;
          var w = coords.left + elem.offsetWidth + popupArrowWidth;
          var x = window.pageXOffset + w + "px";
          var y = window.pageYOffset + h + "px";
          note.style.top = y;
          note.style.left = x;
      }
      
      
     
   
      
    }

function togglePopupPlaces(note, placePos){
    note.classList.remove('left', 'right', 'top', 'bottom_left','bottom_right', 'long');
    note.classList.add(placePos);
}
    
function getParams(elem, note){
      var bodyRight = document.getElementById('mainBody').getBoundingClientRect().right;
      var elemCoords = elem.getBoundingClientRect();
      var popupCoords = popup.getBoundingClientRect();
      var popupHeight = note.offsetHeight;
      var popupWidth = note.offsetWidth;
      var vpw = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
      var vph = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
      console.log('vpw: '+ vpw + "vph: " + vph);
      var availableRight = (vpw - elemCoords.right) * 0.9;
      var availableFromLeft = (vpw - elemCoords.left);
      var availableBottom = vph - elemCoords.bottom
      var availableTop = vph - elemCoords.top;
      console.log('availableRight' + availableRight);
      var defaultPlace = note.getAttribute('data-place');
      console.log(defaultPlace);
      if (defaultPlace == 'right'){
          if (availableRight > popupWidth){
              placePos = 'right';
          } else if (availableFromLeft > popupWidth){
              placePos = "bottom_right";
          } else {
              placePos = "bottom_left";
          }
      }
      
      this.height = popupHeight;
      this.width = popupWidth;
      this.placePos = placePos;
      this.longNote = availableTop > 0;
      
}


/* TO DO: Add function to scroll to the most recent div's pointer in the TOC in the popup */
/* And make the facsimile thing do the same */

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
       /* Add classes to the body */
     var body = document.getElementsByTagName('body')[0];
     body.classList.add('JS');
      
     document.getElementsByTagName('header')[0].classList.add('closed');
     document.getElementById('menu_main').classList.add('closed');
       var expandDiv = document.querySelectorAll('.expandable');
    for (i=0; i < expandDiv.length; i++){
        expandDiv[i].classList.add('closed');   
    }
       
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
         popup.classList.remove('showing','top','bottom','left','right');
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
        firstMatch.classList.add('focused');
        scrollIntoViewWithOffset(firstMatch, true);
        
        /* Add dehighlight button */
        addUnhighlightButton();
        /* Now once this is done you can add event listeners */
        addEvents();
    }
    
    function addUnhighlightButton(){
        var toolsDiv = document.getElementById('tools');
        toolsDiv.setAttribute('data-hit', '1');
        
        var highlightBtn = document.getElementById('unhighlightButton');
        highlightBtn.classList.add('show');
        highlightBtn.classList.add('highlighted');
                
        highlightBtn.addEventListener('click', toggleHighlight);
        var total = document.querySelectorAll('span.highlight').length;

/*         
        button.setAttribute('id','unhighlightButton');
        button.setAttribute('class','highlighted');
        button.setAttribute('data-count', document.querySelectorAll('span.highlight').length);*/
        
        var prevButton = document.getElementById('goToPrevSearch');
        var nextButton = document.getElementById('goToNextSearch');

        if (document.querySelectorAll('span.highlight').length > 1){
                nextButton.addEventListener('click', goToNextHit);
                prevButton.addEventListener('click', goToPrevHit);
                nextButton.classList.add('show');
                prevButton.classList.add('show');
        }
        highlightBtn.setAttribute('data-count', total);
        prevButton.querySelectorAll('div.label')[0].setAttribute('data-count', total);
        nextButton.querySelectorAll('div.label')[0].setAttribute('data-count', total);
        resetHit(1, document.querySelectorAll('span.highlight').length);
    }
    
    
    function goToNextHit(){
        var nextNum = this.querySelectorAll('div.label')[0].getAttribute('data-hit');
        var hits = document.querySelectorAll('span.highlight');
        var nextHit = hits[nextNum-1];
        scrollIntoViewWithOffset(nextHit, false);
        removeFocus()
        nextHit.classList.add('focused');
        
        resetHit(nextNum, hits.length);
    }
    
     function goToPrevHit(){
        var prevNum = this.querySelectorAll('div.label')[0].getAttribute('data-hit');
        var hits = document.querySelectorAll('span.highlight');
        var prevHit = hits[prevNum-1];
        scrollIntoViewWithOffset(prevHit, false);
        removeFocus()
        prevHit.classList.add('focused');
        resetHit(prevNum, hits.length);
    }
    
    function resetHit(instance, hits){
        var prev, next;
        instance = parseInt(instance);
        hits = parseInt(hits);
        console.log('THIS INSTANCE ' + instance);
        console.log('THESE HITS:' + hits);
        if (instance == 1){
            prev = hits;
        } else {
            prev = instance - 1;
        }
        if (instance == hits){
            next = 1;
        } else {
            next = instance + 1;
        }
        
        /*  Now set the prev */
        document.getElementById('goToPrevSearch').querySelectorAll('div.label')[0].setAttribute('data-hit', prev);
        
        /* And set next */
        document.getElementById('goToNextSearch').querySelectorAll('div.label')[0].setAttribute('data-hit',next);
    }
    
    function removeFocus(){
       var focused = document.getElementsByClassName('focused');
       while (focused[0]){
           focused[0].classList.remove('focused');
       }
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
        if (!isElementInViewport(el)){
        el.scrollIntoView();
        window.scrollBy(0, scrollHeight);
        }

    }

    
    
    function returnDoc(obj){
        return obj.docId == docId;
    }
    
    
    /* Taken with thanks from: https://stackoverflow.com/a/7557433/5628 */
    function isElementInViewport (el) {
    
    var rect = el.getBoundingClientRect();

    return (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) && /*or $(window).height() */
        rect.right <= (window.innerWidth || document.documentElement.clientWidth) /*or $(window).width() */
    );
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



