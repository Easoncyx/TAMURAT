class Subcategory < ApplicationRecord
  belongs_to :category, class_name: "Category"
  has_many :questions, class_name: "Question", foreign_key: "subcategory_id", dependent: :destroy
  
  validates :name,  presence: true, length: { maximum: 256 }
  validates :weight_sum, presence: true, format:{ with: /\A[0-9]*(.[0-9]*)?\z/ }
  validates :weight, presence: true, format:{ with: /\A[0-9]*(.[0-9]*)?\z/ }
end
