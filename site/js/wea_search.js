
/* Set up some null globals */
let Sch, staticSearchDiv, filterBtn, filtersSection, filterFieldsets, filterInputs, mainSection;

window.addEventListener('load', searchInit);

function searchInit(){
    /* First set up */
    searchSetup();
    searchCreateSearch();
}


function searchSetup(){
  staticSearchDiv = document.getElementById('staticSearch');
  filtersSection = staticSearchDiv.querySelector('.wea-ss-filters');
  filterFieldsets =   filtersSection.querySelectorAll('fieldset');
  filterInputs = filtersSection.querySelectorAll('input');
  mainSection = staticSearchDiv.querySelector('.wea-ss-search-and-results');
  filterBtn = document.getElementById('filterSearch');
  
  let searchBtn = document.getElementById('ssDoSearch');
  let codeSamples = mainSection.querySelectorAll("[data-type='searchExamples'] code");
  let queryBox = staticSearchDiv.querySelector('#ssQuery');
  
  /* First make the code samples clickable */
    codeSamples.forEach(code => {
        code.classList.add('link');
        code.addEventListener('click', e => {
              queryBox.value=code.innerHTML;
              searchBtn.click();
        });
    });
   
   
   /* Now make the filterBtn a proxy for the actual search button */
    filterBtn.addEventListener('click', e => { 
        searchBtn.click(); 
    });
    
       

    filterInputs.forEach( input => {
        input.addEventListener('change', e => {
            if (filterBtn.disabled) {
               filterBtn.removeAttribute('disabled');
            }
        });
    });
    
    filterFieldsets.forEach(fieldset => {
        fieldset.classList.add('expandable');
        fieldset.classList.add('closed');
        let legend = fieldset.querySelector('legend');
        let miDiv = document.createElement('span');
       
       /* Add a right arrow btn */
        miDiv.classList.add('mi');
        miDiv.innerText = 'chevron_right';
        legend.appendChild(miDiv);
        
       /* And group stuff as content */ 
        let contentDiv = document.createElement('div');
        contentDiv.classList.add('content');
        let sib = legend.nextElementSibling;
        while (sib){
            contentDiv.appendChild(sib);
            sib = legend.nextElementSibling;
        }
        
        /* And now put the content in the content div */
        fieldset.appendChild(contentDiv);
        
        /* And let these be expandable */
        legend.addEventListener('click', e => {
            if (fieldset.classList.contains('closed')){
                fieldset.classList.remove('closed');
                fieldset.classList.add('open');
            } else {
                fieldset.classList.remove('open');
                fieldset.classList.add('closed');
            }
        });
    });
    
    
    filterInputs.forEach(input => {
        if (!input.type == 'text'){
            return;
        }
        input.addEventListener('keydown', e => {
                if (e.key == 'Enter') {
                    searchBtn.click();
                }
         })
     });
     
     searchBtn.addEventListener('click', function(){
            let sorters = document.querySelectorAll('#sorters');
            if (sorters.length > 0){
                sorters[0].parentNode.removeChild(sorters[0]);
            }
        });
    
}

function openFilters(){
    filterFieldsets.forEach(fieldset => {
        let activeInputs = false;
        fieldset.querySelectorAll('input').forEach(input => {
            console.log(input);
            console.log(input.checked);
            console.log(input.value.length);
            if (input.checked || (input.type == 'text' && input.value.length > 0)){
                activeInputs = true;
                return;
            }
        });
        if (activeInputs){
            fieldset.classList.remove('closed');
            fieldset.classList.add('open');
        }
    })
}

function searchCreateSearch(){
      Sch = new StaticSearch();  
      Sch.searchFinishedHook = function () {
        openFilters();
        let thisResults = this.resultsDiv;
        let resultObjs = thisResults.querySelectorAll('div');
        let headers = this.resultsDiv.querySelectorAll('div > a');
        let images = this.resultsDiv.querySelectorAll('img');
        let hasKwic = thisResults.querySelectorAll(".kwic").length > 0;
        
        resultObjs.forEach(o => {
            let childNodes = o.childNodes;
            Array.from(childNodes).forEach(node => node.nodeType != 1 && node.parentNode.removeChild(node))
        });
        /* Reset sorting */
        this.resultsDiv.classList.remove('reverse');
        this.resultsDiv.classList.remove('loaded');
        
        images.forEach(function (img) {
            img.classList.add('lazy');
            img.setAttribute('data-src', img.src);
            img.src = '';
        });
        lazyload();
        filterBtn.setAttribute('disabled', 'disabled');
        headers.forEach(function (head, i) {
            let link = head.getAttribute('href');
            fetch('ajax/' + link).then(function (file) {
                /* Get the response as text */
                return file.text();
            }).then(function (frag) {
                /*  And put the stuff in a nonce div and pass the inner HTML to it*/
                var nonce = document.createElement('div');
                nonce.innerHTML = frag;
                head.after(nonce.firstElementChild)
                if (i == headers.length - 1){
                  thisResults.classList.add('loaded');
                  if (!hasKwic){
                     sortByTitle();
                  }
         
                }
            });
        });
        

         let buttonDiv = document.createElement('div');
         buttonDiv.setAttribute('id', 'sorters');
         thisResults.insertBefore(buttonDiv, thisResults.firstElementChild);
         let label = document.createElement('label');
         label.setAttribute('for','sortSelect');
         label.setAttribute('id', 'sortSelectLabel');
         label.innerHTML = "Sort by";
         let select = document.createElement('select');
         select.setAttribute('id','sortSelect');
         buttonDiv.appendChild(label);
         buttonDiv.appendChild(select);
         let options = {
             "score": ["Score", "Highest", "Lowest"],
             "title": ["Title", "A", "Z"],
             "date": ["Date", "Earliest", "Latest"]
         }
         
         if (!hasKwic){
             delete options["score"];
         }
         for (const option in options){
                let captions = options[option];
                for (let i=1; i<3; i++){
                      let optEl = document.createElement("option");
                      let first = (i == 1) ? captions[1] : captions[2];
                      let second = (i == 2) ? captions[1] : captions[2];
                      optEl.innerHTML = captions[0] + " (" + first + " to " + second + ")";
                      let suffix = "";
                      if (i == 2){
                          suffix = "-r";
                      }
                      optEl.setAttribute('value',captions[0].toLowerCase() + suffix);
                      select.appendChild(optEl);
                }
         }
         
  
         select.addEventListener('change',function(){
             let selectedOption = this.options[this.selectedIndex].value;
             console.log(selectedOption);
             let o = selectedOption.split('-')[0];
             this.parentNode.parentNode.classList.remove('reverse');
              if (o == 'score'){
                   console.log('hskdfj');
                    resultObjs.forEach(function(r){
                        r.parentNode.style.order = '';
                  });
                } else if (o == 'date'){
                   sortByDate();
                } else if (o == 'title'){
                    sortByTitle();
                
                }
             if (selectedOption.split('-')[1] == 'r'){
                 this.parentNode.parentNode.classList.add('reverse');
             }
         });
         
          function sortByDate(){
           resultObjs.forEach(function(r){
                        r.parentNode.style.order = r.querySelectorAll('details')[0].getAttribute('data-dateorder');
            });
         }
         
         function sortByTitle(){
             resultObjs.forEach(function(r){
                       r.parentNode.style.order = r.querySelectorAll('details')[0].getAttribute('data-titleorder');
           });
         }
    }
    
}



function getDate(r){
    let date = r.querySelectorAll("div[data-filter='Publication Date']")[0];
    if (date.length > 0){
        
    } else {
        return new Date('2020-01-01');
    }
}

    



