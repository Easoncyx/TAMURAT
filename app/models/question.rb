class Question < ApplicationRecord
  belongs_to :subcategory, class_name: "Subcategory"
  validates :name,  presence: true, length: { maximum: 256 }
  validates :weight, presence: true, format:{ with: /\A[0-9]*(.[0-9]*)?\z/ }
end
