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