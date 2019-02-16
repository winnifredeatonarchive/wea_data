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
    var elList=document.getElementById('element_list');
    elList.classList.add('closed');
    var header = elList.getElementsByTagName('h3')[0];
    console.log(header);
    header.addEventListener('click',showHide);
   
}

    function showHide(){
        alert('CLICKING');
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
    
    