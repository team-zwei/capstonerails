class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :name
    	t.string :path
    	t.string :auction_image

      t.timestamps
    end
  end
end
