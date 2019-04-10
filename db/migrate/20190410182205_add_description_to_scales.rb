class AddDescriptionToScales < ActiveRecord::Migration[5.1]
  def change
    add_column :scales, :description, :string
  end
end
