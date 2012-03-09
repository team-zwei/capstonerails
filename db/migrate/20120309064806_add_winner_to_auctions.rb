class AddWinnerToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :winner_id, :integer

  end
end
