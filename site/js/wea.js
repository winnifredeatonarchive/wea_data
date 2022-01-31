/*  Javascript for the Documentation */

/* 
  * Add an event listener for the onload event so that we can call the 
  * initStatic function
  */
window.addEventListener('DOMContentLoaded', init, false);


/* 
 * Add method to HTML element to toggle aria roles
 * 
 */
 
 HTMLElement.prototype.removeAria = function(name){
       let att = 'aria-' + name;
       if (!this.hasAttribute(att)){
           return;
       }
       this.removeAttribute(att);
 }
 
 HTMLElement.prototype.setAria = function(name, value){
     this.setAttribute('aria-' + name, value);
 }
 
var docId = document.getElementsByTagName('html')[0].getAttribute('id');

class Accordion {
    constructor(el) {
        try{
            // Store the <details> element
            this.el = el;

            // Store the <summary> element
            this.summary = el.querySelector('summary');

            // Store the <div class="content"> element
            this.content = el.querySelector('.content') || this.makeContent();

            // Store the animation object (so we can cancel it if needed)
            this.animation = null;

            //It's not doing anything at the moment.
            this.state = [0];

            // Create configuration for easing function;
            this.easing = this.getCustomProp('easing', 'ease-in-out');

            // Create an option for timing
            this.duration = this.convertDuration(this.getCustomProp('duration', '400').trim());

            // Make the heights
            this.startHeight = null;
            this.endHeight = null;

            // Now init the actual element stuff
            this.init();

        } catch(e){
            console.log(`${e}`);
        }
    }

    init() {
        // Set the aria role
        this.el.setAttribute('aria-expanded', this.el.open);
        // Add a class to the element
        this.el.classList.add('accordion');
        // Detect user clicks on the summary element
        this.summary.addEventListener('click', (e) => this.onClick(e));
    }

    // Function to get custom properties
    // so to align any duration/easing stuff in the CSS
    // This can be overridden by the object declaration, however
    getCustomProp(prop, defaultVal) {
        //Get the actual declaration;
        let propDecl = `--accordion-${prop}`;
        //Get the computed style
        let style = getComputedStyle(this.el);
        //Get the property value
        let propVal = style.getPropertyValue(propDecl);
        return (propVal) ? propVal : defaultVal;
    }

    // Create the click listener
    onClick(e) {
        // Stop default behaviour from the browser
        e.preventDefault();

        // Add an overflow on the <details> to avoid content overflowing
        this.el.style.overflow = 'hidden';

        //Prevent any further clicking from happening
        this.el.style.pointerEvents = 'none';

        // Check if the element is being closed or is already closed
        if (!this.el.open) {
            this.open();
            // Check if the element is being opened or is already open
        } else {
            this.close();
        }
    }

    makeContent() {
        let nodes = [...this.el.childNodes].filter(n => !n.isSameNode(this.summary));
        let div = document.createElement('div');
        div.classList.add('accordion__content');
        nodes.forEach(node => div.appendChild(node));
        this.el.appendChild(div);
        return div;
    }

    open() {
        // Apply a fixed height on the element
        this.el.style.height = `${this.el.offsetHeight}px`;
        // Force the [open] attribute on the details element
        this.el.open = true;
        // Wait for the next frame to call the expand function
        window.requestAnimationFrame(() => this.expand());
    }

    close() {
        //Add the aria label
        window.requestAnimationFrame(() => this.shrink());
    }

    expand() {
        // Set the element as "being expanding"
        this.state.push(1);
        // Get the current fixed height of the element
        this.startHeight = `${this.el.offsetHeight}px`;
        // Calculate the open height of the element (summary height + content height)
        this.endHeight = `${this.summary.offsetHeight + this.content.offsetHeight}px`;
        this.el.setAttribute('aria-expanded', 'true');
        //Now animate
        this.animate();
    }

    shrink() {
        // Set the element as "being closed"
        this.state.push(-1);
        // Store the current height of the element
        this.startHeight = `${this.el.offsetHeight}px`;
        // Calculate the height of the summary
        this.endHeight = `${this.summary.offsetHeight}px`;
        this.el.setAttribute('aria-expanded', 'false');
        this.animate();
    }

    animate() {
        // If there is already an animation running
        if (this.animation) {
            // Cancel the current animation
            this.animation.cancel();
        }

        // Start a WAAPI animation
        this.animation = this.el.animate({
            // Set the keyframes from the startHeight to endHeight
            height: [this.startHeight, this.endHeight]
        }, {
            duration: this.duration,
            easing: this.easing
        });

        // When the animation is complete, call onAnimationFinish()
        this.animation.onfinish = () => this.onAnimationFinish();
        // If the animation is cancelled, isExpanding variable is set to false
        this.animation.oncancel = () => this.state.slice(0, 1);
    }

