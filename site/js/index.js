/* THis is a special javascript library jsut for the index page */
    var hash = window.location.hash.substring(1);
    var featuredItemRegex = new RegExp("index_featuredItems_\\d+");
    let currFI;
    let arrows = {};
 /*  
   class FeaturedItems{
       constructor(){
           this.wrapper = document.getElementById('index_featuredItemsWrapper');
           this.navLinks = this.wrapper.querySelectorAll('#index_featuredItems > a');
           this.list = this.wrapper.querySelector('ul');
           this.items = this.navLinks.map(link => link.id);
           this.len = this.items.length;
       }
       
       set prev(item){
           i
           
       }
       
       set _curr(id){
           this.clear();
           this.idx = this.items.indexOf(id);
           this.prev = this.list[idx - 1] || null;
           this.curr = this.list[idx];
           this.next = this.list[idx + 1] || null;
           this.clear();
           this.goToFeaturedItem();
       }
       
       init(){
          this.makeArrows();
          this.makeLinks();
       }
       
       clear(){
          this.curr.classList.remove('selected'); 
       }
       
       goToFeaturedItem(){
          this.curr.classList.add('selected');
       }
       
       makeArrows(){
           
       }
       
        makeLinks(){
            let self = this;
            this.navLinks.forEach(link => {
               link.addEventListener('click', e => {
                   e.preventDefault();
                   this._curr = link.id;
               });
           });
       }
   }
    */

    makeFeaturedItemsLinks();

function makeFeaturedItemsLinks(){


    var fILinks = document.querySelectorAll('#index_featuredItems > a');
        buildArrows();
    /* If we have a hash link, make sure we do this properly */
    if (featuredItemRegex.test(hash)){
        clearSelectedItems();
        currFI = document.getElementById(hash);
        select();
        document.getElementById('index_featuredItemsWrapper').scrollIntoView();
    } else {
        currFI = fILinks[0];
        select();
    }
    fILinks.forEach(function(f){
        f.addEventListener('click',goToFeaturedItem);
    });

}

function buildArrows(){
   let list = document.querySelector('#index_featuredItems > ul');
   let arrowData = [["prev", "chevron_left"], ["next", "chevron_right"]];
   let btns = arrowData.map(data => {
        let [type, text] = data;
        let str = `<button class="mi next_prev ${type}">${text}</button>`;
        list.insertAdjacentHTML('beforebegin', str);
        let elem = list.parentElement.querySelector(`.${type}`);
        arrows[type] = elem;
        elem.addEventListener('click', e=> {
           let goToEl = type == 'prev' ? currFI.previousElementSibling : currFI.nextElementSibling;
           if (!exists(goToEl)){
               return;
           }
               currFI = goToEl;
               select();
   });
})
}

function exists(el){
   return el && el.localName == 'a';
}
/*  This is a simple function that simply adds a class
 * to a anchor, which then triggers the CSS for translating 
 * left and right in the featuredItems carousel. */
function goToFeaturedItem(){
    var e = arguments[0];
    e.preventDefault();
    currFI = this;
    select();
}

function select(){
    clearSelectedItems();
    currFI.classList.add('selected');     
    arrows['prev'].disabled = !exists(currFI.previousElementSibling);
    arrows['next'].disabled = !exists(currFI.nextElementSibling);
}


function clearSelectedItems(){
      var selected = document.getElementById('index_featuredItems').getElementsByClassName('selected');
    for (var i=0; i < selected.length; i++){
        selected[i].classList.remove('selected');
    }
}