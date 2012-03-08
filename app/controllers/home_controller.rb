class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index]

  def index
  	@auctions = Auction.page(params[:page]).per(8)
  end
end
