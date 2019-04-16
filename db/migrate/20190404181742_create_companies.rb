class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.references :user, foreign_key: true
      t.boolean :validated
      t.float :weight_sum
      t.references :parent, index: true
      t.float :score, default: 0.0
      t.timestamps
    end
  end
end
