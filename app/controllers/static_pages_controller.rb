class StaticPagesController < ApplicationController
  
  def home
    @user = current_user
    @scenario = current_user.scenarios.build if logged_in?
    @j = User.exists?(activated: false)
  end

  def help
    
    @category = Category.order(:id)
    #byebug
    @result = {}
    @subcategory = Subcategory.order(:id)
    @category_weight_sum=0
    @category.each do |ctgr|
      @category_weight_sum += ctgr.weight
      subcategory = Subcategory.where("category_id = ?", ctgr.id)
      @result[ctgr] = {}
      subcategory.each do |subcate|
        @result[ctgr][subcate] = Question.where("subcategory_id = ?", subcate.id).order(:id)
      end
    end
    
  end

  def about
  end

  def contact
  end
  
  
  private

    
    def correct_user
      if !admin? && !decision_maker?

        flash[:danger] = "Please log in as correct user."
        redirect_to root_url and return
      end
    end
  
  
  
end
