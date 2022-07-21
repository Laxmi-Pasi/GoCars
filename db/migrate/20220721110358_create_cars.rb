class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :company
      t.string :model
      t.date :purchase_date
      t.integer :engine_type
      t.integer :car_type
      t.integer :seats
      t.integer :distance_driven
      t.integer :transmission_type
      t.text :car_description
      t.string :registered_number

      t.timestamps
    end
  end
end
