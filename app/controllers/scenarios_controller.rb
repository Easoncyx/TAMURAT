class ScenariosController < ApplicationController
  
  before_action :logged_in_user
  
  def new
    
  end
  
  def show
    
  end
  
  def index
    if current_user.role=="Administrator" or current_user.role=="Decision Maker"
      @scenarios = Scenario.all
    else
      flash[:success] = "You don't have permission"
      redirect_to root_url
    end
  end
  def create
    @scenarios = current_user.scenarios.build(scenario_params)
    if current_user.role=="Decision Maker" and @scenarios.save
      flash[:success] = "Scenario created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    
  end
  
  def update
  
  end

  def edit
    
  end
  
  private

    def scenario_params
      params.require(:scenario).permit(:name, :description)
    end
  
    
  
  
end
