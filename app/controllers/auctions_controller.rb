class AuctionsController < ApplicationController
	def index
		# TODO: Change to end_time when filled with data
		@auctions = Auction.find(:all, :limit => 8, :order => 'created_at desc')
	end
	def show
		@auction = Auction.find_by_id params[:id]
	end
end
