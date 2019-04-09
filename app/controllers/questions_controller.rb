require 'sessions_helper.rb'

class QuestionsController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    
    @category = Category.all
    #byebug
    @result = {}
    @subcategory = Subcategory.all
    @category.each do |ctgr|
      subcategory = Subcategory.where("category_id = ?", ctgr.id)
      @result[ctgr] = {}
      #byebug
      subcategory.each do |subcate|
        @result[ctgr][subcate] = Question.where("subcategory_id = ?", subcate.id)
      end
    end
    #byebug
  end

  def show
    redirect_to questions_url
  end
  
  def update

    if(question_params[:weight] =~ /\A[0-9]*(.[0-9]+)?\z/)
      @question = Question.find_by_id(params[:id])
      warning(@question)
  
      new_subcat = Subcategory.find_by_id(question_params[:subcategory_id])
      warning(new_subcat)
      #byebug
      weight_sum = new_subcat.weight_sum + Float(question_params[:weight])
      new_subcat.update_attributes!(weight_sum: weight_sum)
      
      old_subcat = Subcategory.find_by_id(@question.subcategory_id)
      warning(old_subcat)
      old_weight_sum = [old_subcat.weight_sum - @question.weight, 0].max
      old_subcat.update_attributes!(weight_sum: old_weight_sum)
      
      
      @question.update_attributes!(question_params)
      flash[:success] = "#{@question.name} was successfully updated."
      redirect_to questions_url
    else
      flash[:warning] = "Weight Invalid, you need to type a float."
      redirect_to edit_question_url(params[:id])
    end
  end
  
  def create
    if(question_params[:weight] =~ /\A[0-9]*(.[0-9]+)?\z/)
      subcategory = Subcategory.find_by_id(question_params[:subcategory_id])
      warning(subcategory)
      weight_sum = subcategory.weight_sum + Float(question_params[:weight])
      subcategory.update_attributes!(weight_sum: weight_sum)
      
      @question = Question.create!(question_params)
      flash[:success] = "#{@question.name} was successfully created."
      redirect_to questions_url
    else
      flash[:warning] = "Weight Invalid, you need to type a float."
      redirect_to new_question_url
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
    redirect_to questions_url
  end
  
  
  
  private
    
    def all_subcategories
      result = []
      allsubs = Subcategory.all
      allsubs.each do |subcat|
        result << [subcat.name, subcat.id]
      end
      return result
    end
    
    def warning(question)
      if not question
        flash[:danger] = "No record found of this question."
        redirect_to questions_url and return
      end
    end
  
    
    def question_params
      params.require(:question).permit(:name, :weight, :subcategory_id)
    end
  
    def correct_user
      if !admin? && !decision_maker?
        
        flash[:danger] = "Please log in as correct user."
        redirect_to root_url and return
      end
    end
end
