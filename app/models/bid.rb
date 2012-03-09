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

  before_save :validate

  def validate
  	current_bid_amount = Bid.find_by_id((self.auction.current_bid_id) ? self.auction.current_bid_id : self.auction.starting_bid_price).amount
  	minimum_bid_increment = self.auction.minimum_bid_increment

  	if self.amount < (current_bid_amount + minimum_bid_increment) || 
      self.end_time < Time.now()
  		false
  	else
  		true
  	end
  end
end
