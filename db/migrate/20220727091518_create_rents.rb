class CreateRents < ActiveRecord::Migration[7.0]
  def change
    create_table :rents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.float :no_of_days, :null => false
      t.float :Total_Price
      t.timestamps
    end
  end
end
