class Subcategory < ApplicationRecord
  belongs_to :category, class_name: "Category"
  has_many :questions, class_name: "Question", foreign_key: "subcategory_id", dependent: :destroy
  has_many :subcategory_scores, class_name: "SubcategoryScore", foreign_key: "subcategory_id", dependent: :destroy
  
  VALID_WEIGHT_REGEX = /\A[0-9]+(.[0-9]*)?\z/
  validates :name,  presence: true, length: { maximum: 256 }
  validates :weight_sum, presence: true, format:{ with: VALID_WEIGHT_REGEX }
  validates :weight, presence: true, format:{ with: VALID_WEIGHT_REGEX }
  
  def self.valid_weight_regex
    @regex = VALID_WEIGHT_REGEX
  end
end
