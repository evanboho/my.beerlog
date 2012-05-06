jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {
	$("button.beer-row").live("click", function() {
      id = $(this).data('id');
      $('tr#beer-row-' + id).toggle();
      $('.edit-button').toggle();
    });
	$('#beer_table th.sortable a, .cancel, .nice_pagination a').live("click", function() {
		$("#beer_table").addClass("dim");
		$.getScript(this.href);
		// alert(this.href);
		return false;
	});
	$('#beer_search').submit(function() {
		$("#beer_table").addClass("dim");
		$.get(this.action, $(this).serialize(), null, "script");
		// alert(this.action);
		return false;
	});
});
