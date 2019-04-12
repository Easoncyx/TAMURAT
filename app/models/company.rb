class Company < ApplicationRecord
  belongs_to :user, :foreign_key => :user_id, :class_name => "User", dependent: :destroy
  has_many :answers, :foreign_key => :company_id, :class_name => "Answer", dependent: :destroy
  has_many :subcategory_scores, :foreign_key => :company_id, :class_name => "SubcategoryScore", dependent: :destroy
  has_many :category_scores, :foreign_key => :company_id, :class_name => "CategoryScore", dependent: :destroy
  #connect itself
  has_many :children, class_name: "Company", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "Company", optional: true



  validates :user_id, presence: true, uniqueness: true
  
  
  def calculate_score
    category = Category.all
    company_id = self.id
    company_score = 0
    company_weight_sum = 0
    
    category.each do |cat|
      company_weight_sum += cat.weight
    end
    
    category.each do |cat|
      subcategories = Subcategory.where(category_id: cat.id)
      cat_score = 0
      
      subcategories.each do |subcat|
        questions = Question.where(subcategory_id: subcat.id)
        subcat_score = 0
        questions.each do |q|
          answer = Answer.find_by({question_id: q.id, company_id: company_id})
          if answer
            scale = Scale.find_by({category_id: cat.id, level: answer.level})
            if scale
              score = scale.score
              answer.update_attributes!({score: score})
              subcat_score += score * q.weight
            end
          end
          
        end
        if subcat.weight_sum != 0 && cat.weight_sum != 0 && company_weight_sum != 0
          subcat_score /= subcat.weight_sum
          subcat_score /= cat.weight_sum
          subcat_score /= company_weight_sum
        else 
          subcat_score = 0
        end
        
        old_subcat_score = SubcategoryScore.find_by({subcategory_id: subcat.id, company_id: company_id})
        if old_subcat_score
          old_subcat_score.update_attributes!({score: subcat_score})
        else
          parameters = {score: subcat_score, company_id: company_id, subcategory_id: subcat.id}
          SubcategoryScore.create!(parameters)
        end
        cat_score += subcat_score * subcat.weight
      end
      
      
      if cat.weight_sum != 0 && company_weight_sum != 0
        cat_score /= subcat.weight_sum
        cat_score /= cat.weight_sum
        cat_score /= company_weight_sum
      else 
        cat_score = 0
      end
      
      old_cat_score = CategoryScore.find_by({category_id: cat.id, company_id: company_id})
        if old_cat_score
          old_cat_score.update_attributes!({score: cat_score})
        else
          parameters = {score: cat_score, company_id: company_id, category_id: cat.id}
          CategoryScore.create!(parameters)
        end
        company_score += cat_score * cat.weight;
    end
    
    if company_weight_sum != 0
      company_score /= company_weight_sum
    else
      company_score = 0
    end
    self.update_attributes!({score: company_score})
  end
end
