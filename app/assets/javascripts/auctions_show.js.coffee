# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
time_elem = $("dd.more_info_time")
timer = countdownTimer(time_elem.attr("data-time-remaining"), (result) -> time_elem.text result
)

price_elem = $("dd.more_info_price")
$("div.price-input .more-amount").val(
 	(parseFloat(price_elem.attr('data-current-price').replace(/\,/g, ''))+
 	parseFloat(price_elem.attr('data-min-bid-increment'))).toFixed(2))
#$("div.price-input .more-amount-label").text("Bid Amount (Enter $" + $("div.price-input .more-amount").val() + " or more):")

$(document).ready ->
	$(".carousel").carousel('cycle')
	$(".thumbnail").click(
		() -> 
			num = $(this).attr('data-image-number') - 1
			$("#myCarousel").carousel(num)
			false
	)

	PrivatePub.subscribe "/bids/new", (data, channel) ->
	    console.log "amount: " + data.message.amount + "\nauction_id: " + data.message.auction_id + "\ntime: " + data.message.time + "\nuser: " + data.message.user
	    timer.updateSecondsRemaining data.message.time
	    
	    new_price = parseFloat(data.message.amount).toFixed(2);
	    price_elem = $("dd.more_info_price")
	    price_elem.text "$" + new_price
	    price_elem.attr 'data-current-price', new_price

	    $("div.time-price-container").effect("highlight", { color: "#FF9999" }, 1500);