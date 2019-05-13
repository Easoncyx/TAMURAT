class Scale < ApplicationRecord
  belongs_to :category
  validates :category_id, presence: true
  validates :name, presence: true
  validates :level, presence: true
  validates :score, presence: true, format:{ with: self.valid_weight_regex }

# validate the level for a question
  def self.check_answer?(question_id, answer)
    question = Question.find_by_id(question_id)
    levels = Scale.where("category_id = ?", question.subcategory.category.id).map{|t| t.level}
    if levels.include? answer
      return true
    else
      return false
    end
  end
end
