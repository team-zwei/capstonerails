class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer  :user_id
      t.integer  :auction_id
      t.integer  :payment_method_id
      t.string   :stripe_card_token
      t.timestamps
    end
  end
end
