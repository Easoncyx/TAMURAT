require 'sessions_helper.rb'

class SubcategoriesController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  
  
  
  def index
    redirect_to questions_url
  end
  
  def show
    redirect_to questions_url
  end
  
  
  def update
    if(subcategory_params[:weight] =~ /\A[0-9]*(.[0-9]+)?\z/)
      @subcategory = Subcategory.find_by_id(params[:id])
      warning(@subcategory)
      
      #update weight_sum
      new_category = Category.find_by_id(subcategory_params[:category_id])
      warning(new_category)
      
      old_category = Category.find_by_id(@subcategory.category_id)
      warning(old_category)
      
      weight_sum = new_category.weight_sum + Float(subcategory_params[:weight])
      old_weight_sum = [old_category.weight_sum - @subcategory.weight, 0].max
      
      old_category.update_attributes!(weight_sum: old_weight_sum)
      new_category.update_attributes!(weight_sum: weight_sum)
      
      @subcategory.update_attributes!(subcategory_params)
      flash[:success] = "#{@subcategory.name} was successfully updated."
      
      redirect_to questions_url
    else
      flash[:danger] = "Weight Invalid, you need to type a float."
      redirect_to edit_subcategory_url(params[:id])
    end
  end
  
  def create
    #update weight_sum
    result = subcategory_params
    result[:weight_sum] = 0
    if(subcategory_params[:weight] =~ /\A[0-9]*(.[0-9]+)?\z/)
      category = Category.find_by_id(subcategory_params[:category_id])
      warning(category)
      weight_sum = category.weight_sum + Float(subcategory_params[:weight])
      category.update_attributes!(weight_sum: weight_sum)
      
      @subcategory = Subcategory.create!(result)
      
      flash[:success] = "#{@subcategory.name} was successfully created."
      redirect_to questions_url
    else
      flash[:warning] = "Weight Invalid, you need to type a float."
      redirect_to new_subcategory_url(params[:id])
    end
  end
  
  def new
    @categories = all_categories
    @subcategory = Subcategory.new
  end

  def edit
    @subcategory = Subcategory.find_by_id(params[:id])
    warning(@subcategory)
    @categories = all_categories
  end

  def destroy
    @subcategory = Subcategory.find_by_id(params[:id])
    warning(@subcategory)
    #update weight_sum
    category = Category.find_by_id(@subcategory.category_id)
    warning(category)
    
    weight_sum = [category.weight_sum - @subcategory.weight, 0].max
    
    category.update_attributes!(weight_sum: weight_sum)
    
    #questions = Question.where("subcategory_id = ?", params[:id])
    #questions.each do |q|
    #  q.destroy
    #end
      
    @subcategory.destroy
    flash[:success] = "Subcategory '#{@subcategory.name}' deleted."
    redirect_to questions_url
    
  end
  
  private 
  
    def all_categories
      result = []
      allcats = Category.all
      allcats.each do |category|
        result << [category.name, category.id]
      end
      return result
    end
    
    def subcategory_params
      params.require(:subcategory).permit(:name, :weight, :category_id)
    end
    
    def correct_user
      if !admin? or !decision_maker?
        flash[:danger] = "Please log in as correct user."
        redirect_to root_url and return
      end
    end
    
    def warning(subcategory)
      if !subcategory
        flash[:danger] = "No record found of this subcategory."
        redirect_to questions_url
      end
    end
    
    
end
