let Sch;
window.addEventListener('load', function () {
    Sch = new StaticSearch();
    
    let codeSamples = document.querySelectorAll("[data-type='searchExamples'] code");
    codeSamples.forEach(code => {
        code.classList.add('link');
        code.addEventListener('click', e => {
              Sch.queryBox.value=code.innerHTML;
              Sch.searchButton.click();
        });
    });
    var filterBtn = document.getElementById('filterSearch');
    filterBtn.addEventListener('click', function (e) {
        document.getElementById('ssDoSearch').click();
    });
    var filters = document.querySelectorAll('.wea-ss-filters input');
    filters.forEach(function (i) {
        i.addEventListener('change', function (e) {
            console.log('changed');
            if (filterBtn.disabled) {
                filterBtn.removeAttribute('disabled');
            }
        });
    });
    var textInputs = document.querySelectorAll('.wea-ss-filters input[type="text"]');
    textInputs.forEach(function (input) {
        input.addEventListener('keydown', function (e) {
            if (e.key == 'Enter') {
                document.getElementById('ssDoSearch').click();
            }
        });
    });
    
 document.getElementById('ssDoSearch').addEventListener('click', function(){
    let sorters = document.querySelectorAll('#sorters');
    if (sorters.length > 0){
        sorters[0].parentNode.removeChild(sorters[0]);
    }
  });

    Sch.searchFinishedHook = function () {
        let thisResults = this.resultsDiv;
        let resultObjs = thisResults.querySelectorAll('div');
        let headers = this.resultsDiv.querySelectorAll('div > a');
        let images = this.resultsDiv.querySelectorAll('img');
        let hasKwic = thisResults.querySelectorAll(".kwic").length > 0;
        
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
});

function getDate(r){
    let date = r.querySelectorAll("div[data-filter='Publication Date']")[0];
    if (date.length > 0){
        
    } else {
        return new Date('2020-01-01');
    }
}

    



