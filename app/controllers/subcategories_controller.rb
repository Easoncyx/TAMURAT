class SubcategoriesController < ApplicationController
  def subcategory_params
    params.require(:subcategory).permit(:name, :weight, :category_id)
  end
  def index
    redirect_to questions_path
  end
  
  def show
    redirect_to questions_path
  end
  
  def warning(subcategory)
    if not subcategory
      flash[:warning] = "No record found of this subcategory."
      redirect_to questions_path
    end
  end
  
  def update
    @subcategory = Subategory.find_by_id([:id])
    weight = params[:weight]
    category = Category.find_by_id(params[:category_id])
    old_category = Category.find_by_id(@subcategory.category_id)
    
    new_weight_sum = category.weight_sum + weight
    old_weight_sum = old_category.weight_sum - weight
    
    old_category.update_attributes!(old_weight_sum)
    category.update_attributes!(weight_sum)
    @subcategory.update_attributes!(subcategory_params)
    flash[:success] = "#{@subcategory.name} was successfully updated."
    redirect_to questions_path
  end
  
  def create
    @subcategory = Subcategory.create!(subcategory_params)
    weight = params[:weight]
    category = Category.find_by_id(params[:category_id])
    new_weight_sum = category.weight_sum + weight
    
    category.update_attributes!(weight_sum)
    flash[:success] = "#{@subcategory.name} was successfully created."
    redirect_to questions_path
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
    questions = Question.where("subcategory_id = ?", params[:id])
    questions.each do |q|
      q.destroy
    end
      
    @subcategory.destroy
    flash[:success] = "Subcategory '#{@subcategory.name}' deleted."
    redirect_to questions_path
    
  end
  
  
  def all_categories
    result = []
    allcats = Category.all
    allcats.each do |category|
      result << [category.name, category.id]
    end
    return result
  end
end
