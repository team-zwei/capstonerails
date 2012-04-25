class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :auction_image
      t.string :title
      t.integer :auction_id
      t.boolean :main, default: false
      t.timestamps
    end
  end
end
