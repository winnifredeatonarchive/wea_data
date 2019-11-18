/*  A small codebase for enhancing static search for WEA */



window.addEventListener('load',enhanceStaticSearch,true);



function enhanceStaticSearch(){
    makeItemsResponsive();
    makeFieldsetsCollapsible();
    var searchButton = document.getElementById('ssDoSearch');
    searchButton.addEventListener('click', hideFields, true);
    searchButton.addEventListener('click', checkIfDocOnly, true);
    document.getElementById('ssClear').addEventListener('click',clearSelections,true);
}

function makeItemsResponsive(){
    var items = document.querySelectorAll("input[type='checkbox']");
    items.forEach(function(item){
        item.addEventListener('change', toggleClass, true);
    });
}

function clearSelections(){
    var selectedFieldsets = document.querySelectorAll(".hasSelection");
    var selections = document.querySelectorAll('li.checked');
    for (var i = 0; i < selections.length; i++){
        selections[i].classList.remove('checked');
    }
    for (var j =0; j < selectedFieldsets.length; j++){
        selectedFieldsets[j].classList.remove('hasSelection');
    }
}

function checkIfDocOnly(){ 
    var query = document.getElementById('ssQuery');
    var mainDiv = document.getElementById('staticSearch');
    mainDiv.classList.remove('docOnly');
    if (query.value == "" || query.value == null){
        mainDiv.classList.add('docOnly');
    }
}

function hideFields(){
    var fieldsets = document.querySelectorAll("fieldset");
    for (c=0; c < fieldsets.length; c++){
        var currF = fieldsets[c];
        if (currF.classList.contains('hasSelection')){
            currF.classList.remove('closed');
            currF.classList.add('open');
        } else {
            currF.classList.remove('open');
            currF.classList.add('closed');
        }
    }
}

function makeFieldsetsCollapsible(){
    var legends = document.querySelectorAll("legend");
    legends.forEach(function(l){
        l.addEventListener('click', showHide, true);
    });
}

function toggleClass(){
  
    if (this.checked){
        this.parentNode.classList.add('checked');
    } else {
        this.parentNode.classList.remove('checked');
    }
    
    /* And now make the fieldsets collapsible if they can be during the search (NOT YET IMPLEMENTED,
     * BUT MIGHT BE LATER */
     
     var parentFieldset = this.closest('fieldset');
     var theseChecks = parentFieldset.querySelectorAll(".checked");
     /* TO DO: Fix these for input dates etc */
     if (theseChecks.length !== 0){
         parentFieldset.classList.add('hasSelection');
     } else {
         parentFieldset.classList.remove('hasSelection');
     }
}



function showHide(){
    var par = this.parentNode;
    if (par.classList.contains('closed')){
        par.classList.remove('closed');
        par.classList.add('open');
    } else if (par.classList.contains('open')){
        par.classList.remove('open');
        par.classList.add('closed');
    } else {
        par.classList.add('closed');
    }
    
}