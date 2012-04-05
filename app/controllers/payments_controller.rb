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

    if auction.payment.blank? # if no payment for this auction exists
			begin
        charge_params = {
          amount:       (amount * 100).to_i,
          currency:     "usd",
          description:  "RWSAuctions: " + auction.name # TODO: Add site info
        }
        if !params[:save_card].blank?
          charge_params[:customer] = current_user.add_payment_method(params[:stripe_card_token], params[:stripe_card_last4].to_i)
        else
          charge_params[:card] = params[:stripe_card_token]
        end
        charge = Stripe::Charge.create(charge_params)

        if (auction.payment = Payment.create user_id: current_user, amount: amount, charge_id: charge.id)
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
		else # a payment for this auction already exists
			# TODO: display error for already paid, really, this shouldn't happen
			redirect_to root_url, error: "ALREADY PAID FOR THIS AUCTION"
		end
  end

  def show
  	@auction = Auction.find_by_id(params[:auction_id])
  	@payment = @auction.payment
  end
end
