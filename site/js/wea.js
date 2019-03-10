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
    addPopupClose();
    makeFootnotesResponsive();
    makeNamesResponsive();
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
        console.log(n);
        n.addEventListener('click', showPopup, true);
    });
}

 /** 
   * Makes the specified popups (which can be a list of ids) popup
   * The list of ids must be space separated (id1 id2 etc)
   * author: jtakeda 
   */
  function showPopup(){
      
      /* Cross browser solution for event handling from https://stackoverflow.com/questions/9636400/event-equivalent-in-firefox#answer-15164880 */
      var e=arguments[0];
      var el = this;
      console.log(el);
      /* Stop the onclick from bubbling */
      e.stopPropagation();
      /* And prevent default action for links with @href */
      e.preventDefault();
      
      console.log('Showing popup');
      /* Declare empty var */
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
      } 
      /* Otherwise, return */
      else{
          console.log ('ERROR: This element does not have a popup; removing the click event');
          this.removeEventListener('click', showPopup, false);
          return;
      }
      
      
      var popup = document.getElementById('popup');
      var popupContent = document.getElementById('popup_content');
      var showing = popup.getAttribute('data-showing');
            /* Close the existing popup, if necessary */
      closePopup();
      var thisThing = document.getElementById(id);
      var clone = thisThing.cloneNode(true);
      
      popupContent.appendChild(clone);
            //Set the popup @data-showing to the ids
        windowResize = function(){
            resize(el, popup);
        }
        window.addEventListener('resize',windowResize, false);
        popup.setAttribute('data-showing',id);
        //And set the display to block
        popup.classList.remove('hidden');
        popup.classList.add('showing');
        placeNote(this,popup);

      
   }
   

  var resizeTimeout;
  var windowResize;

  function resize(el, popup) {

    // ignore resize events as long as an actualResizeHandler execution is in the queue
    if ( !resizeTimeout ) {
      resizeTimeout = setTimeout(function() {
        resizeTimeout = null;
        placeNote(el, popup);
       // The actualResizeHandler will execute at a rate of 15fps
       }, 5);
    }
  }
  

function placeNote(elem, note) {

      var popupHeight = note.offsetHeight;
      var header = document.getElementsByTagName('header')[0];
      var headerHeight = header.getBoundingClientRect().top;
      var coords = elem.getBoundingClientRect();
      var popupArrowBorderWidth = window.getComputedStyle(note, 'before').getPropertyValue('border-width');
      var popupArrowWidth = parseInt(popupArrowBorderWidth,10);
      console.log(elem);
      console.log('Top:', coords.top);
      var h = coords.top - popupHeight/2;
      if (inViewport(header)){
          h = coords.top - popupHeight/2 + headerHeight;
      }
      coords.top - popupHeight/2 + headerHeight;
      var w = coords.left + elem.offsetWidth + popupArrowWidth;
          note.style.left = window.scrollX + w + "px";
          note.style.top = window.scrollY + h + "px";
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
    popup.removeAttribute('style');
    popup.removeAttribute('class');
    popup.removeAttribute('data-showing');
    var popupContent = document.getElementById('popup_content');
    while (popupContent.hasChildNodes()){
        popupContent.removeChild(popupContent.lastChild)
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
            console.log(i +": " + thisInstanceId);
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
        /* Add dehighlight button */
        addUnhighlightButton();
        /* Now once this is done you can add event listeners */
        addEvents();
    }
    
    function addUnhighlightButton(){
        var button = document.createElement('div');
        button.setAttribute('id','unhighlightButton');
        button.setAttribute('class','highlighted');
        button.setAttribute('data-count', document.querySelectorAll('span.highlight').length);
        button.addEventListener('click', toggleHighlight);
        var header = document.getElementsByTagName('header')[0];
        header.parentNode.insertBefore(button, header.nextSibling);
        
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





function showLightbox(){
    var e=arguments[0];
      /* Stop the onclick from bubbling */
      e.stopPropagation();
      /* And prevent default action for links with @href */
      e.preventDefault();
    closePopup();
    console.log('LIGHTbOX');
    var imgRef = this.getAttribute('href');
    console.log(imgRef);
    var popup = document.getElementById('popup');
    var popupDiv = document.getElementById('popup_content');
    var imgEl = document.createElement('img');
    imgEl.src = imgRef;
    imgEl.alt = 'Facsimile Image';
    popupDiv.appendChild(imgEl);
    popup.classList.add('lightbox');
}