class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.references :user, foreign_key: true
      t.float :company_score
      t.boolean :validated
      t.float :weight_sum
      t.references :parent, index: true
      t.timestamps
    end
  end
end
