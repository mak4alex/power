ready = ->
  window['rangy'].initialized = false
  iframe = $("iframe.wysihtml5-sandbox")
  console.log(iframe)
  iframe.onload = ->     
    console.log('lol')
    iframe.style.height = iframe.contentDocument.body.scrollHeight +'px'
  
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
      editor = $("#post_body").data('wysihtml5').editor
      editor.setValue(editor.getValue() + "<img alt=\"#{data.result.alt}\" src=\"#{data.result.url_medium}\" />")
    })



$(document).on('ready', ready)
$(document).on('page:load', ready)

