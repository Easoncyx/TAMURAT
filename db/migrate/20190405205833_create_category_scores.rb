class CreateCategoryScores < ActiveRecord::Migration[5.1]
  def change
    create_table :category_scores do |t|

      t.timestamps
    end
  end
end
