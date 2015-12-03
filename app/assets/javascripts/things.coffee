# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  # console.trace('Entering document.ready in things.coffee')
  onClick = (_event) -> window.location.href  += '/things/new'
  button = $('button.btn.btn-primary')
  button.click(onClick) if button.length
  # console.trace('Leaving document.ready in things.coffee')
