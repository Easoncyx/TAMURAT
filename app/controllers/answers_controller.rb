class AnswersController < ApplicationController
  def new
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def create
    
  end
  
  def index

    @category = Category.all
    @result = {}
    @answers = Answer.find_by("company_id = ?", current_user.id)
    @subcategory = Subcategory.all
    @category.each do |ctgr|
      subcategory = Subcategory.where("category_id = ?", ctgr.id)
      @result[ctgr] = {}
      subcategory.each do |subcate|
        @result[ctgr][subcate] = Question.where("subcategory_id = ?", subcate.id)
      end
    end
    
  end
  
  private
  
end
