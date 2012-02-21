# == Schema Information
#
# Table name: auctions
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :string(255)
#  start_time  :datetime
#  end_time    :datetime
#

class Auction < ActiveRecord::Base
  has_many :bids
  has_many :users, through: :bids, as: :bidders
end
