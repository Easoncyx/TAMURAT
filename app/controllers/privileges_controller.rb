require 'sessions_helper.rb'


class PrivilegesController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  
  
  def new
    @privilege = Privilege.new
    @admins = User.where("role = ?", "Decision Maker")
  end
  
  
  
  
  
  
  
  private

    def scenario_params
      params.require(:privilege).permit(:scenario_id, :user_id)
    end
  
    def correct_user
      
      if !admin?
        flash[:danger] = "Please log in as correct user."
        redirect_to scenarios_url and return
      end
      
      
    end
  
  
  
  
  
  
end
