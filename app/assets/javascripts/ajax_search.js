jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {
	$("button.beer-row").live("click", function() {
      id = $(this).data('id');
      $('tr#beer-row-' + id).toggle();
      $('.edit-button').toggle();
    });
	$('#beer_table th.sortable a, a.link-search, .nice_pagination a').live("click", function() {
		$("#beer_table").addClass("dim");
		$.getScript(this.href);
		return false;
	});
	$('#beer_search').submit(function() {
		$("#beer_table").addClass("dim");
		$.get(this.action, $(this).serialize(), null, "script");
		// alert(this.action);
		return false;
	});
	// $('.modal-rating').click(function() {
	// 	id = $(".modal-rating").attr('id').split('-')[2];
	// 	$('#rate-beer-' + id).modal('hide');
	// 	$('body').removeClass('modal-open');
	// });
	
	$('.edit_rating, .new_rating').live("submit", function() {
		// id = $(".modal-rating").attr('id').split('-')[2];
		// $('.modal').modal('hide');
		id = $(this).attr('id').split('_')[2];
		$("#edit_rating_" + id).addClass("dim");
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		return false;
	});
});