    onAnimationFinish() {
        // Set the open attribute based on the parameter
        this.el.open = this.state[1] > 0;
        // Clear the stored animation
        this.animation = null;
        // Reset state
        this.state = [0];
        this.startHeight = this.endHeight = null;
        // Remove the overflow hidden and the fixed height
        this.el.style.height = this.el.style.overflow = '';
        this.el.style.pointerEvents = 'auto';
    }

    convertDuration(dur) {
        if (/[\d]s$/g.test(dur)){
            return parseFloat(dur) * 1000;
        } else {
            parseInt(dur, 10);
        }
    }
}



function init(){
    addDocClass();
    addEvents();
    //makeNavbarFocusable();
    if (document.querySelectorAll('img.lazy')){
        lazyload();
    }
    let searchStr = window.location.search;
    let params = new URLSearchParams(searchStr)
    if (params.has('tsCol')){
        let cn = params.get('tsCol');
        let asc = params.get('asc');
        let thead = document.querySelectorAll('thead')[0];
        let th = thead.querySelectorAll('th');
        let thToClick = th[ (cn * 1) - 1];
        if (asc == 'false'){
            thToClick.classList.add('up');
        } else {
            thToClick.classList.remove('up');
            thToClick.classList.add('down');
        }
        
        thToClick.click();
        
    }
   
/*    makeAsideResponsive();*/


}


/* 
    function makeNavbarFocusable(){
        document.querySelectorAll("#menu_main > li[data-el='item']:not([id])")
            .forEach(item => {
               item.setAttribute('tabindex', 0) 
            })
}
*/

function lazyload(){
    var imgs = document.querySelectorAll('#text img.lazy:not([data-src])');
    imgs.forEach(function(img){
        var src = img.src;
        img.setAttribute('data-src',src);
        img.setAttribute('src', 'images/cooking.png');
    });

    var lazyLoadInstance = new LazyLoad({
    elements_selector: "img.lazy[data-src]"
});
}


function addEvents(){

    addHeaderSearch();
    addHeaderSearchSubmit();
    addPopupClose();
    makeFootnotesResponsive();
    makeNamesResponsive(document.querySelector('body'));
    makeCitationsResponsive();
    makeNavClickable();
    showHideTitles();
    makeBarsExpandable();
    if (document.querySelectorAll('table')){
        makeTablesSortable();
    }
    if (document.getElementById('tools')){
        makeToolbarResponsive();
    }
    if (docId == 'index'){
        initIndex();
    }
    
    if (docId === 'resources'){
        addBiblSort();
    }
}


function addBiblSort(){
    const listBibl = document.querySelector("#text [data-el='listBibl']");
    let bibls = listBibl.querySelectorAll('.bibl');
    bibls.forEach((bibl, i) => {
            bibl.setAttribute('data-alpha', i)
        }
    )
    let sortOptions = [['alpha', 'Author', 'A', 'Z'], ['chrono','Date', 'Earliest', 'Latest']];
    let label = `<label for="sort">Sort</label>`;
    let select = document.createElement('select');
    select.setAttribute('name','sort'); 
    listBibl.insertAdjacentHTML('beforeBegin', label);
    listBibl.insertAdjacentElement('beforeBegin', select);
    sortOptions.forEach(option => {
        ['','-r'].forEach(param => {
            let suffArr = option.slice(2);
            if (param === '-r')  suffArr.reverse();
            let suffix  = '(' + suffArr.join('-') + ')'
            let optEl = `<option value="${option[0]}${param}">${option[1]} ${suffix}</option>`;
            select.insertAdjacentHTML('beforeEnd', optEl);
        });
    });
   select.addEventListener('change', e => {
      let opt = select.options[select.selectedIndex].value;
      let tokens = opt.split('-');
      console.log(tokens);
      let getVal = function(el){
         return parseFloat(el.getAttribute('data-' + tokens[0]));
      }
      let sorted = Array.from(bibls).sort((a,b) =>{
          console.log(getVal(a));
          console.log(getVal(b));
            return getVal(a) - getVal(b)

      });
      if (tokens.length > 1){
          console.log('reverse it');
          sorted = sorted.reverse();
      }
      listBibl.setAttribute('data-order', tokens[0]);
      sorted.forEach(bibl => listBibl.appendChild(bibl))
   });
}

function addHeaderSearchSubmit(){
    
    var searchBtn = document.getElementById('nav_search_button');
    console.log(searchBtn);
    searchBtn.addEventListener('click', submitSearch, true);
}




