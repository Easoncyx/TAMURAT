class AddCategoryIdToSubcategories < ActiveRecord::Migration[5.1]
  def change
<<<<<<< HEAD
    add_column :subcategories, :category_id, :integer, 
    add_index :subcategories, :category_id, unique: true
=======
    add_column :subcategories, :category_id, :integer
    add_index :subcategories, :category_id
>>>>>>> 3a34cd36ee5091fd3165edab302ea3b06b608072
  end
end
