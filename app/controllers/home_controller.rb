class HomeController < ApplicationController
  def index
  	# TODO: will need to find by some criteria
  	# 		maybe auctions ending soon or something
  	@auctions = Auction.all
  end
end