function makeNavClickable(){
    var nav_toggle = document.getElementById('nav_toggle');
    nav_toggle.addEventListener('click', toggleNav, true);
    var navCloser = document.getElementById('nav_closer');
    navCloser.addEventListener('click', toggleNav, true);
    var overlayCloser = document.getElementById('header_overlay');
    overlayCloser.addEventListener('click',toggleOverlay,true);
}
 
 
 
 function toggleOverlay(){
       var e=arguments[0];
      /* Get rid of the #href functionality */
     e.preventDefault();
     var facsViewer = document.getElementById('facsViewerContainer');
     let popup = document.getElementById('popup');
     if (facsViewer && facsViewer.classList.contains('open')){ 
            document.getElementById('facs_closer').click();
     } else if (popup && popup.classList.contains('showing')){ 
            document.getElementById('popup_closer').click();
     } else {
         document.getElementById('nav_closer').click();
     }
     
 }
 
function toggleNav(e){
      e.preventDefault();
      toggleOpenClose(document.getElementById('menu_main'), true);
      document.getElementsByTagName('body')[0].classList.toggle("overlay");
}    




function makeTablesSortable(){
    var th = document.querySelectorAll('th.sortable');
    th.forEach(function(t){
        t.addEventListener('click', sortTable, true)
    });
}



/* This is a fairly crude table sorting function that relies on the 
 * fact that our tables already have their sort key in place. Since each cell in a table
 * gets its own respective sort integer (i.e. where it fits in a sequence), the sorting
 * is trivial on the JS side. */
 
function sortTable(){
    /* this coliumn number */
    var cn = this.getAttribute('data-col');
    
    /* The table (we assume no nested tables) */
    var table = this.parentNode.parentNode.parentNode;
    
    /* The body of the table (there should be only 1) */
    var tbody = table.getElementsByTagName('tbody')[0];
    
    /* All of the already selected elements */
    var selected = table.getElementsByClassName('selected');
    
    /* Now iterate over the selected elements */
    
    for (var s=0; s < selected.length; s++){
    /* And so long as the selected element isn't this, then get rid of everything */
        if (!(selected[s] === this)){
           selected[s].classList.remove('up');
           selected[s].classList.remove('down');
           selected[s].classList.remove('selected');
        }
    }
    
    /* If it hasn't been selected yet, then select it. */
    if (!this.classList.contains('selected')){
        this.classList.add('selected');
     }
     
     /* Determine whether we should short ascending or descending */
    var alreadyAsc = this.classList.contains('up');
    var alreadyDesc = this.classList.contains('down');
    var asc;
    /* If it's neither up or down, then it should be sorted ascending */
    if (alreadyAsc) {
        asc = false;
    } else {
        asc = true;
    }
    
    /* UP means its sorting ascending; down descending */
    if (asc){
        this.classList.remove('down');
        this.classList.add('up');
    } else {
        this.classList.remove('up');
        this.classList.add('down');
    }
    /* Get all the rows in the body of the table */
    var rows = tbody.querySelectorAll('tr');
    
    /* Create an array from the rows */
    var rowArray = Array.from(rows);
    
    /* Now sort it by comparing the column with the row  */
    rowArray.sort(function(a,b){
       return a.getElementsByTagName('td')[cn-1].getAttribute('data-sort') - b.getElementsByTagName('td')[cn-1].getAttribute('data-sort')
       });
       
   /* Now figure out how to iterate */
   
   if (asc){
     for (var i=0; i<rows.length; i++){
        tbody.appendChild(rowArray[i]);
     }
   } else {
       for (var i=rows.length -1; i>-1; i--){
           tbody.appendChild(rowArray[i]);
       }
   }
   
   /* Reset the URLs */
   console.log(window.location.pathname);
     let newUrl = window.location.pathname + "?tsCol=" + cn + "&asc=" + asc;
    history.replaceState({},document.title, newUrl);
    }
    


function addHeaderSearch(){

     var headerInput = document.getElementById('nav_search_input');
     headerInput.addEventListener('click',makeHeaderTypeahead);
     headerInput.addEventListener('focus',makeHeaderTypeahead);
}


         let typeaheadMade = false;
         let typeahead_going = false;
     function makeHeaderTypeahead(){
      if (!typeaheadMade){
                    let navSearch = document.querySelector('#nav_search');
                   let headerInput = this;
            fetch('ajax/sitemap.html')
         .then(function(file){
              return file.text();
         })
         .then(function(doc){
              /*  And put the stuff in a nonce div and pass the inner HTML to it*/
                        var nonce = document.createElement('div');
                        nonce.innerHTML = doc;
                        let divs = nonce.querySelectorAll('section > div');
                        let sitemap = document.querySelector('#siteMap');
                        divs.forEach(function(div){
                            siteMap.appendChild(div);
                        });
                        headerInput.addEventListener('input',titleSearch);
                        var results = document.querySelectorAll('#siteMap .item');
                        headerInput.addEventListener('keydown',submitSearch);
                        typeaheadMade = true;
           });  
      }
   }
     
     
