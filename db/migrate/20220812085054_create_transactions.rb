class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :car_id
      t.integer :owner_id
      t.integer :buyer_id
      t.integer :renter_id
      t.integer :status, :default => 0
      #Ex:- :default =>''
      t.text :error_msg
      t.string :response_token
      t.timestamps
    end
  end
end
