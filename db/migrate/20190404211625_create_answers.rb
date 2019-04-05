class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :company_id
      t.integer :question_id
      t.integer :level
      t.boolean :validated
      t.integer :validator_id
      t.string :validator_comment

      t.timestamps
    end
  end
end
