class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name
      t.string :id

      t.timestamps
    end
  end
end
