class SubcategoriesController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  
  
  
  def index
    redirect_to questions_path
  end
  
  def show
    redirect_to questions_path
  end
  
  
  def update
    if(subcategory_params[:weight] =~ Subcategory.valid_weight_regex)
      @subcategory = Subcategory.find_by_id(params[:id])
      
     
      #update weight_sum
      new_category = Category.find_by_id(subcategory_params[:category_id])
      #byebug
      weight_sum = new_category.weight_sum + Float(subcategory_params[:weight])
      new_category.update_attributes!(weight_sum: weight_sum)
      
      
      old_category = Category.find_by_id(@subcategory.category_id)
      old_weight_sum = [old_category.weight_sum - @subcategory.weight, 0].max
      old_category.update_attributes!(weight_sum: old_weight_sum)
      
      
      
      @subcategory.update_attributes!(subcategory_params)
      flash[:success] = "#{@subcategory.name} was successfully updated."
        
      redirect_to questions_path
    else
      flash[:danger] = "Weight Invalid, you need to type a float."
      redirect_to edit_subcategory_path(params[:id])
    end
  end
  
  def create
    #update weight_sum
    result = subcategory_params
    if(subcategory_params[:weight] =~ Subcategory.valid_weight_regex)
      category = Category.find_by_id(subcategory_params[:category_id])

      weight_sum = category.weight_sum + Float(subcategory_params[:weight])
      category.update_attributes!(weight_sum: weight_sum)
      
      @subcategory = Subcategory.create!(result)
      
      flash[:success] = "#{@subcategory.name} was successfully created."
      redirect_to questions_path
    else
      flash[:danger] = "Weight Invalid, you need to type a float."
      #redirect_to new_subcategory_path(params[:id])
      redirect_to new_subcategory_path
    end
  end
  
  def new
    @categories = all_categories
    category = Category.find_by_id(params[:category_id])
    @subcategory = category.subcategories.new
  end

  def edit
    @subcategory = Subcategory.find_by_id(params[:id])
    @categories = all_categories
  end

  def destroy
    @subcategory = Subcategory.find_by_id(params[:id])
    #update weight_sum
    category = Category.find_by_id(@subcategory.category_id)
    
    weight_sum = [category.weight_sum - @subcategory.weight, 0].max
    
    category.update_attributes!(weight_sum: weight_sum)
    
    #questions = Question.where("subcategory_id = ?", params[:id])
    #questions.each do |q|
    #  q.destroy
    #end
      
    @subcategory.destroy
    flash[:success] = "Subcategory '#{@subcategory.name}' deleted."
    redirect_to questions_path
    
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
      if !admin? && !decision_maker?
        
        flash[:danger] = "Please log in as correct user."
        redirect_to root_path and return
      end
    end
    
    
end
