class Payment < ActiveRecord::Base
	belongs_to :auction
	belongs_to :user
	has_one    :payment_method

	attr_accessible :stripe_card_token, :stripe_card_last4
end
