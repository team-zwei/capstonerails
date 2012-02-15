class AddUserIdToBids < ActiveRecord::Migration
  def change
  	add_column :bids, :user_id, :integer
  end
end
