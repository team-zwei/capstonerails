class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index]

  def index
  	# TODO: will need to find by some criteria
  	# 		maybe auctions ending soon or something
  	@auctions = Auction.all
  end
end
