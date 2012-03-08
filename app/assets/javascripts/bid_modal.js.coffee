# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#bid_modal_form").bind("ajax:beforeSend", (evt, xhr, settings) ->
    xhr.setRequestHeader "Accept", "application/json, */*; q=0.5" if settings.dataType is `undefined`
  ).bind("ajax:error", (evt, xhr, status, error) ->
    console.log "[XHR ERROR] " + error.message + " with status: " + status
    $("div.modal-error").html("You must <a href='login'>login</a> or <a href='signup'>register</a> to bid.").show() if xhr.status is 401
  ).bind "ajax:success", (evt, data, status, xhr) ->
    $("#bid_modal").modal "hide"