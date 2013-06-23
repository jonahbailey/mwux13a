
		
function setConformingHeight(el, newHeight) {
	// set the height to something new, but remember the original height in case things change
	el.data("originalHeight", (el.data("originalHeight") == undefined) ? (el.height()) : (el.data("originalHeight")));
	el.height(newHeight);
}

function columnConformizeForSelector(selector){
	var currentRowStart = 0,
	    currentTallest = 0,
	    rowDivs = [];

	// find the tallest DIV in the row, and set the heights of all of the DIVs to match it.
	$(selector).each(function() {
		// "caching"
		var $el = $(this);
		$el.css('height', '');

		var elHeight = $el.height(),
			topPosition = $el.position().top;

		if (currentRowStart != topPosition) {
			// we just came to a new row.  Set all the heights on the completed row
			for(currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) setConformingHeight(rowDivs[currentDiv], currentTallest);

			// set the variables for the new row
			rowDivs.length = 0; // empty the array
			currentRowStart = topPosition;
			currentTallest = elHeight;
			rowDivs.push($el);

		} else {

			// another div on the current row.  Add it to the list and check if it's taller
			rowDivs.push($el);
			currentTallest = (currentTallest < elHeight) ? elHeight : currentTallest;
		}
		// do the last row
		for (currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) setConformingHeight(rowDivs[currentDiv], currentTallest);
		
	});
}

function columnConform() {
	var selectorGroups = $.makeArray(arguments);
	$.each(selectorGroups, function(index, selector){
		$(window).resize(function() {
			columnConformizeForSelector(selector);
		});
		columnConformizeForSelector(selector);
	});
}


// Dom Ready
// You might also want to wait until window.onload if images are the things that
// are unequalizing the blocks
$(function() {
	columnConform(
		'.explanation .article-content', 
		'.callouts .article-content',
		'.venues .article-content'
	);
});
