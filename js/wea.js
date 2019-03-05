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
        addSearch();
    addPopupClose();
    makeAsideResponsive();
        if (searchParams.has("searchTokens")){
            highlightSearchMatches();
        
    }

}


function makeAsideResponsive(){
    var ham = document.getElementById('aside_toggle');
    ham.addEventListener('click',showHideAside);
    
}

function showHideAside(){
    var e = arguments[0];
     e.preventDefault();
    var aside = document.getElementById('aside');
    if (aside.classList.contains('closed')){
        aside.classList.remove('closed');
        aside.classList.add('showing');
    } else {
        aside.classList.remove('showing');
        aside.classList.add('closed');
    }
}



function addDocClass(){
       var body = document.getElementsByTagName('body')[0];
       body.classList.add('JS');
}
function addSearch(){
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

function makeFacsResponsive(){
    var facs = document.querySelectorAll('a.facs');
    facs.forEach(function(f){
        f.addEventListener('click',showLightbox);
    })
}

function addPopupClose(){
    var closer = document.getElementById('popup_closer');
    closer.addEventListener('click', closePopup);
   
}

function closePopup(){
    var popup = document.getElementById('popup');
    popup.removeAttribute('class');
    var popupContent = document.getElementById('popup_content');
    while (popupContent.hasChildNodes()){
        popupContent.removeChild(popupContent.lastChild)
    }
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
        getJson(url, highlightTerms)

}
        
    }
    
    function getJson(url,callback){
     console.log('REquesting ' + url);
     var xmlhttp = new XMLHttpRequest();
xmlhttp.open('GET', url, true);
xmlhttp.onreadystatechange = function() {
    if (xmlhttp.readyState == 4) {
        if(xmlhttp.status == 200) {
            var obj = JSON.parse(xmlhttp.responseText);
            callback(obj);
         }
    }
};
xmlhttp.send(null);
    }
    
    
    function highlightTerms(obj){
        var body = document.getElementsByTagName('body')[0];
        console.log(obj);
        console.log(docId);
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