function submitSearch(){
    var e=arguments[0];
    typeahead_going = true;
    var searchInput = document.getElementById('nav_search_input');
    if (this.tagName == 'A' || e.key == 'Enter' || this.tagName == 'BUTTON'){
        if (this.tagName == 'A'){
            e.preventDefault();
        }
        var href = "search.html";
        if (!(searchInput.value === "")){
            href = "search.html?q=" + encodeURIComponent(searchInput.value);
        }
        window.location.href = href;
    }
}

function removeOtherOpenNavs(){
    var openNavs = document.querySelectorAll('header .open');
    for (var i=0; i < openNavs.length; i++){
        toggleOpenClose(openNavs[i]);
    }
     clearTitleSearchResults();
    document.getElementsByTagName('header')[0].classList.remove('closed');
    document.getElementsByTagName('header')[0].classList.remove('open');
    document.getElementsByTagName('header')[0].classList.add('closed');
}


    

function toggleOpenClose(el, removeAllNavs){
    if (el.classList.contains('open')){
        el.classList.remove('open');
        el.classList.add('closed');
        if (el.id == 'headerSearch'){
            clearTitleSearchResults();
        }
    } else if (el.classList.contains('closed')){
        el.classList.remove('closed');
        if (removeAllNavs){
        removeOtherOpenNavs();
        }
        el.classList.add('open');
    } else if (el.getAttribute('id') == 'nav_main') {
        el.classList.add('open');
    } else {
        el.classList.add('closed');
    }
}

/* This will certainly need to be finessed quite a bit;
 * we'll maybe want to do some better investigation, probably by individual token
 * and we might need a way to expand the search results or to shove you over to the
 * main search page. */
function titleSearch(){
    var siteMap = document.getElementById('siteMap');
    clearTitleSearchResults();
    var inputValue = this.value;
    
    /* Quick check to see if there's content
     * in the search field */
    if (inputValue.length > 0){
        siteMap.classList.add('showing');
    } else if (siteMap.classList.contains('showing')) {
        siteMap.classList.remove('showing');
    }
    
    inputValue = inputValue.replace("'","’");
    console.log(inputValue);
    
    /* IF the string matches, then proceed */
    if (/\S/.test(inputValue)){
        var regex = new RegExp(inputValue,'i');
        var items = siteMap.querySelectorAll('.item');
        var s = 0;
        var match = 0;
        var basicInput = document.getElementById('siteMap_input');
        basicInput.classList.add('item');
        basicInput.classList.add('showing');
        //basicInput.setAttribute('tabindex', 0);
        var searchLink = document.getElementById('siteMap_input_link');
        var searchString = "search.html?q=" + encodeURIComponent(inputValue);
        searchLink.setAttribute('href',searchString);
        var searchInputFill = document.getElementById('siteMap_input_fill');
        searchInputFill.innerHTML = inputValue;
  /*  if (items.length > 0){
        document.getElementById('siteMap').classList.add('hasResults');
    }*/
    
            for (s; s < items.length; s++){
                var currItem = items[s];

                if (currItem.getElementsByTagName('a')[0].innerText.match(regex) !== null){
                    if (match < 5){
                        currItem.classList.add('showing');
                        //currItem.setAttribute('tabindex',0);
                        var parent = currItem.parentNode;
                        if (!parent.classList.contains('showing')){
                            parent.classList.add('showing');
                        } 
                    }
                match++; 
             }

        }
    }
 }
    
    


function clearTitleSearchResults(){
    var results = document.querySelectorAll('#nav_search .showing');
    for (r=0; r < results.length; r++){
        results[r].classList.remove('showing');
        //results[r].removeAttribute('tabindex');
    }
   /* document.getElementById('siteMap').classList.remove('hasResults');*/
}



function makeBarsExpandable(){
    let accordions = [...document.querySelectorAll('details')].map(dtl => {
        return new Accordion(dtl);
    });
    
    //var expandDiv = document.querySelectorAll('.expandable');
    //expandDiv.forEach(function(e){
      //  e.firstElementChild.addEventListener('click', openCloseAI, true);
    //});
}

function openCloseAI(){
    var div = this.parentNode;
    toggleOpenClose(div);
        
}

function showHideTitles(){
    var spansToShow = document.querySelectorAll('.showTitle');
    spansToShow.forEach(function(n){
        n.addEventListener('click', showPopup, true);
        n.classList.add('popup');
    });
}

function makeFootnotesResponsive(){
    var noteMarkers = document.querySelectorAll('a.noteMarker');
    noteMarkers.forEach(function(n){
        n.addEventListener('click',showPopup,true);
    });
}

