ready = ->
  console.log('ready')
  
  window['rangy'].initialized = false
  window.getSelection().removeAllRanges()
  
  iframe = $("iframe.wysihtml5-sandbox")
  
  iframe.onload = ->
    iframe.style.height = iframe.contentDocument.body.scrollHeight +'px'
  

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
  
  
  $('.raty').raty({
    score: ->
      $(this).data('score')
    readOnly: ->
      $(this).data('read-only')
    click: (weight) ->
      elemRaty = $(this)
      $.ajax({
        type: 'PATCH',
        url: $(this).data('path'),
        data: { 
          weight
        },
        success:(data) ->
          elemRaty.raty('score', data.weighted_average);
        error:(data) ->
          console.log('error')
      })
      
  })
  
  $('#post_tag_list').tagsInput({
    'autocomplete_url': null,
    'interactive':true,
    'defaultText':'add a tag',
    'delimiter': [','],
    'height':'50px',
    'width':'100%',
    'removeWithBackspace' : true,
    'minChars' : 3,
    'maxChars' : 32,
    'placeholderColor' : '#666666'
  })
  


$(document).on('ready', ready)
$(document).on('page:load', ready)
