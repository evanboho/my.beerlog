jQuery -> 
  $("button.beer-row").live("click", ->
    id = $(this).attr('id')
    $('.loading').text('tr.beer-row-' + id)
    $('tr#beer-row-' + id).toggle()
  )
  $("button.new-beer-row").live("click", ->
    $('.loading').text()
    $('tr#new-beer-row').toggle()
  )