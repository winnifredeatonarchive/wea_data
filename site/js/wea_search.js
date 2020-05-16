                var Sch;
                window.addEventListener('load', 
                
                function(){
                
                Sch = new StaticSearch();
                Sch.searchFinishedHook = function(){
                let thisResults = this.resultsDiv;
                let headers = this.resultsDiv.querySelectorAll('div > a');
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
               /*  Sch.searchFinishedHook = function(){
                  let newResults;
                  let thisResults = this.resultsDiv;
                  let rowArray = [];
                  thisResults.querySelectorAll('#ssResults > ul > li').forEach(function(item){
                     var tr = document.createElement('tr');
                     var imgCell = document.createElement('td');
                     var titleCell = document.createElement('td');
                     var scoreCell = document.createElement('td');
                     var kwicCell = document.createElement('td');
                     imgCell.innerHTML = (item.firstElementChild.tagName == 'A') ? item.firstElementChild : '';
                     titleCell.appendChild(item.querySelectorAll('div > a')[0]);
                     kwicCell.appendChild(item.querySelectorAll('ul.kwic')[0]);
                     tr.appendChild(imgCell);
                     tr.appendChild(titleCell);
                     tr.appendChild(kwicCell);
                     console.log(tr);
                     rowArray.push(tr);
                     console.log(rowArray);
                  });
                  
                  let resultTable = document.createElement('table');
                  let headingOne = document.createElement('td');
                  let headingTwo = document.createElement('td');
                  let headingThree = document.createElement('td');
                  
                  headingTwo.innerHTML = 'Title';
                  headingThree.innerHTML = 'Results';
                  
                 let tableHead = document.createElement('thead');
                 let tableHeadRow = document.createElement('tr');
                 resultTable.appendChild(tableHead);
                 tableHead.appendChild(tableHeadRow);
                 tableHeadRow.appendChild(headingOne);
                 tableHeadRow.appendChild(headingTwo);
                 tableHeadRow.appendChild(headingThree);
                 let tableBody = document.createElement('tbody');
                 resultTable.appendChild(tableBody);
                 rowArray.forEach(function(row){
                 
                  tableBody.appendChild(row);
                 });
                 
                 console.log(resultTable);
                 this.resultsDiv.innerHTML = '';
                 this.resultsDiv.appendChild(resultTable);
                 
                 }
                */
                
                
                
                });


                 