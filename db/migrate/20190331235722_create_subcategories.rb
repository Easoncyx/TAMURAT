class CreateSubcategories < ActiveRecord::Migration[5.1]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.float :weight, default: 0
      t.float :weight_sum, default: 0
      
      t.timestamps
    end

  end
end
