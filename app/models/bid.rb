# == Schema Information
#
# Table name: bids
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  amount     :decimal(15, 2)
#  auction_id :integer
#  user_id    :integer
#

class Bid < ActiveRecord::Base
	attr_accessible :amount
  belongs_to :auction
  belongs_to :user

  before_save :validate_bid_amount
  before_save :validate_end_time

  def validate_bid_amount
    auction = self.auction
    amount  = self.amount
    bid_id     = auction.current_bid_id
    if bid_id
      ((Bid.find_by_id(bid_id).amount + auction.minimum_bid_increment) > amount) ? true : false
    else
      (auction.starting_bid_price >= amount) ? true : false
    end
  end

  def validate_end_time
    return self.end_time > Time.now()
  end
end
