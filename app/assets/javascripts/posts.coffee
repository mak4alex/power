ready = ->
  window['rangy'].initialized = false
  $('.infinite-table').infinitePages
    loading: ->
      $(this).text('Loading next page...')
    error: ->
      $(this).button('There was an error, please try again')
  $('#fileupload').fileupload({
        dataType: 'json',
        send: (e, data) ->
          $(this).prop('disabled', true)
          $(this).parent().toggleClass('disabled')
          $('#upload-status').text('Uploading...')
        done: (e, data) ->
          $(this).prop('disabled', false)
          $(this).parent().toggleClass('disabled')
          $('#upload-status').text('Upload image...')
          $('iframe.wysihtml5-sandbox')
            .contents()
            .find(".wysihtml5.wysihtml5-editor")
            .append('<img alt="image" src="' + data.result.url_medium + '"/>')
    })


$(document).on('ready', ready)
$(document).on('page:load', ready)

