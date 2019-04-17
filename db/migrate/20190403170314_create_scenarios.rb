class CreateScenarios < ActiveRecord::Migration[5.1]
  def change
    create_table :scenarios do |t|
      t.string :name
      t.text :description
      t.float :score, default: 0.0
      t.timestamps
    end
  end
end
