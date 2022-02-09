/* Set up some null globals */
let Sch, staticSearchDiv, filterBtn, filtersSection, filterFieldsets, filterInputs, mainSection;


window.addEventListener('load', searchInit);

function searchInit() {
	/* First set up */
	searchSetup();
	searchCreateSearch();
}


function searchSetup() {
	staticSearchDiv = document.getElementById('staticSearch');
	filtersSection = staticSearchDiv.querySelector('.wea-ss-filters');
	filterFieldsets = filtersSection.querySelectorAll('fieldset');
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
			queryBox.value = code.innerHTML;
			searchBtn.click();
		});
	});


	/* Now make the filterBtn a proxy for the actual search button */
	filterBtn.addEventListener('click', e => {
		searchBtn.click();
	});


	filterInputs.forEach(input => {
		input.addEventListener('change', e => {
			if (filterBtn.disabled) {
				filterBtn.removeAttribute('disabled');
			}
		});
	});

	

	searchBtn.addEventListener('click', function () {
		let sorters = document.querySelectorAll('#sorters');
		if (sorters.length > 0) {
			sorters[0].parentNode.removeChild(sorters[0]);
		}
	});

}

function searchCreateSearch() {
	Sch = new StaticSearch();
	document.querySelectorAll('details[open]').forEach(dtl => {
	   dtl.setAttribute('aria-expanded', 'true'); 
	    
	});
	Sch.searchFinishedHook = function () {
		let thisResults = this.resultsDiv;
		Sch.resultObjs = thisResults.querySelectorAll('div');
		let headers = this.resultsDiv.querySelectorAll('div > a');
		let images = this.resultsDiv.querySelectorAll('img');
		if (Sch.resultObjs.length === 0) {
			thisResults.classList.add('loaded');
			return;
		}

		/* Reset sorting */
		this.resultsDiv.classList.remove('reverse');
		this.resultsDiv.classList.remove('loaded');
		if (Sch.resultObjs.length > 1) {
			createSorters();
		}

		images.forEach(function (img) {
			img.classList.add('lazy');
			img.setAttribute('data-src', img.src);
			img.src = '';
		});
		lazyload();
		filterBtn.setAttribute('disabled', 'disabled');
		trimResults();
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
				if (i == headers.length - 1) {
					thisResults.classList.add('loaded');
					if (!hasKwic()) {
						sortByDate();
					}

				}
			});
		});


	}

}


function trimResults() {
	let kwicLists = Sch.resultsDiv.querySelectorAll('ul.kwic');
	kwicLists.forEach(list => {
		let items = list.querySelectorAll('li');
		if (items.length > 10) {
			for (let i = 10; i < items.length; i++) {
				items[i].classList.add('excess');
				items[i].classList.add('hidden');
			}
			let showHideKwic = document.createElement('li');
			let showHideKwicLink = document.createElement('a');
			showHideKwicLink.classList.add('show');
			showHideKwicLink.classList.add('showHideKwic');
			showHideKwicLink.href = '#';
			showHideKwicLink.innerText = items.length - 10;
			showHideKwic.appendChild(showHideKwicLink);
			list.appendChild(showHideKwic);
			showHideKwicLink.addEventListener('click', e => {
				e.preventDefault();
				console.log(e);
				if (showHideKwicLink.classList.contains('show')) {
					list.querySelectorAll('.hidden').forEach(item => {
						item.classList.remove('hidden');
					})
					showHideKwicLink.classList.remove('show');
				} else {
					list.querySelectorAll('.excess').forEach(item => {
						item.classList.add('hidden');
					})
					showHideKwicLink.classList.add('show');
				}
			})


		}


	});


}

function createSorters() {


	const options = {
		"relevance": ["Relevance", "Highest", "Lowest"],
		"instances": ["Instances", "Highest", "Lowest"],
		"date": ["Date", "Earliest", "Latest"],
		"title": ["Title", "A", "Z"]
	}
	let buttonDiv = document.createElement('div');
	buttonDiv.setAttribute('id', 'sorters');
	Sch.resultsDiv.insertBefore(buttonDiv, Sch.resultsDiv.firstElementChild);
	let label = document.createElement('label');
	label.setAttribute('for', 'sortSelect');
	label.setAttribute('id', 'sortSelectLabel');
	label.innerHTML = "Sort by";
	let select = document.createElement('select');
	select.setAttribute('id', 'sortSelect');
	buttonDiv.appendChild(label);
	buttonDiv.appendChild(select);


	if (!hasKwic()) {
		delete options["instances"];
		delete options["relevance"];
	}
	for (let option in options) {
		let captions = options[option];
		for (let i = 1; i < 3; i++) {
			let optEl = document.createElement("option");
			let first = (i == 1) ? captions[1] : captions[2];
			let second = (i == 2) ? captions[1] : captions[2];
			optEl.innerHTML = captions[0] + " (" + first + " to " + second + ")";
			let suffix = "";
			if (((i == 1) && option == 'instances') || (i == 2 && !(option == 'instances'))) {
				suffix = "-r";
			}
			optEl.setAttribute('value', captions[0].toLowerCase() + suffix);
			select.appendChild(optEl);
		}
	}


	select.addEventListener('change', function () {
		let selectedOption = this.options[this.selectedIndex].value;
		console.log(selectedOption);
		let o = selectedOption.split('-')[0];
		this.parentNode.parentNode.classList.remove('reverse');
		if (o == 'relevance') {
			Sch.resultObjs.forEach(function (r) {
				r.parentNode.style.order = '';
			})
		} else if (o == 'instances') {
			sortByScore();
		} else if (o == 'date') {
			sortByDate();
		} else if (o == 'title') {
			sortByTitle();
		}
		if (selectedOption.split('-')[1] == 'r') {
			this.parentNode.parentNode.classList.add('reverse');
		}
	});
}


function getDate(r) {
	let date = r.querySelectorAll("div[data-filter='Publication Date']")[0];
	if (date.length > 0) {

	} else {
		return new Date('2020-01-01');
	}
}


function sortByDate() {
	Sch.resultObjs.forEach(function (r) {
		r.parentNode.style.order = r.querySelectorAll('details')[0].getAttribute('data-dateorder');
	});
}

function sortByTitle() {
	Sch.resultObjs.forEach(function (r) {
		r.parentNode.style.order = r.querySelectorAll('details')[0].getAttribute('data-titleorder');
	});
}

function sortByScore() {
	Sch.resultObjs.forEach(function (r) {
		let id = r.querySelector('a').getAttribute('href');
		console.log(id);
		let currResultObj = Sch.resultSet.mapDocs.get(id);
		console.log(Sch.resultSet.mapDocs);
		let count = currResultObj['contexts'].length;
		r.parentNode.style.order = count;
	});
}

function hasKwic() {
	return Sch.resultsDiv.querySelectorAll(".kwic").length > 0;
}
    



