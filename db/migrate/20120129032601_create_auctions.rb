class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string    :name
      t.string    :description
      t.text      :terms
      t.datetime  :start_time
      t.datetime  :end_time
      t.decimal   :starting_bid_price, precision: 15, scale: 2
      t.decimal   :minimum_bid_increment, precision: 15, scale: 2
      t.integer   :current_bid_id
      t.integer   :winner_id
      t.text      :data
      t.string    :token
      t.integer   :time_increment

      t.timestamps
    end
  end
end
