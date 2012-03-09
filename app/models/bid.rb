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

  def validate_bid_amount
    if self.auction.current_bid_id
      return ((Bid.find_by_id(self.auction.current_bid_id).amount + self.auction.minimum_bid_increment) > self.amount) ? true : false
    else
      return (self.auction.starting_bid_price >= self.amount) ? true : false
    end
  end
end
