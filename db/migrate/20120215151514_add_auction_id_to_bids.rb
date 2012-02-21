class AddAuctionIdToBids < ActiveRecord::Migration
  def change
  	add_column :bids, :auction_id, :integer
  end
end
