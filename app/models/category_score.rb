class CategoryScore < ApplicationRecord
  belongs_to :company, class_name: "Company"
  belongs_to :category, class_name: "Category"
end
