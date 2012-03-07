class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index]

  def index
  	@auctions = Auction.where("end_time > now()").order("end_time desc").page(params[:page]).per(8)
  end
end
