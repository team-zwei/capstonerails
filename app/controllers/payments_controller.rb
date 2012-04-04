class PaymentsController < ApplicationController
  def new
  	#  TODO: Filter if a payment has already been submitted
  	@payment = Payment.new
  	@auction = Auction.find_by_id(params[:auction])
  	@price = Bid.find_by_id(@auction.current_bid_id).amount
  end

  def create
  	# Payments Model:
  	#  id                :integer         not null, primary key
		#  user_id           :integer
		#  auction_id        :integer
		#  payment_method_id :integer
		#  stripe_card_token :string(255)
		#  created_at        :datetime        not null
		#  updated_at        :datetime        not null

		@payment = Payment.new

		@payment.user_id = current_user
		@payment.auction_id = params[:auction_id]
		@payment.stripe_card_token = params[:stripe_card_token]

		auction = Auction.find_by_id(params[:auction_id])

		begin
			Stripe::Charge.create(
				:amount => Bid.find_by_id(auction.current_bid_id).amount,
				:currency => "usd",
				:card => params[:stripe_card_token],
				:description => auction.name # TODO: Add site info
			)
		rescue Stripe::InvalidRequestError => e
		  logger.error "Stripe error while creating customer: #{e.message}"
		  errors.add :base, "There was a problem processing your credit card.  If this persists, contact support."
		  false
		end

		if !@payment.save!
			# error
		else
			# success
		end
  end

  def show
  end

  def index
  end
end
