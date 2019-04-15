class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :answer_id
      t.integer :evidence_id
      t.text    :comment

      t.timestamps
    end
    add_index :relationships, :answer_id
    add_index :relationships, :evidence_id
    add_index :relationships, [:answer_id, :evidence_id], unique: true
  end
end
