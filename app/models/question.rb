class Question < ApplicationRecord
  belongs_to :subcategory, class_name: "Subcategory"
  has_many :answers, class_name: "Answer", :foreign_key => :question_id, :dependent => :destroy
  validates :name,  presence: true, length: { maximum: 512 }
  VALID_WEIGHT_REGEX = /\A[0-9]+(.[0-9]*)?\z/
  validates :weight, presence: true, format:{ with: VALID_WEIGHT_REGEX }

  def self.valid_weight_regex
    @regex = VALID_WEIGHT_REGEX
  end
end
