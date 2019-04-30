require 'csv'
class Question < ApplicationRecord
  belongs_to :subcategory, class_name: "Subcategory"
  has_many :answers, class_name: "Answer", :foreign_key => :question_id, :dependent => :destroy
  validates :name,  presence: true, length: { maximum: 512 }

  validates :weight, presence: true, format:{ with: self.valid_weight_regex }

  def self.import(file)
    subcat_weight_sum = {}
    CSV.foreach(file, headers: true) do |row|
      category, subcategory, name, weight = row
      weight = weight[1].to_f
      if subcat_weight_sum[subcategory[1]]
        subcat_weight_sum[subcategory[1]] += weight
      else
        subcat_weight_sum[subcategory[1]] = weight
      end
      if !Category.exists?(name: category[1])
        @category = Category.new(name: category[1])
        @category.save
      else
        @category = Category.find_by(name: category[1])
      end

      if !Subcategory.exists?(name: subcategory[1])
        @subcategory = Subcategory.new(name: subcategory[1], category_id: @category.id, weight_sum: subcat_weight_sum[subcategory[1]])
        @subcategory.save
      else
        @subcategory = Subcategory.find_by(name: subcategory[1])
        @subcategory.update_attributes!(weight_sum: subcat_weight_sum[subcategory[1]])
      end
      @category.subcategories << @subcategory

      @question = Question.new(name: name[1], weight: weight, subcategory_id: @subcategory.id)
      @question.save
    end
  end
end
