class CreateSubcategoryScores < ActiveRecord::Migration[5.1]
  def change
    create_table :subcategory_scores do |t|
      
      t.timestamps
    end
  end
end
