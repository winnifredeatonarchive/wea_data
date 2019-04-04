/*  Javascript for the Documentation */


/* 
  * Add an event listener for the onload event so that we can call the 
  * initStatic function
  */
if (window.addEventListener) window.addEventListener('load', init, false)
else if (window.attachEvent) window.attachEvent('onload', init);


function init(){
    addDocType();
    makeSpecsHover();
 }

function addDocType(){
    document.getElementsByTagName('body')[0].classList.add('JS');
}

function makeSpecsHover(){
    var specs = document.querySelectorAll('a.spec');
    specs.forEach(function(s){
        s.addEventListener('mouseover', showSpec, true);
        s.addEventListener('mouseout', removePopup, true);
    });
}
function addEvents(){
    var listHeads = document.querySelectorAll('.collapse > span, .collapse > a');
    listHeads.forEach(function(l){
        l.addEventListener('click', showHide,true)
    });
}

function removePopup(){
    document.getElementById('popup').classList.remove('showing');
    document.getElementById('popup').classList.add('hidden');
}
function showSpec(){
    var thisHref = this.getAttribute('href');
    var thisSpec = thisHref.substring(0, thisHref.length-5);
    var popup = document.getElementById('popup');
    var thisContent = document.getElementById('snippet_' + thisSpec).innerHTML;
    document.getElementById('popup_content').innerHTML = thisContent;
    placeNote(this, popup);
    popup.classList.remove('hidden');
    popup.classList.add('showing');

}

    function showHide(){
        var parent = this.parentNode;
        if (parent.classList.contains('open')){
            parent.classList.remove('open');
            parent.classList.add('closed');
        } else if (parent.classList.contains('closed')){
            parent.classList.remove('closed');
            parent.classList.add('open');
        }
    }
    
    
    
function placeNote(elem, note) {

      var popupHeight = note.offsetHeight;
      var coords = elem.getBoundingClientRect();
      var popupArrowBorderWidth = window.getComputedStyle(note, 'before').getPropertyValue('border-width');
      var defaultValue = 7;
      var popupArrowWidth = parseInt(popupArrowBorderWidth,10);
      if (isNaN(popupArrowWidth)){
          console.log('WARNING: popupArrowWidth NAN; setting default value of ' + defaultValue);
          popupArrowWidth = defaultValue;
      }
      var middle = (coords.top + coords.bottom)/2;
      var h = coords.bottom;
      console.log(coords.top);
      console.log(popupArrowWidth);
      var w = coords.left + elem.offsetWidth + popupArrowWidth;

      var x = window.pageXOffset + w + "px";
      var y = window.pageYOffset + h + "px";


      note.style.left = x;
      note.style.top = y;
    }
    
    