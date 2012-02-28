# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

stock_modal = undefined
$(document).ready ->
  stock_modal = $("#bid_modal").clone().html()
  $(".auction_thumbnail_bid_now").click ->
    $("#bid_modal").html stock_modal
    $("#bid_modal").modal
      backdrop: true
      keyboard: true

    auction_id = "auction_" + $(this).attr("id").split("_")[3]
    $("#bid_modal .modal-header").prepend $("#" + auction_id + " .auction_thumbnail_title").text()
    $("#bid_modal .modal-description").prepend $("#" + auction_id + " .auction_thumbnail_description_text").text()
    $("#bid_modal .modal-time").prepend $("#" + auction_id + " .auction_thumbnail_time").text()
    $("#bid_modal .modal-thumbnail").append $("#" + auction_id + " .auction_thumbnail_image").clone()
    $("#bid_modal #auction_id").attr "value", $(this).attr("id").split("_")[3]
    false

  PrivatePub.subscribe "/bids/new", (data, channel) ->
    console.log "amount: " + data.message.amount + "\nauction_id: " + data.message.auction_id + "\ntime: " + data.message.time

updateAuction = (auction_id, time, amount) ->
  $("auction_" + auction_id + " div.auction_thumbnail_time").text time
