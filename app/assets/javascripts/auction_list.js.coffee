# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

timers = {}
$(".auction_thumbnail").each ->
  id = $(this).parent().attr("id")
  time_elem = $("#" + id + " .auction_thumbnail_time")
  timers[id + "_timer"] = countdownTimer(time_elem.attr("data-time-remaining"), (result) ->
    time_elem.text result
  )

stock_modal = undefined
$(document).ready ->
  stock_modal = $("#bid_modal").clone().html()
  $(".auction_thumbnail_bid_now").click ->
    $("#bid_modal").html stock_modal
    $("#bid_modal").modal
      backdrop: true
      keyboard: true

    id = $(this).attr("id").split("_")[3]
    auction_id = "auction_" + id

    $("#bid_modal").attr('data-auction-id', id)

    $("#bid_modal .modal-header").prepend       $("#" + auction_id + " .auction_thumbnail_title").text()
    $("#bid_modal .modal-description").prepend  $("#" + auction_id + " .auction_thumbnail_description_text").text()
    
    $("#bid_modal .modal-thumbnail").append     $("#" + auction_id + " .auction_thumbnail_image").clone()
    $("#bid_modal #auction_id").attr "value", $(this).attr("id").split("_")[3]

    price_elem = $("#" + auction_id + " .auction_thumbnail_price")
    $("#bid_modal .modal-amount").val(
      (parseFloat(price_elem.attr('data-current-price').replace(/\,/g, ''))+
      parseFloat(price_elem.attr('data-min-bid-increment'))).toFixed(2))
    $("#bid_modal .bid-amount-label").text("Bid Amount (Enter $" + $("#bid_modal .modal-amount").val() + " or more):")
    false

  PrivatePub.subscribe "/bids/new", (data, channel) ->
    console.log "amount: " + data.message.amount + "\nauction_id: " + data.message.auction_id + "\ntime: " + data.message.time
    timers["auction_"+data.message.auction_id+"_timer"].updateSecondsRemaining data.message.time
    
    new_price = parseFloat(data.message.amount).toFixed(2);
    price_elem = $("#auction_"+data.message.auction_id+" h3.auction_thumbnail_price")
    price_elem.text "$" + new_price
    price_elem.attr 'data-current-price', new_price

    $("#auction_"+data.message.auction_id+" .auction_thumbnail_price_time_container").effect("highlight", { color: "#FF9999" }, 1500);
