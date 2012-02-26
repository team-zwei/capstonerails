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

  def add_to_end_time!(seconds)
  	# Adds seconds to the end time
  	self.end_time = self.end_time + seconds
  end

  def get_remaining_time
  	# Returns seconds
  	time = self.end_time - Time.now()
    time = 0 if time < 0
    time
  end

  def get_hours
    (self.get_remaining_time / 3600).to_i
  end

  def get_minutes
    (self.get_remaining_time / 60 % 60).to_i
  end

  def get_seconds
    (self.get_remaining_time % 60).to_i
  end

  def get_time_string
    ("%02d" % self.get_hours) + ":" + ("%02d" % self.get_minutes) + ":" + ("%02d" % self.get_seconds)
  end
  
end
