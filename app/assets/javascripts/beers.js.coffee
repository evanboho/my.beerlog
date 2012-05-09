jQuery -> 
  $('.alert').delay(2000).fadeOut(500);
  $("button.beeer-row").live("click", ->
    id = $(this).attr('id')
    $('tr#beer-row-' + id).toggle()
    # $('.rating').toggle()
    $('.edit-button').toggle()
  )
  $("button.new-beer-row").live("click", ->
    $('tr#new-beer-row').toggle()
    # $('.rating').toggle()
    $('.edit-button').toggleClass('hidden')
    # $('#new-beer').toggle()
    
  )