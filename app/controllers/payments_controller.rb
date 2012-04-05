class PaymentsController < ApplicationController
  def new
  	#  TODO: Filter if a payment has already been submitted
  	@payment = Payment.new
  	@auction = Auction.find_by_id(params[:auction_id])
  	@price = Bid.find_by_id(@auction.current_bid_id).amount
  end

  def create
		begin
      auction = Auction.find_by_id(params[:auction_id])
      amount = Bid.find_by_id(auction.current_bid_id).amount

      charge_params = {
        amount:       (amount * 100).to_i,
        currency:     "usd",
        description:  "RWSAuctions: " + auction.name # TODO: Add site info
      }
			if !params[:save_card].blank?
        # create customer and save payment
        payment_method = Stripe::Customer.create(
          :description => current_user.email,
          :card => params[:stripe_card_token] # obtained with Stripe.js
        )
        charge_params[:customer] = payment_method
      else
        charge_params[:card] = params[:stripe_card_token]
      end
      charge = Stripe::Charge.create(charge_params)

      if (auction.payment = Payment.create user_id: current_user, amount: amount, charge_id: charge.id)
        # render success page
        # TODO: Redirect to a "confirmation page" and display any relevant info
        redirect_to auction_payment_path(auction), notice: "Successful Charge"
      else
        # render error page
        # TODO: Redirect to a "confirmation page" and display any relevant info
        redirect_to root_url, error: "UNSUCCESSFUL CHARGE"
      end

		rescue Stripe::InvalidRequestError => e
		  Rails.logger.error "Stripe error while creating charge: #{e.message}"
		  # TODO: Redirect to a "confirmation page" and display any relevant info
		  redirect_to root_url, error: "UNSUCCESSFUL CHARGE"
		end
  end

  def show
  	@auction = Auction.find_by_id(params[:auction_id])
  	@payment = @auction.payment
  end
end
