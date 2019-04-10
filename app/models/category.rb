class Category < ApplicationRecord

  has_many :subcategories, class_name: "Subcategory", foreign_key: "category_id", dependent: :destroy
  has_many :scales, dependent: :destroy
  VALID_WEIGHT_REGEX = /\A[0-9]+(.[0-9]*)?\z/
  validates :name,  presence: true, length: { maximum: 256 }
  
  
  validates :weight_sum, presence: true, format:{ with: VALID_WEIGHT_REGEX }
  validates :weight, presence: true, format:{ with: VALID_WEIGHT_REGEX }
  
  
  def self.valid_weight_regex
    @regex = VALID_WEIGHT_REGEX
  end
end
