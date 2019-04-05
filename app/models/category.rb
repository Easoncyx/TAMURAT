class Category < ApplicationRecord

  has_many :subcategories, class_name: "Subcategory", foreign_key: "category_id", dependent: :destroy
  has_many :scales, dependent: :destroy
  
  validates :name,  presence: true, length: { maximum: 256 }
  validates :weight_sum, presence: true, format:{ with: /\A[0-9]*(.[0-9]*)?\z/ }

end
