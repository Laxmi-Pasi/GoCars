class RenameTransactionsToCarTransactions < ActiveRecord::Migration[7.0]
  def self.up
    rename_table :transactions, :car_transactions
  end

  def self.down
    rename_table :car_transactions, :transactions
  end
end
