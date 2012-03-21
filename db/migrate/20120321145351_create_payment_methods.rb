class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.int :user_id
      t.string :stripe_customer_token
      t.int :last4
      t.datetime :expiration

      t.timestamps
    end
  end
end
