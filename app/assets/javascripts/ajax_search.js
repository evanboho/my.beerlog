$(document).ready(function() {
	$('#beer_table th.sortable a, .cancel').live("click", function() {
		$("#beer_table").addClass("dim");
		$.getScript(this.href);
		return false;
	});
	$('#beer_search').submit(function() {
		$("#beer_table").addClass("dim");
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	});
});
