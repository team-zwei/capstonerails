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
end
