ready = ->
  $('.infinite-table').infinitePages
    loading: ->
      $(this).text('Loading next page...')
    error: ->
      $(this).button('There was an error, please try again')
$(document).unbind('ready page:change', ready)
$(document).bind('ready page:change', ready)

