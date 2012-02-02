# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
	$("#nav li:not(#nav_account)").attr('class', '')
	$("#nav_account").attr('class', 'active')