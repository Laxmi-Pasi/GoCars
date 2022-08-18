class CreatePsps < ActiveRecord::Migration[7.0]
  def change
    create_table :psps do |t|
      t.integer :payment_gateway

      t.timestamps
    end
  end
end
