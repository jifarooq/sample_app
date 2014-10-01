# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

updateCountdown = ->
  remaining = 140 - jQuery("#micropost_content").val().length
  jQuery(".countdown").text remaining + " characters remaining"
  #jQuery(".countdown").css "color", (if (21 <= remaining <= 140) then "gray")
  #jQuery(".countdown").css "color", (if (11 <= remaining < 21) then "black")
  #jQuery(".countdown").css "color", (if (remaining < 11) then "red")

jQuery ->
  updateCountdown()
  $("#micropost_content").change updateCountdown
  $("#micropost_content").keyup updateCountdown