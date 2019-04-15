class QuestionsController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user

  def index

    @category = Category.order(:id)
    #byebug
    @result = {}
    @subcategory = Subcategory.order(:id)
    @category.each do |ctgr|
      subcategory = Subcategory.where("category_id = ?", ctgr.id)
      @result[ctgr] = {}
      subcategory.each do |subcate|
        @result[ctgr][subcate] = Question.where("subcategory_id = ?", subcate.id).order(:id)
      end
    end
  end

  def show
    redirect_to questions_url
  end

  def update

    if(question_params[:weight] =~ Question.valid_weight_regex)
      @question = Question.find_by_id(params[:id])
      unless @question
        flash[:danger] = "No record found of this question."
        redirect_to questions_url and return
      end
      
      new_subcat = Subcategory.find_by_id(question_params[:subcategory_id])
      unless new_subcat
        flash[:danger] = "No record found of this new_subcat."
        redirect_to questions_url and return
      end
      weight_sum = new_subcat.weight_sum + Float(question_params[:weight])
      new_subcat.update_attributes!(weight_sum: weight_sum)

      old_subcat = Subcategory.find_by_id(@question.subcategory_id)
      unless old_subcat
        flash[:danger] = "No record found of this old_subcat."
        redirect_to questions_url and return
      end
      old_weight_sum = [old_subcat.weight_sum - @question.weight, 0].max
      old_subcat.update_attributes!(weight_sum: old_weight_sum)
        
  
      @question.update_attributes!(question_params)
      flash[:success] = "#{@question.name} was successfully updated."
      redirect_to questions_url
    else
      flash[:danger] = "Weight Invalid, you need to type a float."
      redirect_to edit_question_url(params[:id])
    end
  end

  def create
    if(question_params[:weight] =~ Question.valid_weight_regex)
      
      subcategory = Subcategory.find_by_id(question_params[:subcategory_id])
      unless subcategory
        flash[:danger] = "No record found of this question."
        redirect_to questions_url and return
      end

      weight_sum = subcategory.weight_sum + Float(question_params[:weight])
      subcategory.update_attributes!(weight_sum: weight_sum)

      @question = Question.create!(question_params)
      flash[:success] = "#{@question.name} was successfully created."
      redirect_to questions_url
    else
      flash[:danger] = "Weight Invalid, you need to type a float."
      redirect_to new_question_url
    end
  end

  def new
    @subcategories = all_subcategories
    @question = Question.new
  end

  def edit
    @question = Question.find_by_id(params[:id])
    unless @question
      flash[:danger] = "No record found of this question."
      redirect_to questions_url and return
    end
    @subcategories = all_subcategories
  end

  def destroy
    @question = Question.find_by_id(params[:id])
    unless @question
      flash[:danger] = "No record found of this question."
      redirect_to questions_url and return
    end
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
