class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.integer :user_id
      t.string :stripe_customer_token
      t.string :card_type
      t.integer :last4
      t.datetime :expiration

      t.timestamps
    end
  end
end
