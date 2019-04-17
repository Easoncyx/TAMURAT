class CreateCategoryScores < ActiveRecord::Migration[5.1]
  def change
    create_table :category_scores do |t|
      t.float :score
      t.integer :company_id
      t.integer :category_id
      t.timestamps
    end
    add_index :category_scores, :company_id
    add_index :category_scores, :category_id
  end
end
