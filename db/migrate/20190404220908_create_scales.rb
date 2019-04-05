class CreateScales < ActiveRecord::Migration[5.1]
  def change
    create_table :scales do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.string :level
      t.float :score

      t.timestamps
    end
  end
end
