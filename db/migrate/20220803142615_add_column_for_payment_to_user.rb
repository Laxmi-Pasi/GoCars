class AddColumnForPaymentToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :payment_gateway, :integer
  end
end
