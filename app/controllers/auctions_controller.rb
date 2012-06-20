class AuctionsController < ApplicationController
	skip_before_filter :require_admin, only: [:index, :show]
	skip_before_filter :require_login, only: [:index, :show]
	before_filter :require_auction_token, only: [:update, :confirm, :publish, :cancel]

	def index
		# Filter by text search
		@auctions = if (params[:search].blank?)
						Auction.where("start_time <= now()").order("end_time desc").page(params[:page]).per(params[:num_per_page])
					else
						Auction.search(params[:search], order: :end_time, sort_mode: :desc).page(params[:page]).per(params[:num_per_page])
					end

		# Filter by minimum price
		@auctions.delete_if do |auction|
			params[:price_min].to_f > (auction.current_bid ? auction.current_bid.amount : auction.starting_bid_price)
		end unless params[:price_min].blank? or @auctions.empty?

		# Filter by maximum price
		@auctions.delete_if do |auction|
			params[:price_max].to_f < (auction.current_bid ? auction.current_bid.amount : auction.starting_bid_price)
		end unless params[:price_max].blank? or @auctions.empty?

		# Filter by categories
		@auctions.delete_if do |auction|
			# auction.categories.each do |cat|
			# 	if ((params[:categories]).length > 0)
			# 		true
			# 	else 
			# 		false
			# 	end

			(auction.categories.map{|cat| cat.id.to_s} & params[:categories]).empty?
		end unless params[:categories].blank? or @auctions.empty?

		# Filter by ended
		@auctions.delete_if { |auction| auction.end_time < Time.now() } unless !params[:show_ended].blank? or @auctions.empty?

		# Display chosen categories
		@category_ids = params[:categories] if params[:categories]
	end

	def show
		if params[:id] === 'bids'
			redirect_to root_url
		elsif !(@auction = Auction.find_by_id params[:id])
			redirect_to "/404.html"
		else
			@current_bidder = @auction.current_bid.user if @auction.current_bid
		end
	end

	def new
		@auction = Auction.new 
	end

	def create
		@auction = Auction.new params[:auction]
		
		params[:categories].each do |category_id|
			@auction.categories << Category.find_by_id(category_id)
		end if params[:categories]

		# @auction.end_time      = params[:] || (Time.now() + 600)
		@auction.start_time    = Time.now()
		@auction.token         = session[:auction_token] = SecureRandom.urlsafe_base64
		@auction.data          = params[:data]
		@auction.main_image_id = params[:auction_image_main]

		if @auction.save
			redirect_to new_auction_image_path @auction
		else
			redirect_to action: :new, alert: "Error creating auction! Please try again. If this persists, contact customer support."
		end
	end

	def edit
		@auction = Auction.find_by_id params[:id]
	end

	def update
		@auction = Auction.find_by_id params[:id]
	end

	def destroy
		redirect_to root_url, notice: "Auction destroyed"
	end

	def cancel
		Auction.find_by_id(params[:id]).destroy
		session[:auction_token] = nil
		redirect_to root_url, notice: "Auction creation cancelled"
	end

	def confirm
		@auction = Auction.find_by_id params[:id]
		if @auction.blank?
			redirect_to auctions_url
		end
		
		@images = @auction.images
	end

	def publish

		@auction = Auction.find_by_id params[:id]

		@auction.start_time = Time.new(params[:start][:year],
													params[:start][:month],
													params[:start][:day],
													params[:start][:hour],
													params[:start][:minute])

		@auction.end_time = Time.new(params[:end][:year],
													params[:end][:month],
													params[:end][:day],
													params[:end][:hour],
													params[:end][:minute])

		@auction.name = params[:auction][:name]
		@auction.description = params[:auction][:description]
		@auction.minimum_bid_increment = params[:auction][:minimum_bid_increment]
		@auction.starting_bid_price = params[:auction][:starting_bid_price]
		@auction.main_image = Image.find params[:auction_image_main]

		@auction.save!

		params[:auction_image_title].each do |id, title|
			Image.find_by_id(id).update_attribute :title, title
		end if params[:auction_image_title]

		@auction.update_attribute(:token, nil)
		session[:auction_token] = nil

		render :show, notice: "Auction successfully created!"

		# TODO: Get UI to allow setting a main and displaying images
		# Image.find_by_id(params[:main_image_id]).update_attribute("main", true)
	end
end
