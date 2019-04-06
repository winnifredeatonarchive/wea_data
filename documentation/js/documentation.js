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
    makeTocCollapse();
    scrollIntoView();
 }


function makeTocCollapse(){
    var toggles = document.querySelectorAll('.toggle');
    toggles.forEach(function(t){
        t.addEventListener('click', showHide, true);
    });
}

function addDocType(){
    document.getElementsByTagName('body')[0].classList.add('JS');
}

function scrollIntoView(){
    var docId = document.getElementsByTagName('html')[0].id;
    console.log(docId);
    var thisLink = docId + '.html';
    var navLink = document.querySelectorAll("nav span.selected")[0];
    console.log(navLink);
    var navLi = navLink.parentNode;
    var oneBefore = navLi.previousElementSibling;
    var twoBefore = oneBefore.previousElementSibling;
    var threeBefore = twoBefore.previousElementSibling;
    if (threeBefore){
        scrollLink = threeBefore;
    } else {
        scrollLink = navLink;
    }
    
    scrollParentToChild(document.getElementsByTagName('nav')[0],scrollLink);
}

/* Taken, with thanks, from: https://stackoverflow.com/questions/45408920/plain-javascript-scrollintoview-inside-div#answer-45411081 */
function scrollParentToChild(parent, child) {

  // Where is the parent on page
  var parentRect = parent.getBoundingClientRect();
  // What can you see?
  var parentViewableArea = {
    height: parent.clientHeight,
    width: parent.clientWidth
  };

  // Where is the child
  var childRect = child.getBoundingClientRect();
  // Is the child viewable?
  var isViewable = (childRect.top >= parentRect.top) && (childRect.top <= parentRect.top + parentViewableArea.height);

  // if you can't see the child try to scroll parent
  if (!isViewable) {
    // scroll by offset relative to parent
    
    /* Modified slightly by JT to divide by 1.5, which makes the thing scroll into about the
     * middle, which is better for context. */
    parent.scrollTop = (childRect.top + parent.scrollTop) - parentRect.top;
  }


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
    document.getElementById('popup').style = '';
    document.getElementById('popup').classList.add('hidden');
}
function showSpec(){
    var thisHref = this.getAttribute('href');
    var thisSpec = thisHref.substring(0, thisHref.length-5);
    var popup = document.getElementById('popup');
    var thisContent = document.getElementById('snippet_' + thisSpec).innerHTML;
    document.getElementById('popup_content').innerHTML = thisContent;
    popup.classList.remove('hidden');
    popup.classList.add('showing');
    placeNote(this, popup);



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

/* Have to deal with left and right first */
      var coords = elem.getBoundingClientRect();
      var popupArrowBorderWidth = window.getComputedStyle(note, 'before').getPropertyValue('border-width');
      var defaultValue = 7;
      var popupArrowWidth = parseInt(popupArrowBorderWidth,10);
      if (isNaN(popupArrowWidth)){
          console.log('WARNING: popupArrowWidth NAN; setting default value of ' + defaultValue);
          popupArrowWidth = defaultValue;
      }
      var middle = (coords.top + coords.bottom)/2;
      var w = coords.left + elem.offsetWidth + popupArrowWidth;
      var x = window.pageXOffset + w + "px";
      note.style.left = x;
      /* Now height */
      var popupHeight = note.offsetHeight;
      var h = middle - popupHeight/2;

      var y =  window.pageYOffset + h + "px";
      note.style.top = y;
    }
    
    