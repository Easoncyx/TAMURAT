class QuestionsController < ApplicationController
  def question_params
    params.require(:question).permit(:name, :weight, :subcategory_id)
  end
  
  def warning(question)
    if not question
      flash[:warning] = "No record found of this question."
      redirect_to questions_path
    end
  end
  
  def index
    @category = Category.all
    @result = {}
    @subcategory = Subcategory.all
    @category.each do |ctgr|
      subcategory = Subcategory.where("category_id = ?", ctgr.id)
      @result[ctgr] = {}
      subcategory.each do |subcate|
        @result[ctgr][subcate] = Question.where("subcategory_id = ?", subcate.id)
      end
    end
  end

  def show
    redirect_to questions_path
  end
  
  def update
    @question = Question.find_by_id([:id])
    
    warning(@question)
    @question.update_attributes!(question_params)
    flash[:success] = "#{@question.name} was successfully updated."
    redirect_to questions_path
  end
  
  def create
    @question = Question.create!(question_params)
    
    flash[:success] = "#{@question.name} was successfully created."
    redirect_to questions_path
  end
  
  def new
    @subcategories = all_subcategories
    @question = Question.new
  end

  def edit
    @question = Question.find_by_id(params[:id])
    warning(@question)
    @subcategories = all_subcategories
  end

  def destroy
    @question = Question.find_by_id(params[:id])
    warning(@question)
    @question.destroy
    flash[:success] = "Question '#{@question.name}' deleted."
    redirect_to questions_path
  end
  
  
  def all_subcategories
    result = []
    allsubs = Subcategory.all
    allsubs.each do |subcat|
      result << [subcat.name, subcat.id]
    end
    return result
  end
  
end
