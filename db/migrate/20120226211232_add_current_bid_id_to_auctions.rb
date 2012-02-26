class AddCurrentBidIdToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :current_bid_id, :integer

  end
end
