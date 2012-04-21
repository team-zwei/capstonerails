//= require active_admin/base
//= require bootstrap

$(document).ready(function(){
    $('.label').removeClass('label');
    $('#dashboard').after('<li><a href="/auctions/new">Add Auction</a></li>');
});