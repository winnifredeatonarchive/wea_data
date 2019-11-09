/*  A small codebase for enhancing static search for WEA */



window.addEventListener('load',enhanceStaticSearch(),true);

function enhanceStaticSearch(){
    makeItemsResponsive();
    makeFieldsetsCollapsible();
    document.getElementById('doSearch').addEventListener('click', hideFields, true);
}

function makeItemsResponsive(){
    var items = document.querySelectorAll("input[type='checkbox']");
    items.forEach(function(item){
        item.addEventListener('change', toggleClass, true);
    });
}

function hideFields(){
    var canClose = document.querySelectorAll("fieldset:not(.hasSelection)");
    for (c=0; c < canClose; c++){
        canClose[c].classList.remove('open');
        canClose[c].classList.add('closed');
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