class AddStartTimeAndEndTimeToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :start_time, :datetime
    add_column :auctions, :end_time, :datetime
  end
end
