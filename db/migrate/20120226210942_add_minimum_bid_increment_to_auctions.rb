class AddMinimumBidIncrementToAuctions < ActiveRecord::Migration
  def change
  	add_column :auctions, :minimum_bid_increment, :decimal, precision: 15, scale: 2
  end
end
