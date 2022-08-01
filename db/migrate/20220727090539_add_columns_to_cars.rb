class AddColumnsToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :owner_id, :integer, null: false
    add_column :cars, :purpose, :text, array: true, default: []
    add_column :cars, :sell_price, :float
    add_column :cars, :buyer_id, :integer, null: true
    add_column :cars, :car_status, :integer, default: 0
    add_column :cars, :rent_price, :float      
  end
end
