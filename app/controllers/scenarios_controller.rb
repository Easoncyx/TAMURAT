require 'sessions_helper.rb'


class ScenariosController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  
  def new
    @scenario = Scenario.new
  end
  
  def show
    
  end
  
  def index
    if current_user.role=="Decision Maker"
      @scenarios = Scenario.where(user_id: @current_user)
      
    elsif current_user.role=="Administrator" 
      @scenarios = Scenario.all
    else
      flash[:success] = "You don't have permission"
      redirect_to root_url
    end
    
    @scenario = current_user.scenarios.build if logged_in?
  
  end
  def create
    @scenarios = current_user.scenarios.build(scenario_params)
    if current_user.role=="Decision Maker" and @scenarios.save
      flash[:success] = "Scenario created!"
      redirect_to scenarios_url
      
    else
      redirect_to scenarios_url
      flash[:success] = "Scenario create failed!"
    end
  end
  
  def destroy
    if decision_maker?
      @scenario=current_user.scenarios.find_by(id: params[:id])
    else
      @scenarios = Scenario.all
      @scenario = @scenarios.find_by(id: params[:id])
    end
    @scenario.destroy
    flash[:success] = "Scenario deleted"
    redirect_to request.referrer || root_url
  end
  
  def update
  
  end

  def edit
    
  end
  
  private

    def scenario_params
      params.require(:scenario).permit(:name, :description)
    end
  
    def correct_user
      
      if !admin? && !decision_maker?
        flash[:danger] = "Please log in as correct user."
        redirect_to root_url and return
      end
  
      
    end
  
  
end
