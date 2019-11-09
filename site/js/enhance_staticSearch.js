/*  A small codebase for enhancing static search for WEA */



window.addEventListener('load',enhanceStaticSearch(),true);

function enhanceStaticSearch(){
    makeItemsResponsive();
}

function makeItemsResponsive(){
    var items = document.querySelectorAll("input[type='checkbox']");
    items.forEach(function(i){
        i.addEventListener('change',toggleClass, true);
        });
}

function toggleClass(){
    if (this.checked){
        this.parentNode.classList.add('checked');
    } else {
        this.parentNode.classList.remove('checked');
    }
}