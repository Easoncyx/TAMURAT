class OutputsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    if !params[:scenario_id]
      redirect_to scenarios_path and return
    end
    @companies = Company.where({validated: true, parent_id: nil})
    @scenario = Scenario.find_by_id(params[:scenario_id])
  end
  
  def update
    
  end
  
  def create
  end
  
  private

    def update_params
      params.require(:outputs).permit(:weight)
    end

    def correct_user
      if admin_user? or decision_maker?
        return
      else
        flash[:warning] = "You have no right to enter this page!"
        redirect_to root_path
      end
    end
end
