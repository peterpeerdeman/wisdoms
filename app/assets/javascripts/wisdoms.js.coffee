# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('a.w-load-more-wisdoms').on 'inview', (e, visible) ->
    return unless visible
    $.getScript $(this).attr('href')
