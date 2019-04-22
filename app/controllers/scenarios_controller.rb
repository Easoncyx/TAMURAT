class ScenariosController < ApplicationController
  include CompaniesHelper

  before_action :logged_in_user
  before_action :correct_user
  before_action :right_user,         only: [:show, :destroy, :edit]


  def new
    @scenario = Scenario.new
  end

  def show
    @scenario = Scenario.find_by_id(params[:id])
    @dms = @scenario.users

    @allcompanies = Company.where("validated = ?", true)
    @result = {}
    @allcompanies.each do |this_company|
      @category = Category.order(:id)
      @subcategory = Subcategory.order(:id)
      @result[this_company]={}
      @category.each do |ctgr|
        subcategory = Subcategory.where("category_id = ?", ctgr.id)

        @result[this_company][ctgr] = {}
        subcategory.each do |subcate|
          @result[this_company][ctgr][subcate] = Question.where("subcategory_id = ?", subcate.id).order(:id)
        end
      end
    end

    @scenario_weight = ScenarioWeight.where("scenario_id = ?", @scenario.id).order(:id)
    @companies = @scenario_weight.map{|t| t.company_id}.map{|x| Company.find_by_id(x)}
    @companies_name = @companies.map{|y| get_company_name(y)}
    @companies_loginid = @companies.map{|y| get_company_login_id(y)}
  end

  def index
    if decision_maker?
      @scenarios = current_user.scenarios
    else
      @scenarios = Scenario.all
    end
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
    # add all companies to scenario_weight table
    @companies = Company.all
    @companies.each do |c|
      @scenario.companys << c
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
      flash[:danger] = "Scenario update failed."
      render 'edit'
    end
  end

  def edit
    @scenario = Scenario.find(params[:id])
    #get a list of scenario_weight instance belongs to the same scenario
    @scenario_weight = ScenarioWeight.where("scenario_id = ?", @scenario.id).order(:id)
    # get a list of company_id, then Company instances, then company names and login_id
    @companies = @scenario_weight.map{|t| t.company_id}.map{|x| Company.find_by_id(x)}
    @companies_name = @companies.map{|y| get_company_name(y)}
    @companies_loginid = @companies.map{|y| get_company_login_id(y)}
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
