class CreateScenarioWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :scenario_weights do |t|
      t.references :company, null: false
      t.references :scenario, null: false
      t.float :weight, default: 1

      t.timestamps
    end
  end
end
