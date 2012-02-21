class AuctionsController < ApplicationController
	def index
		# TODO: Change to end_time when filled with data
		@auctions = Auction.find(:all, :limit => 8, :order => 'created_at desc')
	end
	def show
		if params[:id] === 'bids'
			redirect_to root_url
		elsif !(@auction = Auction.find_by_id params[:id])
			redirect_to "/404.html"
		end
	end
end
