class CreateSubcompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :subcompanies do |t|
      t.integer :parent_company_user_id, null: false
      t.integer :child_company_user_id, unique: true, null: false

      t.timestamps
    end
    add_index :subcompanies, :parent_company_user_id
    add_index :subcompanies, :child_company_user_id, unique: true
  end
end
