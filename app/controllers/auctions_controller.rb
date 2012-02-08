class AuctionsController < ApplicationController
	def index
		# TODO: Change to end_time when filled with data
		@auctions = Auction.find(:all, :limit => 8, :order => 'created_at desc')
	end
end