function makeToolbarResponsive(){
    var toolbarItems = document.querySelectorAll('.toolbar_item');
    toolbarItems.forEach(function(t){
        if (t.parentElement.id === 'tools_pagebreaks'){
            t.addEventListener('click', togglePagebreaks, true);
        }
        if (t.getAttribute('href').startsWith('#')){
            t.addEventListener('click', showPopup, true);
        } 
    });
}

function togglePagebreaks(){
    arguments[0].preventDefault();

    document.querySelector('#text').classList.toggle('no-pb');
}

function makeNamesResponsive(el){
    var names = el.querySelectorAll('a[data-el=name]');
    names.forEach(function(n){
        if (/^https?:/gi.test(n.getAttribute('href'))){
            return;
        }
        n.addEventListener('click', showPopup, true);
        n.classList.add('popup');
    });
}



function makeCitationsResponsive(){
    var citations = document.querySelectorAll("a[data-el='ref'][data-type='bibl']");
    citations.forEach(function(c){
        c.addEventListener('click', showPopup, true);
        c.classList.add('popup');
    });
}

 /** 
   * Makes the specified popups (which can be a list of ids) popup
   * The list of ids must be space separated (id1 id2 etc)
   * author: jtakeda 
   */
  function showPopup(){
                 /* Close the existing popup, if necessary */
      /* Cross browser solution for event handling from https://stackoverflow.com/questions/9636400/event-equivalent-in-firefox#answer-15164880 */
      var e=arguments[0];
      var el = this;
      /* Stop the onclick from bubbling */
      e.stopPropagation();
      /* And prevent default action for links with @href */
      e.preventDefault();
      /* Declare empty var */
      var useTitle = false;
      var removeEvent = false;
      let personography = document.querySelector('#personography');
      var id = '';
      
      let render = () => {
        if (content == ''){
          var dummyDiv = document.createElement('div');
          dummyDiv.setAttribute('class','para');
          dummyDiv.innerHTML = 'This popup is not available.';
          content = dummyDiv;
        }
        console.log(typeof content);
        popupContent.appendChild(content);
        makeNamesResponsive(content);
        if (!(useTitle)){
              popup.setAttribute('data-showing',id);
        }
        //And set the display to block
        popup.classList.remove('hidden');
        popup.setAria('hidden', 'true');
        popup.classList.add('showing');
        popup.setAria('hidden','false');
        this.classList.add('clicked');
      }
      
      
      /* If this is an annotation and the annotation button is checked */
      /* Sometimes the annotation/collation buttons aren't there (if, for instance, there are no collations in the document)
       * and we have to have a switch for that */
      var place;
            var popup = document.getElementById('popup');
      if (this.classList.contains('noteMarker')){
          id = this.getAttribute('href').substring(1);
      } else if (this.classList.contains('toolbar_item')){
          id = this.getAttribute('href').substring(1);
          popup.classList.add('toolbar');
      }
     /* Else if this is a name element and it has an @href that is a local pointer */
      else if (this.getAttribute('data-el') == 'name' && this.getAttribute('href').startsWith('#')){
          id=this.getAttribute('href').substring(1);
      } else if (this.getAttribute('data-el') == 'ref' && this.getAttribute('data-type') == 'bibl' && this.getAttribute('href').startsWith('#')){
          id=this.getAttribute('href').substring(1);
      }
      else if (this.getAttribute('data-el') == 'org' && this.getAttribute('href').startsWith('#')){
          id = this.getAttribute('href').substring(1);
      } else if ((this.getAttribute('data-el') == 'org' || this.getAttribute('data-el') == 'name') && this.getAttribute('data-ref').startsWith('#')){
         id = this.getAttribute('data-ref').substring(1)
      }
      
      else if (this.getAttribute('title') && !(this.getAttribute('href'))){
          useTitle = true;
      }
      /* Otherwise, return */
      else{
          console.log ('ERROR: This element does not have a popup; removing the click event');
          removeEvent = true;
      }
     
      

      var popupContent = document.getElementById('popup_content');
      var showing = popup.getAttribute('data-showing');

          
      if (popup.classList.contains('showing')){
          closePopup();
          console.log('I should close...'); 
       }
      var content;
            if (useTitle){
          var dummyDiv = document.createElement('div');
          let header = document.createElement('h4');
          let para = document.createElement('div');
          para.setAttribute('class','para');
          para.setAttribute('data-el','p');
          header.innerHTML = "Textual Note";
          dummyDiv.appendChild(header);
          dummyDiv.appendChild(para);
          para.innerHTML = this.getAttribute('title');
          content = dummyDiv;
          popup.classList.add('textual-note');
      } else if (this.classList.contains('noteMarker') && !(id == '')){
           var thisThing = document.getElementById(id);
           var clone = thisThing.cloneNode(true);
           var heading = document.createElement('h4');
           heading.innerHTML = "Editorial Note";
           clone.prepend(heading);
           popup.classList.add('editorial-note');
           content = clone;
      } else if (!(id == '') && this.classList.contains('toolbar_item')){
            let header = document.createElement('h4');
            let parId = this.parentNode.getAttribute('id');
            let headingText;
            if (parId === 'tools_cite'){
                headingText = 'Cite this Page';
            } else if (parId === 'tools_toc'){
                headingText = "Table of Contents"
            } else {
                headingText = this.querySelector('div.label').innerHTML;
            }
            header.innerHTML = headingText;
            let thisThing = document.getElementById(id);
            var clone = thisThing.cloneNode(true);
            clone.prepend(header);
            content = clone;
            
            
      } else if (!(id == '') && document.getElementById(id)){
          let thisThing = document.getElementById(id);
          let clone = thisThing.cloneNode(true);
          content = clone;
          
      } else{
            fetch('ajax/'+ id + '.html')
            .then(html => html.text())
            .then(result => {
                personography.insertAdjacentHTML('beforeEnd', result);
                content = personography.querySelector('#' + id).cloneNode(true);
                render();
                return;
            })
            .catch(e => {
                console.log("Couldn't find the popup: " + e.message);
                content = '';
            });
      } 
      
      document.getElementsByTagName('body')[0].classList.toggle("overlay");
      render();
   }
   
   

  var resizeTimeout;
  var windowResize;

  function resize(el, popup, ev) {
    closePopup();
    // ignore resize events as long as an actualResizeHandler execution is in the queue
   /* if ( !resizeTimeout ) {
      resizeTimeout = setTimeout(function() {
        resizeTimeout = null;
        placeNote(el, popup);
       }, 9);
    }*/
  }
  





