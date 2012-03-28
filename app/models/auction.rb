# == Schema Information
#
# Table name: auctions
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  description           :string(255)
#  start_time            :datetime
#  end_time              :datetime
#  starting_bid_price    :decimal(15, 2)
#  minimum_bid_increment :decimal(15, 2)
#  current_bid_id        :integer
#  winner_id             :integer
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#

class Auction < ActiveRecord::Base
  has_many :bids
  has_many :users, through: :bids, as: :bidders
  has_and_belongs_to_many :categories

  has_one :payment

  define_index do
    indexes :name, sortable: true
    indexes :description    

    has created_at, updated_at, start_time, end_time
  end

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

  def get_current_price
    if self.current_bid_id
      amount = Bid.find_by_id(self.current_bid_id).amount 
    else
      amount = self.starting_bid_price
    end
    ("%.2f" % amount).gsub(/(\d)(?=(\d{3})+(.\d{2})$)/, '\1,')
  end

  def set_new_price
    # add code
    
  end
  
end
