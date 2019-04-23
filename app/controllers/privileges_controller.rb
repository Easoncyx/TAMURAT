class PrivilegesController < ApplicationController
    before_action :logged_in_user
    before_action :admin_user
    
    def index
        @privileges = User.where("role = ?", "Decision Maker")
        if !params[:scenario_id]
            flash[:danger] = "Please choose a scenario!"
            redirect_to scenarios_url and return
        end
        @scenario = Scenario.find(params[:scenario_id])

    end
    
    def edit
        user = User.find_by(id: params[:id])
        scenario = Scenario.find(params[:scenario_id])
        if user.has_scenario?(scenario)
            flash[:success] = "Already assigned."
            redirect_to privileges_url(scenario_id: params[:scenario_id]) and return
        end
        user.create_scenario(scenario)
        flash[:success] = "Successfully Assigned!"
        redirect_to privileges_url(scenario_id: params[:scenario_id])

    end
    
    def destroy
        user = User.find_by(id: params[:id])
        scenario = Scenario.find(params[:scenario_id])
        if !user.has_scenario?(scenario)
            flash[:danger] = "DM does not have this scenario!"
            redirect_to privileges_url(scenario_id: params[:scenario_id]) and return
        end
        user.delete_scenario(scenario)
        flash[:success] = "Successfully Deleted!"
        redirect_to privileges_url(scenario_id: params[:scenario_id])
    end
end