# == Schema Information
#
# Table name: payment_methods
#
#  id                    :integer         not null, primary key
#  user_id               :integer
#  stripe_customer_token :string(255)
#  last4                 :integer
#  expiration            :datetime
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#

class PaymentMethods < ActiveRecord::Base
	has_many :payments
	has_one  :user
end
