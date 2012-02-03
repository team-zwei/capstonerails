class AuctionsController < ApplicationController
	def index
		@auctions = Auction.all
	end
end
