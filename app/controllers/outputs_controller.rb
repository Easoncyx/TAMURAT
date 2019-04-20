class OutputsController < ApplicationController
  include OutputsHelper
  before_action :logged_in_user
  before_action :correct_user
  before_action :explorer
  
  def index
  end
  
  def show
    @company = Company.find_by_id(params[:id])
    @result_structure = {}
    categories = Category.all
    
    categories.each do |cat|
      @result_structure[cat] = {}
      cat.subcategories.each do |subcat|
        @result_structure[cat][subcat] = subcat.questions
      end
    end
    
    respond_to do |format|
      
      format.json { render :json => {:success => true, :html => render_to_string('_show.html.erb', layout: false)}}
      format.html { redirect_to outputs_path}
    end
  end

  private
    def correct_user
      if admin? or decision_maker?
        return
      else
        flash[:warning] = "You have no right to enter this page!"
        redirect_to root_path
      end
    end
    def explorer
      @companies = Company.all
      @result_tree = jrtree_hash @companies
    end

end
