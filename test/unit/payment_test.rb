# == Schema Information
#
# Table name: payments
#
#  id                :integer         not null, primary key
#  user_id           :integer
#  auction_id        :integer
#  payment_method_id :integer
#  amount            :decimal(15, 2)
#  charge_id         :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
