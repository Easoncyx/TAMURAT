require 'sessions_helper.rb'

class CategoriesController < ApplicationController
  
  def index
    redirect_to questions_path
  end
  
  def show  
    redirect_to questions_path
  end
  
  def update
    @category = Category.find_by_id(params[:id])
    if(category_params[:weight] !~ Category.valid_weight_regex) 
      flash[:warning] = "Weight Invalid, you need to type a float."
      #redirect_to new_subcategory_path(params[:id])
      redirect_to edit_category_path and return
    end
    @category.update_attributes!(category_params)
    flash[:success] = "#{@category.name} was successfully updated."
    redirect_to questions_path
  end
  
  def create
    result = category_params
    if(category_params[:weight] !~ Category.valid_weight_regex) 
      flash[:warning] = "Weight Invalid, you need to type a float."
      #redirect_to new_subcategory_path(params[:id])
      redirect_to new_category_path and return
    end
    @category = Category.create!(result)
    flash[:success] = "#{@category.name} was successfully created."
    redirect_to questions_path
  end
  
  def new
    @category = Category.new
  end

  def edit
    @category = Category.find_by_id(params[:id])
    warning(@category)
  end

  def destroy
    @category = Category.find_by_id(params[:id])
    
    warning(@category)
    
    #subcategories = Subcategory.where("category_id = ?", params[:id])
    #subcategories.each do |subcat|
    #  questions = Question.where("subcategory_id = ?", subcat.id)
    #  questions.each do |q|
    #    q.destroy
    #  end
    #  subcat.destroy
    #end
    
    @category.destroy
    flash[:success] = "Category '#{@category.name}' deleted."
    redirect_to questions_path
  end
  
  private 
    def correct_user
      if !admin? && !decision_maker?
        flash[:danger] = "Please log in as correct user."
        redirect_to root_path and return
      end
    end
    def category_params
      params.require(:category).permit(:name, :weight)
    end
    
    def warning(category)
      if not category
        flash[:danger] = "No record found of this category."
        redirect_to questions_path
      end
    end
end
