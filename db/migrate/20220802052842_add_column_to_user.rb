class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :Secret_key, :string
    add_column :users, :Public_key, :string
  end
end
