class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index]

  def index
  	@auctions = Auction.order("end_time desc").where("end_time > now()").page(params[:page]).per(8)
  end
end
