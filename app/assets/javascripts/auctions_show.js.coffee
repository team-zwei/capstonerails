# time_elem = $("dd.more_info_time")

# price_elem = $("dd.more_info_price")
# $("div.price-input .more-amount").val(
#  	(parseFloat(price_elem.attr('data-current-price').replace(/\,/g, ''))+
#  	parseFloat(price_elem.attr('data-min-bid-increment'))).toFixed(2))
# $("div.price-input .more-amount-label").text("Bid Amount (Enter $" + $("div.price-input .more-amount").val() + " or more):")

$(document).ready ->
	$(".carousel").carousel('cycle')
	$(".thumbnail").click -> 
		num = $(this).attr('data-image-number') - 1
		$("#myCarousel").carousel(num)
		false

	timer = countdownTimer($('.more_info_time').attr("data-time-remaining"), (result) ->
		$('.more_info_time').text result
	)

	PrivatePub.subscribe "/bids/new", (data, channel) ->
    console.log "amount: " + data.message.amount + "\nauction_id: " + data.message.auction_id + "\ntime: " + data.message.time + "\nuser: " + data.message.user
    timer.updateSecondsRemaining data.message.time
    
    new_price = parseFloat(data.message.amount).toFixed(2);
    price_elem = $("dd.more_info_price")
    price_elem.text "$" + new_price
    price_elem.attr 'data-current-price', new_price

    $("div.time-price-container").effect("highlight", { color: "#FF9999" }, 1500);