class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer  :user_id
      t.integer  :auction_id
      t.integer  :payment_method_id
      t.decimal  :amount, precision: 15, scale: 2
      t.string   :charge_id
      t.timestamps
    end
  end
end
