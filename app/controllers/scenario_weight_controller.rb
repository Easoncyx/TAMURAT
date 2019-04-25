class ScenarioWeightController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  before_action :right_user

  def submit
    sw_params = params[:sw]
    # byebug
    sw_params.values.each do |t|
      if t[:weight] !~ ScenarioWeight.valid_weight_regex
        flash[:danger] = "Weight Invalid, you need to type a float."
        redirect_to edit_scenario_path(params[:scenario_id]) and return
      end
    end

    if ScenarioWeight.update(sw_params.keys, sw_params.values)
      if @scenario = Scenario.find_by_id(params[:scenario_id])
        @scenario.cal_scenario_score
        flash[:success] = "ScenarioWeights was successfully updated."
        redirect_to scenarios_path and return
      else
        flash[:danger] = "No scenario found."
        redirect_to edit_scenario_path(params[:scenario_id])
      end
    else
      flash[:danger] = "ScenarioWeights update failed."
      redirect_to edit_scenario_path(params[:scenario_id])
    end


  end

  private
    def correct_user
      if !admin? && !decision_maker?
        flash[:danger] = "Please log in as correct user."
        redirect_to root_url and return
      end
    end

    def right_user
      if !admin?
        scenario = Scenario.find(params[:scenario_id])
        if !current_user.has_scenario?(scenario)
          flash[:danger] = "Do not meddle with other's scenarios!"
          redirect_to scenarios_path and return
        end
      end
    end
end
