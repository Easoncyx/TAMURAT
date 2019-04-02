class Subcategory < ApplicationRecord
  belongs_to :category, class_name: "Category"
  has_many :questions, class_name: "Question", foreign_key: "subcategory_id"
end
