# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
	$(".carousel").carousel('cycle')
	$(".thumbnail").click(
		() -> 
			num = $(this).attr('data-image-number') - 1
			$("#myCarousel").carousel(num)
			false
	)

	#price_elem = $("time-price-container"+ " dd.more_info_price")
    #$("time-price-container" + " .more-amount").val(
     # (parseFloat(price_elem.attr('data-current-price').replace(/\,/g, ''))+
     # parseFloat(price_elem.attr('data-min-bid-increment'))).toFixed(2))
	#$("time-price-container"+" .more-amount-label").text("Bid Amount (Enter $" + $("time-price-container"+" .more-amount").val() + " or more):")

	PrivatePub.subscribe "/bids/new", (data, channel) ->
	    console.log "amount: " + data.message.amount + "\nauction_id: " + data.message.auction_id + "\ntime: " + data.message.time + "\nuser: " + data.message.user
	    
	    new_price = parseFloat(data.message.amount).toFixed(2);
	    price_elem = $("dl-horizontal"+" dd.more_info_price")
	    price_elem.text "$" + new_price
	    price_elem.attr 'data-current-price', new_price

	    $("Details"+" .time-price-container").effect("highlight", { color: "#FF9999" }, 1500);