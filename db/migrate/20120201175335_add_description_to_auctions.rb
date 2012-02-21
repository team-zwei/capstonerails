class AddDescriptionToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :description, :string

  end
end