function placeNote(elem, note) {

/* PSUEDOCODE:
 * 
 * 1) Need to get height and width of rendered thing
 * 2) Depending on what the preferred placement (vertical or horizontal), check to see whether it can fit on the preferred side (down, right)
 * 3) Go through the hierarchy of preferences
 * 4) If none of them work, just do the preferred one
 *  */
      params = new getParams(elem, note);
      var popupHeight = params.height;
      var popupWidth = params.width;
      var place = note.getAttribute('data-place');
      var placePos = params.placePos;
      togglePopupPlaces(note, placePos);
      var header = document.getElementsByTagName('header')[0];
      var headerHeight = parseInt(window.getComputedStyle(header).getPropertyValue('height'),10);
      console.log('Header Height' + headerHeight);
      var coords = elem.getBoundingClientRect();
      
      var popupArrowBorderWidth = window.getComputedStyle(note, 'after').getPropertyValue('border-width');
      var popupArrowBorderHeight = window.getComputedStyle(note, 'before').getPropertyValue('border-width');
      var defaultValue = 7;
      var popupArrowWidth = (parseInt(popupArrowBorderWidth,10) || 7);
      var popupArrowHeight = (parseInt(popupArrowBorderHeight,10) || 7);

      
      console.log(params.longNote);
      if (placePos.match('bottom')){
      
            var elemXMiddle = (coords.left + coords.right)/2;
            var elemBottom = coords.bottom;
            var notePlace = window.scrollY + coords.bottom + popupArrowHeight;
            console.log(notePlace);
            note.style.top = notePlace + "px";
            if (placePos == 'bottom_right'){
               note.style.left = coords.left + "px";
            } else {
                console.log(coords.left + elem.offsetWidth);
               note.style.left = Math.max(coords.right - popupWidth, 0) + elem.offsetWidth +  "px";
            }


          
      } else if (placePos == 'right'){
          var middle = (coords.top + coords.bottom)/2;
          var h = middle - popupHeight/2;
          var w = coords.left + elem.offsetWidth + popupArrowWidth;
          var x = window.pageXOffset + w + "px";
          var y = window.pageYOffset + h + "px";
          note.style.top = y;
          note.style.left = x;
      }
      
      
     
   
      
    }

function togglePopupPlaces(note, placePos){
    note.classList.remove('left', 'right', 'top', 'bottom_left','bottom_right', 'long');
    note.classList.add(placePos);
}
    
function getParams(elem, note){
      var bodyRight = document.getElementById('mainBody').getBoundingClientRect().right;
      var elemCoords = elem.getBoundingClientRect();
      var popupCoords = popup.getBoundingClientRect();
      var popupHeight = note.offsetHeight;
      var popupWidth = note.offsetWidth;
      var vpw = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
      var vph = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
      console.log('vpw: '+ vpw + "vph: " + vph);
      var availableRight = (vpw - elemCoords.right) * 0.9;
      var availableFromLeft = (vpw - elemCoords.left);
      var availableBottom = vph - elemCoords.bottom
      var availableTop = vph - elemCoords.top;
      console.log('availableRight' + availableRight);
      var defaultPlace = note.getAttribute('data-place');
      console.log(defaultPlace);
      if (defaultPlace == 'right'){
          if (availableRight > popupWidth){
              placePos = 'right';
          } else if (availableFromLeft > popupWidth){
              placePos = "bottom_right";
          } else {
              placePos = "bottom_left";
          }
      }
      
      this.height = popupHeight;
      this.width = popupWidth;
      this.placePos = placePos;
      this.longNote = availableTop > 0;
      
}


