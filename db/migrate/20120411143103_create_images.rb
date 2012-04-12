class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :auction_image
      t.integer :auction_id
      t.timestamps
    end
  end
end
