# == Schema Information
#
# Table name: auctions
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  description           :string(255)
#  terms                 :text
#  start_time            :datetime
#  end_time              :datetime
#  starting_bid_price    :decimal(15, 2)
#  minimum_bid_increment :decimal(15, 2)
#  current_bid_id        :integer
#  winner_id             :integer
#  data                  :text
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  status                :string(255)
#

class Auction < ActiveRecord::Base
  serialize :data, Hash

  has_many :bids
  has_many :users, through: :bids, as: :bidders
  has_and_belongs_to_many :categories
  has_many :images
  has_one :payment

  attr_accessible :name, :description, :terms, :starting_bid_price, :minimum_bid_increment, :data, :end_time, :start_time, :time_increment

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

  def get_min_bid
    self.minimum_bid_increment
  end

  def set_new_price(new_bid)
    if new_bid < self.get_min_bid
      new_bid = 0
    end      
    new_price = self.get_current_price + new_bid
    Bid.find_by_id(self.current_bid_id).update_attribute(:amount, new_price)   
  end

  def get_min_new_price
    if self.current_bid_id
      amount = Bid.find_by_id(self.current_bid_id).amount 
    else
      amount = self.starting_bid_price
    end
    min_new_price = self.minimum_bid_increment + amount
    ("%.2f" % min_new_price).gsub(/(\d)(?=(\d{3})+(.\d{2})$)/, '\1,')
  end
  
end