/* TO DO: Add function to scroll to the most recent div's pointer in the TOC in the popup */
/* And make the facsimile thing do the same */

/*  Taken from https://gomakethings.com/how-to-test-if-an-element-is-in-the-viewport-with-vanilla-javascript/ */
function inViewport (elem) {
    var bounding = elem.getBoundingClientRect();
    return (
        bounding.top >= 0 &&
        bounding.left >= 0 &&
        bounding.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
        bounding.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
};


function addDocClass(){
       /* Add classes to the body */
     var body = document.getElementsByTagName('body')[0];
     body.classList.add('JS');
     document.getElementsByTagName('header')[0].classList.add('closed');
     document.getElementById('menu_main').classList.add('closed');
       
}
function addSearch(){
     searcher = new mdh.LocalSearch('js/search/', 'searchResults');
     var searches = document.querySelectorAll('input[name=search]');
     console.log('Adding search functionality...');
     searches.forEach(function(s){
                s.addEventListener('keydown',initSearch)
           });
}

function initSearch(){
    var e=arguments[0];
    if (e.key === 'Enter'){
        console.log('Entered!');
        console.log('Searching for ' + this.value);
        searcher.search(this.value);
 }
}



function addPopupClose(){
    var closer = document.getElementById('popup_closer');
    closer.addEventListener('click', closePopup);
   
}


      /* Close popup */
      
function closePopup(){
    var popup = document.getElementById('popup');

    if (popup.classList.contains('showing')){
        console.log('Removing popup');
         popup.removeAttribute('style');
         popup.classList.remove('showing','top','bottom','left','right','textual-note','editorial-note');
         popup.classList.add('hidden');
         popup.removeAttribute('data-showing');
         var popupContent = document.getElementById('popup_content');
         while (popupContent.hasChildNodes()){
        popupContent.removeChild(popupContent.lastChild)
        }
    }
         var c = document.querySelectorAll('.clicked');
             for (var i =0; i <c.length; i++){
                  c[i].classList.remove('clicked');
                  }
   
   document.getElementsByTagName('body')[0].classList.toggle("overlay");
}


/* This function takes in a query string "?searchTokens" and returns the highlighted tokens */
function highlightSearchMatches(){
    var searchTokensString = searchParams.get('searchTokens');
    var tokens = searchTokensString.split('|');
    for (t=0; t < tokens.length; t++){
        var thisToken = tokens[t].trim();
        console.log(thisToken);
        var ulDir;
        if (thisToken.match(/^[A-Z]/g)){
            ulDir ='upper/';
        } else {
            ulDir='lower/';
        }
        var url = "staticSearch/" + ulDir + thisToken + ".json";
        console.log(url);
        fetch(url)
        .then(
            function(response){
                return response.json();
            }
        )
        .then(
            function(obj){
                console.log(obj);
                highlightTerms(obj);
            })
        .catch(function(err){
            console.log('NO GO');
        }
        )
}
        
    }
    
    
    
    function highlightTerms(obj){
        var body = document.getElementsByTagName('body')[0];
        console.log(obj);
        var instance;
        for (i=0; i < obj.instances.length; i++){
            thisInstanceId = obj.instances[i].docId;
            if (thisInstanceId == docId){
                instance = obj.instances[i]
            }
        }
       
       let forms = [];
       for (var context in instance.contexts){
            let thisForm = instance.contexts[context].form;
            if (!forms.includes(thisForm)){
                forms.push(thisForm);
            }
       }
        
        console.log(forms);

        
        for (f=0; f < forms.length; f++){
            console.log(forms[f]);
            var pattern = new RegExp('(>|$|\\s)(' + forms[f] + ')([^\\w])','g');
            var replacement = "$1<span class='highlight'>$2</span>$3";
            console.log('Pattern: ' + pattern + "; Replace: " + replacement);
            body.innerHTML = body.innerHTML.replace(pattern,replacement);
        }
        
        /* Scroll the first match into view */        
        var firstMatch = document.querySelectorAll('.highlight')[0];
        firstMatch.classList.add('focused');
        scrollIntoViewWithOffset(firstMatch, true);
        
        /* Add dehighlight button */
        addUnhighlightButton();
    }
    
    function addUnhighlightButton(){
        var toolsDiv = document.getElementById('tools');
        toolsDiv.setAttribute('data-hit', '1');
        
        var highlightBtn = document.getElementById('unhighlightButton');
        highlightBtn.classList.add('show');
        highlightBtn.classList.add('highlighted');
                
        highlightBtn.addEventListener('click', toggleHighlight);
        var total = document.querySelectorAll('span.highlight').length;

/*         
        button.setAttribute('id','unhighlightButton');
        button.setAttribute('class','highlighted');
        button.setAttribute('data-count', document.querySelectorAll('span.highlight').length);*/
        
        var prevButton = document.getElementById('goToPrevSearch');
        var nextButton = document.getElementById('goToNextSearch');

        if (document.querySelectorAll('span.highlight').length > 1){
                nextButton.addEventListener('click', goToNextHit);
                prevButton.addEventListener('click', goToPrevHit);
                nextButton.classList.add('show');
                prevButton.classList.add('show');
        }
        highlightBtn.setAttribute('data-count', total);
        prevButton.querySelectorAll('div.label')[0].setAttribute('data-count', total);
        nextButton.querySelectorAll('div.label')[0].setAttribute('data-count', total);
        resetHit(1, document.querySelectorAll('span.highlight').length);
    }
    
    
    function goToNextHit(){
        var nextNum = this.querySelectorAll('div.label')[0].getAttribute('data-hit');
        var hits = document.querySelectorAll('span.highlight');
        var nextHit = hits[nextNum-1];
        scrollIntoViewWithOffset(nextHit, false);
        removeFocus()
        nextHit.classList.add('focused');
        
        resetHit(nextNum, hits.length);
    }
    
     function goToPrevHit(){
        var prevNum = this.querySelectorAll('div.label')[0].getAttribute('data-hit');
        var hits = document.querySelectorAll('span.highlight');
        var prevHit = hits[prevNum-1];
        scrollIntoViewWithOffset(prevHit, false);
        removeFocus()
        prevHit.classList.add('focused');
        resetHit(prevNum, hits.length);
    }
    
    function resetHit(instance, hits){
        var prev, next;
        instance = parseInt(instance);
        hits = parseInt(hits);
        console.log('THIS INSTANCE ' + instance);
        console.log('THESE HITS:' + hits);
        if (instance == 1){
            prev = hits;
        } else {
            prev = instance - 1;
        }
        if (instance == hits){
            next = 1;
        } else {
            next = instance + 1;
        }
        
        /*  Now set the prev */
        document.getElementById('goToPrevSearch').querySelectorAll('div.label')[0].setAttribute('data-hit', prev);
        
        /* And set next */
        document.getElementById('goToNextSearch').querySelectorAll('div.label')[0].setAttribute('data-hit',next);
    }
    
    function removeFocus(){
       var focused = document.getElementsByClassName('focused');
       while (focused[0]){
           focused[0].classList.remove('focused');
       }
    }
    
    function toggleHighlight(){
        var isHighlighted = this.classList.contains('highlighted');
        var his = document.querySelectorAll('span.highlight');
        
        for (var h=0; h < his.length ; h++){
            if (isHighlighted){
                 his[h].classList.add('deselected');
            } else {
                his[h].classList.remove('deselected');
            }
           
        }
        if (isHighlighted){
            this.classList.remove('highlighted');
            this.classList.add('unhighlighted');
           
        } else {
            this.classList.remove('unhighlighted');
            this.classList.add('highlighted');
        }
    }
    
    function scrollIntoViewWithOffset(el, smooth){
        var header = document.getElementsByTagName('header')[0];
        var hh = header.getBoundingClientRect().height;
        var scrollHeight = -hh + -10;
        if (!isElementInViewport(el)){
        el.scrollIntoView();
        window.scrollBy(0, scrollHeight);
        }

    }

    
    
    function returnDoc(obj){
        return obj.docId == docId;
    }
    
    
    /* Taken with thanks from: https://stackoverflow.com/a/7557433/5628 */
    function isElementInViewport (el) {
    
    var rect = el.getBoundingClientRect();

    return (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) && /*or $(window).height() */
        rect.right <= (window.innerWidth || document.documentElement.clientWidth) /*or $(window).width() */
    );
}
   
    //* Now get the JSONs for each of these... */
    
    //* Now find the distinct forms for each of those JSONS */
    
    /* And highlight them. */
    
    function highlight(container,what,spanClass) {
    var content = container.innerHTML,
        pattern = new RegExp('(>[^<.]*)(' + what + ')([^<.]*)','g'),
        replaceWith = '$1<span ' + ( spanClass ? 'class="' + spanClass + '"' : '' ) + '">$2</span>$3',
        highlighted = content.replace(pattern,replaceWith);
    return (container.innerHTML = highlighted) !== content;
}



