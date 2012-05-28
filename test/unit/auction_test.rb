# == Schema Information
#
# Table name: auctions
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  description           :string(255)
#  terms                 :text
#  start_time            :datetime
#  end_time              :datetime
#  starting_bid_price    :decimal(15, 2)
#  minimum_bid_increment :decimal(15, 2)
#  current_bid_id        :integer
#  winner_id             :integer
#  data                  :text
#  token                 :string(255)
#  time_increment        :integer
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  status                :string(255)
#

require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
