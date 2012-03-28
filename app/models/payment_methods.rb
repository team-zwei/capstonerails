class PaymentMethods < ActiveRecord::Base
	has_many :payments
	has_one  :user
end
