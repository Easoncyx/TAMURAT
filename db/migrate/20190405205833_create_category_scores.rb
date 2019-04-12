class CreateCategoryScores < ActiveRecord::Migration[5.1]
  def change
    create_table :category_scores do |t|
      t.float :score
      t.integer :company_id
      t.integer :category_id
      t.timestamps
    end
  end
end
