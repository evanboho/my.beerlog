$(function() {
	$('#beer_table th.sortable a, .cancel').live("click", function() {
		$(".loading").html("loading..."); 
		$.getScript(this.href);
		return false;
	});
	$('#beer_search').submit(function() {
		$(".loading").html("loading...");
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	});
});
