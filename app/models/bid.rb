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

  def validate_bid_amount
    bid_id = self.auction.current_bid_id

    bid_id ? ((Bid.find_by_id(bid_id).amount + self.auction.minimum_bid_increment) <= self.amount) : (self.auction.starting_bid_price <= self.amount)
  end

  def validate_end_time
    self.auction.end_time > Time.now()
  end

  def get_username
    User.find_by_id(self.user_id).username
  end
end
