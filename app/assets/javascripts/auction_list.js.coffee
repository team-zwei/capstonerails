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
    price_elem = $("#" + auction_id + " .auction_thumbnail_price")
    $("#bid_modal .modal-amount").val(
      (parseFloat(price_elem.attr('data-current-price').replace(/\,/, ''))+
      parseFloat(price_elem.attr('data-min-bid-increment'))).toFixed(2))
    false

  PrivatePub.subscribe "/bids/new", (data, channel) ->
    console.log "amount: " + data.message.amount + "\nauction_id: " + data.message.auction_id + "\ntime: " + data.message.time
    timers["auction_"+data.message.auction_id+"_timer"].updateSecondsRemaining data.message.time
    
    new_price = parseFloat(data.message.amount).toFixed(2);
    price_elem = $("#auction_"+data.message.auction_id+" h3.auction_thumbnail_price")
    price_elem.text "$" + new_price
    price_elem.attr 'data-current-price', new_price


# updateAuction = (auction_id, time, amount) ->
  # $("auction_" + auction_id + " div.auction_thumbnail_time").text time
