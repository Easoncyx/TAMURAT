class Category < ApplicationRecord
  
  has_many :subcategories, class_name: "Subcategory", foreign_key: "category_id"
end
