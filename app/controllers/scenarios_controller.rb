require 'sessions_helper.rb'


class ScenariosController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  
  def new
    if decision_maker? or admin?
      @scenario = Scenario.new
    else
      redirect_to scenarios_url
    end
  end
  
  def show
    @scenario = Scenario.find_by_id(params[:id])
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
    if @scenarios.save
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
    redirect_to scenarios_url
  end
  
  def update
    if decision_maker? or admin? and scenario_params
      @scenario = Scenario.find_by_id(params[:id])
      @scenario.update_attributes!(scenario_params)
      flash[:success] = "#{@scenario.name} was successfully updated."
      redirect_to scenario_url
    else
      flash[:warning] = "Content Invalid."
      redirect_to edit_scenario_url(params[:id])
    end
  
  end

  def edit
    @scenario = Scenario.find_by_id(params[:id])
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
