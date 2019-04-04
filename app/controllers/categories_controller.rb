class CategoriesController < ApplicationController
  def category_params
    params.require(:category).permit(:name)
  end
  
  def warning(category)
    if not category
      flash[:warning] = "No record found of this category."
      redirect_to questions_path
    end
  end
  
  def index
    redirect_to questions_path
  end
  
  def show  
    redirect_to questions_path
  end
  
  def update
    @category = Category.find_by_id(params[:id])
    warning(@category)
    @category.update_attributes!(category_params)
    flash[:success] = "#{@category.name} was successfully updated."
    redirect_to questions_path
  end
  
  def create
    result = category_params
    result[:weight_sum] = 0
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
end
