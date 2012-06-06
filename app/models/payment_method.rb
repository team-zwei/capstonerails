# == Schema Information
#
# Table name: payment_methods
#
#  id                    :integer         not null, primary key
#  user_id               :integer
#  stripe_customer_token :string(255)
#  card_type             :string(255)
#  last4                 :integer
#  expiration            :datetime
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#

class PaymentMethod < ActiveRecord::Base
	has_many :payments
	belongs_to  :user

	before_destroy :delete_stripe_customer

	def delete_stripe_customer
		Stripe::Customer.retrieve(stripe_customer_token).delete
	end
end
