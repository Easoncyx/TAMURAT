class CreatePrivileges < ActiveRecord::Migration[5.1]
  def change
    create_table :privileges do |t|
      t.integer :scenario_id
      t.integer :user_id

      t.timestamps
    end
  end
end
