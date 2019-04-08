class Question < ApplicationRecord
  belongs_to :subcategory, class_name: "Subcategory"
  has_many :answers, class_name: "Answer", :foreign_key => :question_id, :dependent => :destroy
  validates :name,  presence: true, length: { maximum: 512 }
  validates :weight, presence: true, format:{ with: /\A[0-9]*(.[0-9]*)?\z/ }
end
