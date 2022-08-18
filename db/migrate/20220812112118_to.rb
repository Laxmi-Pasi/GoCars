class To < ActiveRecord::Migration[7.0]
  def change
    add_column :psps, :type, :string
    remove_column :psps, :payment_gateway
  end
end
