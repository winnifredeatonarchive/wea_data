/*  Javascript for the Documentation */

/* 
  * Add an event listener for the onload event so that we can call the 
  * initStatic function
  */
if (window.addEventListener) window.addEventListener('load', init, false)
else if (window.attachEvent) window.attachEvent('onload', init);

function init(){
    addDocClass();
    addSearch();
    addPopupClose();
    makeAsideResponsive();
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