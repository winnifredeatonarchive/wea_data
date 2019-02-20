/*  Javascript for the Documentation */

/* 
  * Add an event listener for the onload event so that we can call the 
  * initStatic function
  */
if (window.addEventListener) window.addEventListener('load', init, false)
else if (window.attachEvent) window.attachEvent('onload', init);

function init(){
    addSearch();
}

function addSearch(){
     var srch = document.querySelectorAll('input[type=search]');
     alert(srch);
     srch.forEach(function(s){
                s.addEventListener('keydown',watchSearch)
           });
}

function watchSearch(e){
    alert('hello!');
    if (e.key === 'Enter'){
        console.log('Entered!');
        searcher.search(this.value);
 }
}