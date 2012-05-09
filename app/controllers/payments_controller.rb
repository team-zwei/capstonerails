class PaymentsController < ApplicationController
  skip_before_filter :require_admin
  def new
    @auction = Auction.find_by_id(params[:auction_id])

    redirect_to root_url, alert: 'Insufficient priviledges' unless current_user.id == @auction.winner_id

  	#  TODO: Filter if a payment has already been submitted
  	@payment = Payment.new	
  	@price = Bid.find_by_id(@auction.current_bid_id).amount
    @user = current_user

    if current_user.payment_methods
      @saved_cards = current_user.payment_methods
    end
  end

  def create
  	auction = Auction.find_by_id(params[:auction_id])

    redirect_to root_url, alert: 'Insufficient priviledges' unless current_user.id == auction.winner_id

    amount = Bid.find_by_id(auction.current_bid_id).amount

    if auction.payment.blank? # if no payment for this auction exists
			begin
        charge_params = {
          amount:       (amount * 100).to_i,
          currency:     "usd",
          description:  "RWSAuctions: " + auction.name # TODO: Add site info
        }

        if params[:use_saved_card] # Submit charge using active card
          card_info = params[:use_saved_card].split('_')
          charge_params[:customer] = current_user.payment_methods.where("card_type = ? and last4 = ?", card_info[0], card_info[1]).stripe_customer_token
        else # Submit charge without using saved payment
          if !params[:save_card].blank?
            charge_params[:customer] = current_user.add_payment_method(params[:stripe_card_token], params[:stripe_card_last4].to_i, params[:stripe_card_type])
          else
            charge_params[:card] = params[:stripe_card_token]
          end
        end
        
        charge = Stripe::Charge.create(charge_params)

        if (auction.payment = Payment.create user_id: current_user, amount: amount, charge_id: charge.id)
          redirect_to auction_payment_path(auction), notice: "Successful Charge"
        else
          # TODO: Redirect to a "confirmation page" and display any relevant info
          redirect_to root_url, alert: "UNSUCCESSFUL CHARGE"
        end
        
			rescue Stripe::InvalidRequestError => e
			  Rails.logger.error "Stripe error while creating charge: #{e.message}"
			  # TODO: Redirect to a "confirmation page" and display any relevant info
			  redirect_to root_url, alert: "UNSUCCESSFUL CHARGE"
			end
		else # a payment for this auction already exists
			# TODO: display error for already paid, really, this shouldn't happen
			redirect_to root_url, alert: "ALREADY PAID FOR THIS AUCTION"
    end
  end

  def show
    redirect_to root_url, alert: 'Insufficient priviledges' unless current_user.id == auction.winner_id

  	@auction = Auction.find_by_id(params[:auction_id])
  	@payment = @auction.payment
  end
end
