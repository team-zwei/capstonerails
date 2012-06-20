# == Schema Information
#
# Table name: bids
#
#  id         :integer         not null, primary key
#  amount     :decimal(15, 2)
#  auction_id :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Bid < ActiveRecord::Base
	attr_accessible :amount
  belongs_to :auction
  belongs_to :user

  before_save :validate_bid_amount, :validate_end_time
  after_save :increment_auction_time

  def validate_bid_amount
    if auction.current_bid_id
      (Bid.find_by_id(auction.current_bid_id).amount + auction.minimum_bid_increment) <= amount
    else
      auction.starting_bid_price <= amount
    end
  end

  def validate_end_time
    auction.end_time > Time.now()
  end

  def increment_auction_time
    auction.increment_time
  end
end
