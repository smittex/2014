document.addEventListener("DOMContentLoaded", function() {
	
	var closeBtn = document.querySelector('#closeBtn');
	closeBtn.addEventListener('click', function (event) {
		var overlay = document.querySelector('#overlay');
		overlay.classList.add('hide');    
	});

	var movieList = document.querySelector('ul.movieList');
	movieList.addEventListener('click', function (event) {
		var node = event.target, movieId;

		if (node !== this) {
			while(node.tagName !== 'LI') {
				node = node.parentNode;
			}

			movieId = node.getAttribute('data-movie-id');
			getSynopsis(movieId);
		}
	});
});

function getSynopsis(movieId) {
	var request = new XMLHttpRequest();
    
	request.onload = function () { 
	   var synopsis = JSON.parse(request.responseText);
       render(synopsis);
       console.log("Sony's id: ", movieId);
    };
	
	request.open('GET', '/movies/synopsis?movieId='+ movieId, true);
	request.send();
}

function render (synopsis) {
	var modalBoxElem = document.querySelector('#overlay'),
    	movieTitleElem = document.querySelector('#overlay .synopsis h4'),
		movieSynopsisElem = document.querySelector('#overlay .synopsis p');
	
	debugger;
	
	movieTitleElem.innerHTML =  synopsis.movieTitle;
	movieSynopsisElem.innerHTML =  synopsis.movieSynopsis;
	
	modalBoxElem.classList.remove('hide');
}

