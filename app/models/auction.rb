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
#  token                 :string(255)
#  time_increment        :integer
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  status                :string(255)
#

class Auction < ActiveRecord::Base
  serialize :data, Hash

  has_one :payment
  belongs_to :main_image, class_name: "Image"
  belongs_to :current_bid, class_name: "Bid"
  has_many :bids
  has_many :users, through: :bids, as: :bidders
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :categories  

  accepts_nested_attributes_for :images

  attr_accessible :name, :description, :terms, :starting_bid_price, :minimum_bid_increment, :data, :end_time, :start_time, :time_increment, :main_image

  define_index do
    indexes :name, sortable: true
    indexes :description    
    has created_at, updated_at, start_time, end_time
  end

  def add_to_end_time!(seconds)
  	end_time += seconds # Adds seconds to the end time
  end

  def seconds_left
  	time = end_time - Time.now()
    time > 0 ? time : 0 # Returns seconds
  end

  def time_remaining
    time = "%02d" % (seconds_left / 3600).to_i             #hours
    time += ":" + ("%02d" % (seconds_left / 60 % 60).to_i) #minutes
    time += ":" + ("%02d" % (seconds_left % 60).to_i)      #seconds
  end

  def current_price
    format_price price
  end

  def new_minimum_bid
    format_price(minimum_bid_increment + price)
  end

  def price
    current_bid_id ? Bid.find_by_id(current_bid_id).amount : starting_bid_price
  end

  def format_price(amount)
    ("%.2f" % amount).gsub(/(\d)(?=(\d{3})+(\.(\d+)?)?$)/, '\1,')
  end
end
