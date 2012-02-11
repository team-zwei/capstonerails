# == Schema Information
#
# Table name: bids
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Bid < ActiveRecord::Base
	belongs_to :auction
end
