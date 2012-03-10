class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :email
      t.string    :username
      t.string    :firstname
      t.string    :lastname
      t.string    :password_digest
      t.string    :password_reset_token
      t.datetime  :password_reset_sent_at
      t.string    :auth_token
      t.boolean   :admin

      t.timestamps
    end

    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
    add_index "users", ["username"], :name => "index_users_on_username", :unique => true
  end
end
