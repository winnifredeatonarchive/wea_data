                var Sch;
                window.addEventListener('load', 
                
                function(){
                
                Sch = new StaticSearch();
                var filterBtn = document.getElementById('filterSearch');
                filterBtn.addEventListener('click', function(e){
                    document.getElementById('ssDoSearch').click();
                });
                var filters = document.querySelectorAll('.wea-ss-filters input');
                filters.forEach(function(i){
                    i.addEventListener('change',function(e){
                        console.log('changed');
                        if (filterBtn.disabled){
                            filterBtn.removeAttribute('disabled');
                        }
                    });
                });
                
                var textInputs = document.querySelectorAll('.wea-ss-filters input[type="text"]');
                textInputs.forEach(function(input){
                    input.addEventListener('keydown', function(e){
                       if (e.key == 'Enter'){
                           document.getElementById('ssDoSearch').click();
                       } 
                    }); 
                });
                
                Sch.searchFinishedHook = function(){
                let thisResults = this.resultsDiv;
                let headers = this.resultsDiv.querySelectorAll('div > a');
                let images = this.resultsDiv.querySelectorAll('img');
                images.forEach(function(img){
                   img.classList.add('lazy');
                   img.setAttribute('data-src',img.src);
                   img.src='';
                });
                lazyload();
                filterBtn.setAttribute('disabled', 'disabled');
                headers.forEach(function(head){
                    let link = head.getAttribute('href');
                fetch('ajax/' + link)
                    .then(function(file){
                     /* Get the response as text */
                         return file.text();
                     })
                    .then(function(frag){
                     /*  And put the stuff in a nonce div and pass the inner HTML to it*/
                        var nonce = document.createElement('div');
                        nonce.innerHTML = frag;
                        head.after(nonce.firstElementChild)
                    });
                    
                });
                    
                    
                }
              
                
                
                });


                 