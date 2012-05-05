$(document).ready(function() {
	$('#beer_table th.sortable a, .cancel').live("click", function() {
		// $("#loading").removeClass("hidden");
		$("#beer_table").addClass("dim");
		$.getScript(this.href);
		return false;
	});
	$('#beer_search').submit(function() {
		// $("#loading").html("loading...");
		// $("#loading").removeClass("hidden");
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	});
});
