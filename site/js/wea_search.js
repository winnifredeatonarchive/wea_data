let Sch;
window.addEventListener('load', function () {
    Sch = new StaticSearch();
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
    
    Sch.searchFinishedHook = function () {
        let thisResults = this.resultsDiv;
        let resultObjs = thisResults.querySelectorAll('div');
        let headers = this.resultsDiv.querySelectorAll('div > a');
        let images = this.resultsDiv.querySelectorAll('img');
        let hasKwic = thisResults.querySelectorAll(".kwic").length > 0;
        images.forEach(function (img) {
            img.classList.add('lazy');
            img.setAttribute('data-src', img.src);
            img.src = '';
        });
        lazyload();
        filterBtn.setAttribute('disabled', 'disabled');
        headers.forEach(function (head) {
            let link = head.getAttribute('href');
            fetch('ajax/' + link).then(function (file) {
                /* Get the response as text */
                return file.text();
            }).then(function (frag) {
                /*  And put the stuff in a nonce div and pass the inner HTML to it*/
                var nonce = document.createElement('div');
                nonce.innerHTML = frag;
                head.after(nonce.firstElementChild)
            });
        });
         let buttonDiv = document.createElement('div');
         buttonDiv.setAttribute('id', 'sorters');
         thisResults.insertBefore(buttonDiv, thisResults.firstElementChild);

        ['score','date', 'title'].forEach(function(o){
            let btn = document.createElement('button');
            btn.setAttribute('id', o + 'Sort');
            btn.innerHTML = o.charAt(0).toUpperCase() + o.slice(1);
            if (!hasKwic && o=='score'){
                return;
            }
            buttonDiv.appendChild(btn);
            btn.addEventListener('click', function(){
                if (!btn.classList.contains('asc')){
                    btn.classList.remove('desc');
                    btn.classList.add('asc');
                } else {
                    btn.classList.remove('asc');
                    btn.classList.add('desc');
                }
                let abtns = document.querySelectorAll('#sorters > button.active');
                abtns.forEach(function(a){
                    a.classList.remove('active');
                });
                btn.classList.add('active');
                if (o == 'score'){
                    resultObjs.forEach(function(r){
                        r.style.order = '';
                    });
                } else if (o == 'date'){
                    resultObjs.forEach(function(r){
                        r.parentNode.style.order = r.querySelectorAll('details')[0].getAttribute('data-dateorder');
                    });
                } else if (o == 'title'){
                    resultObjs.forEach(function(r){
                       r.parentNode.style.order = r.querySelectorAll('details')[0].getAttribute('data-titleorder');
                    });
                
                }
                
                if (btn.classList.contains('asc')){
                        btn.parentNode.parentNode.classList.add('reverse');
                } else {
                        btn.parentNode.parentNode.classList.remove('reverse');
                }
                
            });
        });

    }
});

function getDate(r){
    let date = r.querySelectorAll("div[data-filter='Publication Date']")[0];
    if (date.length > 0){
        
    } else {
        return new Date('2020-01-01');
    }
}

