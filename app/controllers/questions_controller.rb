class QuestionsController < ApplicationController
  def question_params
    params.require(:question).permit(:name, :weight, :subcategory_id)
  end
  
  def warning(question)
    if not question
      flash[:warning] = "No record found of this question."
      redirect_to questions_path and return
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

    if(params[:question][:weight] =~ /\A[0-9]*(.[0-9]+)?\z/)
      @question = Question.find_by_id(params[:id])
      warning(@question)
  
      new_subcat = Subcategory.find_by_id(params[:question][:subcategory_id])
      warning(new_subcat)
      weight_sum = new_subcat.weight_sum + Float(params[:question][:weight])
      new_subcat.update_attributes!(weight_sum: weight_sum)
      if @question.subcategory_id != params[:subcategory_id]
        old_subcat = Subcategory.find_by_id(@question.subcategory_id)
        warning(old_subcat)
        old_weight_sum = [old_subcat.weight_sum - @question.weight, 0].max
        old_subcat.update_attributes!(weight_sum: old_weight_sum)
      end
      
      @question.update_attributes!(question_params)
      flash[:success] = "#{@question.name} was successfully updated."
      redirect_to questions_path
    else
      flash[:warning] = "Weight Invalid, you need to type a float."
      redirect_to edit_question_path(params[:id])
    end
  end
  
  def create
    if(params[:question][:weight] =~ /\A[0-9]*(.[0-9]+)?\z/)
      subcategory = Subcategory.find_by_id(params[:question][:subcategory_id])
      warning(subcategory)
      weight_sum = subcategory.weight_sum + Float(params[:question][:weight])
      subcategory.update_attributes!(weight_sum: weight_sum)
      
      @question = Question.create!(question_params)
      flash[:success] = "#{@question.name} was successfully created."
      redirect_to questions_path
    else
      flash[:warning] = "Weight Invalid, you need to type a float."
      redirect_to new_question_path
    end
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
    subcat = Subcategory.find_by_id(@question.subcategory_id)
    weight_sum = [subcat.weight_sum - @question.weight, 0].max
    subcat.update_attributes!(weight_sum: weight_sum)
    
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
