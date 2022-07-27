class ChangeUserContactToBingint < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :contact, :bigint
  end
end
