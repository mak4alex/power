$(document).on 'ready page:load', ->
  sideslider = $('[data-toggle=collapse-side]')
  contentPage = $('.side-collapse-container')
  sel = sideslider.attr('data-target')
  sel2 = sideslider.attr('data-target-2')
  
  sideslider.click ->
    $(sel).toggleClass('in')
    $(sel2).toggleClass('out')
    contentPage.click ->
      $(sel).toggleClass('in')
      $(sel2).toggleClass('out')
      contentPage.unbind( "click" )
