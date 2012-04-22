class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :auction_image
      t.string :title
      t.integer :auction_id
      t.timestamps
    end
  end
end
