/* THis is a special javascript library jsut for the index page */
    var hash = window.location.hash.substring(1);
    var featuredItemRegex =  new RegExp ("index_featuredItems_\\d+");

function initIndex(){
    makeFeaturedItemsLinks();
}

function makeFeaturedItemsLinks(){


    var fILinks = document.querySelectorAll('#index_featuredItems > a');
    /* If we have a hash link, make sure we do this properly */
    if (featuredItemRegex.test(hash)){
        clearSelectedItems();
        document.getElementById(hash).classList.add('selected');
        document.getElementById('index_featuredItemsWrapper').scrollIntoView();
    }
    fILinks.forEach(function(f){
        f.addEventListener('click',goToFeaturedItem);
    });
}

/*  This is a simple function that simply adds a class
 * to a anchor, which then triggers the CSS for translating 
 * left and right in the featuredItems carousel. */
function goToFeaturedItem(){
    var e = arguments[0];
    e.preventDefault();
    clearSelectedItems();
    this.classList.add('selected');
}

function clearSelectedItems(){
      var selected = document.getElementById('index_featuredItems').getElementsByClassName('selected');
    for (var i=0; i < selected.length; i++){
        selected[i].classList.remove('selected');
    }
}