class AnswersController < ApplicationController
  include CompaniesHelper
  before_action :logged_in_user
  before_action :correct_user
  before_action :company_user, only: [:new, :create]
  before_action :not_validated, only: [:new, :create, :edit]

  def new
    question_id = params[:question_id]
    company_id = params[:company_id]
    answer = Answer.find_by({company_id: company_id, question_id: question_id})

    if answer
      redirect_to edit_answer_path(answer.id) and return
    end
    @answer = Answer.new({company_id: company_id, question_id: question_id})
    @question = Question.find_by_id(question_id)
    @levels = Scale.where("category_id = ?", @question.subcategory.category.id).map{|t| t.level}
  end

  def edit
    id = params[:id]
    question_id = params[:question_id]

    @answer = Answer.find_by_id(id)

    if !@answer
      flash[:danger] = "Answer_invalid"
      redirect_to answers_path
    end

    @question = Question.find_by_id(question_id)
    @levels = Scale.where("category_id = ?", @question.subcategory.category.id).map{|t| t.level}
  end

  def update
    id = params[:id]
    @answer = Answer.find_by_id(id)
    question = Question.find_by_id(answer_params[:question_id])
    # byebug

    if validator?
      @answer.update_attributes!(validate_params)
      flash[:success] = "Successfully validate question #{question.name}"
      redirect_to answers_path(:company_id => answer_params[:company_id])
    else
      @answer.update_attributes!(answer_params)
      flash[:success] = "Successfully Answered question #{question.name}"
      redirect_to answers_path
    end


  end

  def create
    Answer.create!(answer_params)
    question = Question.find_by_id(answer_params[:question_id])
    flash[:success] = "Successfully Answered question #{question.name}"
    redirect_to answers_path
  end

  def show
    id = params[:id]
    question_id = params[:question_id]

    @answer = Answer.find_by_id(id)

    @validator = User.find_by_id(@answer.validator_id)

    @question = Question.find_by_id(question_id)
    @subcategory = Subcategory.find_by_id(@question.subcategory_id)
    @category = Subcategory.find_by_id(@subcategory.category_id)
  end

  def index
    if validator?
      @company_id = params[:company_id]
      @company_name = get_company_name(Company.find_by_id(@company_id))
    else
      @company_id = current_user.company.id
    end

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
    
    respond_to do |format|
      format.html
      format.csv { send_data Question.to_csv(@result),
        filename: "questions.csv"
      }
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:level, :company_id, :question_id, :validated)
    end

    def validate_params
      params.require(:answer).permit(:level, :validated, :validator_comment, :validator_id)
    end

    def correct_user
      if !company_representative? && !validator?
        flash[:danger] = "Please log in as correct user."
        redirect_to root_path and return
      end
    end

    def company_user
      if !company_representative?
        flash[:danger] = "You are not company representative!"
        redirect_to root_path and return
      end
    end

    def not_validated
      if company_representative? && current_user.company.validated
        flash[:warning] = "You have already been validated!"
        redirect_to answers_url and return
      end
    end
end