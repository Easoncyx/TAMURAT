require 'sessions_helper.rb'


class ScenariosController < ApplicationController
  
  before_action :logged_in_user
  before_action :correct_user
  before_action :right_user,         only: [:show, :destroy, :edit]
  
  
  def new
    @scenario = Scenario.new
  end
  
  def show
    @scenario = Scenario.find_by_id(params[:id])
    @dms = @scenario.users
  end
  
  def index
    if decision_maker?
      @scenarios = current_user.scenarios
    else 
      @scenarios = Scenario.all
    end
    @scenario = current_user.active_privileges.build
  end
  
  def create
    @scenario = Scenario.new(scenario_params)
    if @scenario.save
      flash[:success] = "Scenario created!"
      if decision_maker?
        current_user.create_scenario(@scenario)
      end
    else
      flash[:warning] = "Scenario create failed!"
    end
    redirect_to scenarios_url
  end
  
  
  def destroy
    if decision_maker?
      @scenario=current_user.scenarios.find_by(id: params[:id])
    end
    Scenario.find(params[:id]).destroy
    flash[:success] = "Scenario deleted"
    redirect_to scenarios_url
  end
  
  def update
    @scenario = Scenario.find(params[:id])
    if @scenario.update_attributes(scenario_params)
      flash[:success] = "#{@scenario.name} was successfully updated."
      redirect_to @scenario
    else
      render 'edit'
    end
  end

  def edit
    @scenario = Scenario.find(params[:id])
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
    
    def right_user
      if !admin?
        scenario = Scenario.find(params[:id])
        if !current_user.has_scenario?(scenario)
          flash[:danger] = "Do not meddle with other's scenarios!"
          redirect_to scenarios_url and return
        end
      end
    end
  
  
end
