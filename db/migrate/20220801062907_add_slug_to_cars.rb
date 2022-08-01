class AddSlugToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :slug, :string
    add_index :cars, :slug, unique: true
  end
end
