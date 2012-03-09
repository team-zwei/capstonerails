class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string    :name
      t.string    :description
      t.datetime  :start_time
      t.datetime  :end_time
      t.decimal   :starting_bid_price, precision: 15, scale: 2
      t.decimal   :minimum_bid_increment, precision: 15, scale: 2
      t.integer   :current_bid_id
      t.integer   :winner_id

      t.timestamps
    end
  end
end
