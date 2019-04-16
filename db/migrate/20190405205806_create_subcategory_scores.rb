class CreateSubcategoryScores < ActiveRecord::Migration[5.1]
  def change
    create_table :subcategory_scores do |t|
      t.float :score
      t.integer :company_id
      t.integer :subcategory_id
      t.timestamps
    end
    add_index :subcategory_scores, :company_id
    add_index :subcategory_scores, :subcategory_id
  end
end
