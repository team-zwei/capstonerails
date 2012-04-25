# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)
#  username               :string(255)
#  firstname              :string(255)
#  lastname               :string(255)
#  password_digest        :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  stripe_customer_token  :string(255)
#  auth_token             :string(255)
#  admin                  :boolean
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
