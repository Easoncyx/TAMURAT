class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :name
      t.integer :subcategory_id, unique: true
      t.float :weight, default: 0

      t.timestamps
    end
    add_index :questions, :subcategory_id, unique: true
  end
end
