$(function() {
	$('#beer_table th a, .cancel').live("click", function() {
		$.getScript(this.href);
		return false;
	});
	$('#beer_search').submit(function() {
		$(".loading").html("loading...");
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	});
});
