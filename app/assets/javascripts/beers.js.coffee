jQuery -> 
  $("button.beer-row").live("click", ->
    id = $(this).attr('id')
    $('tr#beer-row-' + id).toggle()
  )
  $("button.new-beer-row").live("click", ->
    $('tr#new-beer-row').toggle()
  )