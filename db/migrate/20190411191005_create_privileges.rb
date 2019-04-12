class CreatePrivileges < ActiveRecord::Migration[5.1]
  def change
    create_table :privileges do |t|
      t.integer :user_id
      t.integer :scenario_id

      t.timestamps
    end
    add_index :privileges, :user_id
    add_index :privileges, :scenario_id
    add_index :privileges, [:user_id, :scenario_id], unique: true
  end
end
