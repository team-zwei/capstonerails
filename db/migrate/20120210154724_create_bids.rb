class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|

      t.timestamps
    end
  end
end
