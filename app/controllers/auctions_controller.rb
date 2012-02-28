class AuctionsController < ApplicationController
	skip_before_filter :require_login, only: [:index]

	def index
		@auctions = Auction.order("end_time desc").page(params[:page]).per(12)
	end
	def show
		if params[:id] === 'bids'
			redirect_to root_url
		elsif !(@auction = Auction.find_by_id params[:id])
			redirect_to "/404.html"
		end
	end
end
