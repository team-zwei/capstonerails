class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index]

  def index
  	# TODO: Change to end_time when filled with data
  	@auctions = Auction.order("end_time desc").page(params[:page]).per(8)
  end
end
