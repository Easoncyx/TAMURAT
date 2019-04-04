class CreateSubcategories < ActiveRecord::Migration[5.1]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.float :weight
      t.float :weight_sum
      
      t.timestamps
    end
  end
end
