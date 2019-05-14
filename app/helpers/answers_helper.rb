module AnswersHelper
  def answered?(question_id, company_id)
    if company_id && question_id
      Answer.find_by({question_id: question_id, company_id: company_id}) != nil
    else
      flash[:danger] = "Invalid reference."
      return nil
    end
    
  end
  
  def get_answer_id(question_id, company_id)
    answer = Answer.find_by({question_id: question_id, company_id: company_id})
    if answer
      return answer.id
    else 
      flash[:warning] = "No record find of your answer, you need to create it."
      return nil
    end
  end
  
  def validated?(question_id, company_id)
    answer = Answer.find_by({question_id: question_id, company_id: company_id})
    if answer
      return answer.validated
    else 
      flash[:warning] = "No record find of your answer, you need to create it."
      return nil
    end
  end
  
  def toggle_style is_toggle
    if !is_toggle
      return "panel-collapse collapse"
    else
      return "collapse in"
    end
  end
  
  def subcat_score company_id, subcategory_id
    company = Company.find_by_id(company_id)
    result = SubcategoryScore.find_by({company_id: company_id, subcategory_id: subcategory_id})
    if !company.validated
      return "Not validated"
    end
    if result
      return result.score.round(4)
    else
      return "Not Answered"
    end
  end
  
  def cat_score company_id, category_id
    company = Company.find_by_id(company_id)
    result = CategoryScore.find_by({company_id: company_id, category_id: category_id})
    if !company.validated
      return "Not validated"
    end
    if result
      return result.score.round(4)
    else
      return "Not Answered"
    end
  end
end
