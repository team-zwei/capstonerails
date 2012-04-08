class AuctionsController < ApplicationController
	skip_before_filter :require_login

	def index
		if (params[:search].blank?)
			@auctions = Auction.order("end_time desc").page(params[:page]).per(params[:num_per_page])
		else
			@auctions = Auction.search(params[:search], order: :end_time, sort_mode: :desc).page(params[:page]).per(params[:num_per_page])
		end

		@auctions.delete_if do |auction|
			params[:price_min].to_f > (!auction.current_bid_id.nil? ? Bid.find_by_id(auction.current_bid_id).amount : auction.starting_bid_price)
		end unless params[:price_min].blank? or @auctions.empty?

		@auctions.delete_if do |auction|
			params[:price_max].to_f < (!auction.current_bid_id.nil? ? Bid.find_by_id(auction.current_bid_id).amount : auction.starting_bid_price)
		end unless params[:price_max].blank? or @auctions.empty?

		@auctions.delete_if do |auction|
			auction.end_time < Time.now()
		end unless !params[:show_ended].blank? or @auctions.empty?

		@current_user = current_user
	end

	def show
		if params[:id] === 'bids'
			redirect_to root_url
		elsif !(@auction = Auction.find_by_id params[:id])
			redirect_to "/404.html"
		end
	end
end
