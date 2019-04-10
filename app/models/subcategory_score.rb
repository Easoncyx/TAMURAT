class SubcategoryScore < ApplicationRecord
  belongs_to :company, class_name: "Company"
  belongs_to :subcategory, class_name: "Subcategory"
end
