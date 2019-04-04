class AddIndexToUsersLoginId < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :login_id, unique: true
  end
end
