class AuctionsController < ApplicationController
	skip_before_filter :require_login

	def index
		@auctions = Auction.search params[:search], order: :end_time, sort_mode: :desc if params[:search]

		@auctions.delete_if { |auction|
			params[:price_min].to_f > Bid.find_by_id(auction.current_bid_id) unless auction.current_bid_id.nil? || auction.starting_bid_price
		} if params[:price_min]

		@auctions.delete_if { |auction|
			params[:price_max].to_f < Bid.find_by_id(auction.current_bid_id) unless auction.current_bid_id.nil? || auction.starting_bid_price
		} if params[:price_max]

		@auctions ||= Auction.order("end_time desc").page(params[:page]).per(12)
	end

	def show
		if params[:id] === 'bids'
			redirect_to root_url
		elsif !(@auction = Auction.find_by_id params[:id])
			redirect_to "/404.html"
		end
	end
end
