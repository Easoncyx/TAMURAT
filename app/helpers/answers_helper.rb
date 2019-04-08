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
end
