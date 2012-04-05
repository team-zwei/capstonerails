class PaymentsController < ApplicationController
  def new
  	#  TODO: Filter if a payment has already been submitted
  	@payment = Payment.new
  	@auction = Auction.find_by_id(params[:auction_id])
  	@price = Bid.find_by_id(@auction.current_bid_id).amount
  end

  def create

		auction = Auction.find_by_id(params[:auction_id])
		amount = Bid.find_by_id(auction.current_bid_id).amount

		@payment = Payment.new
		@payment.user_id = current_user
		@payment.auction_id = params[:auction_id]
		@payment.amount = amount

		begin
			charge = Stripe::Charge.create(
				# Find amount and change to integer of cents
				:amount => (amount * 100).to_i,
				:currency => "usd",
				:card => params[:stripe_card_token],
				:description => "RWSAuctions: " + auction.name # TODO: Add site info
			)

			@payment.charge_id = charge.id
		rescue Stripe::InvalidRequestError => e
		  Rails.logger.error "Stripe error while creating charge: #{e.message}"
		  # TODO: Redirect to a "confirmation page" and display any relevant info
		  redirect_to root_url, error: "UNSUCCESSFUL CHARGE"
		end

		if @payment.save!
			# render success page
			if !params[:save_card].blank?
				# create customer and save payment
			end

			# TODO: Redirect to a "confirmation page" and display any relevant info
			redirect_to auction_payment_path(auction), notice: "Successful Charge"
		else
			# render error page
			# TODO: Redirect to a "confirmation page" and display any relevant info
			redirect_to root_url, error: "UNSUCCESSFUL CHARGE"
		end
  end

  def show
  	@auction = Auction.find_by_id(params[:auction_id])
  	@payment = @auction.payment
  end

  def index
  end
end
