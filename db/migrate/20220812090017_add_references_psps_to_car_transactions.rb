class AddReferencesPspsToCarTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :car_transactions, :psp, null: false, foreign_key: true
  end
end
