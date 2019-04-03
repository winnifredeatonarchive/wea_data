/*  Javascript for the Documentation */


/* 
  * Add an event listener for the onload event so that we can call the 
  * initStatic function
  */
if (window.addEventListener) window.addEventListener('load', init, false)
else if (window.attachEvent) window.attachEvent('onload', init);


 function init(){
     addEvents();
 }


function addEvents(){
    var tocs=document.querySelectorAll('div.toc.closed, div.toc.open');
    console.log(tocs);
    tocs.forEach(function(t){
            var header = t.getElementsByTagName('h3')[0];
               header.addEventListener('click',showHide)
           });
}

    function showHide(){
        var parent = this.parentNode;
        console.log(parent);
        if (parent.classList.contains('open')){
            parent.classList.remove('open');
            parent.classList.add('closed');
        } else if (parent.classList.contains('closed')){
            parent.classList.remove('closed');
            parent.classList.add('open');
        }
    }
    
    