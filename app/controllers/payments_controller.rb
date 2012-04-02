class PaymentsController < ApplicationController
  def new
  	@payment = Payment.new
  	@auction = Auction.find_by_id(params[:auction_id])
  end

  def create
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
