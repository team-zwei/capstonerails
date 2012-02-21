class AddAmountToBids < ActiveRecord::Migration
  def change
  	add_column :bids, :amount, :decimal, precision: 15, scale: 2
  end
end
