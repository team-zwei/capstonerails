class AddStartingBidPriceToAuctions < ActiveRecord::Migration
  def change
  	add_column :auctions, :starting_bid_price, :decimal, precision: 15, scale: 2
  end
end
