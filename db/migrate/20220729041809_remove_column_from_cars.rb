class RemoveColumnFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :main_car_image
  end
end
