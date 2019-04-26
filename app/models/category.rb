class Category < ApplicationRecord

  has_many :subcategories, class_name: "Subcategory", foreign_key: "category_id", dependent: :destroy
  has_many :scales, dependent: :destroy
  has_many :category_scores, class_name: "CategoryScore", foreign_key: "category_id", dependent: :destroy

  validates :name,  presence: true, length: { maximum: 256 }


  validates :weight_sum, presence: true, format:{ with: self.valid_weight_regex }
  validates :weight, presence: true, format:{ with: self.valid_weight_regex }


end
