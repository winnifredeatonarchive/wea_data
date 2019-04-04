/*  Javascript for the Documentation */


/* 
  * Add an event listener for the onload event so that we can call the 
  * initStatic function
  */
if (window.addEventListener) window.addEventListener('load', init, false)
else if (window.attachEvent) window.attachEvent('onload', init);


function init(){
    addDocType();
 }

function addDocType(){
    document.getElementsByTagName('body')[0].classList.add('JS');
}
function addEvents(){
    var listHeads = document.querySelectorAll('.collapse > span, .collapse > a');
    listHeads.forEach(function(l){
        l.addEventListener('click', showHide,true)
    });
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
    
    