class CreateAuctionsCategoriesJoin < ActiveRecord::Migration
  def up
    create_table :auctions_categories, id: false do |t|
      t.integer :auction_id
      t.integer :category_id
    end
  end

  def down
  end
end
