class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index]

  def index
  	# TODO: Change to end_time when filled with data
  	@auctions = Auction.find(:all, :limit => 8, :order => 'created_at desc')
  end
end
