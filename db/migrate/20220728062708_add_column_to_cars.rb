class AddColumnToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :main_car_image, :string
  end
end
