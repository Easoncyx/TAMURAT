class CompaniesController < ApplicationController
  include CompaniesHelper
  
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    @companies = Company.order(:id)
  end
  
  def update
    company = Company.find_by_id(params[:id])
    company_name = get_company_name company
    company.update_attributes!(validated: params[:validated])
    if params[:validated] == 'true'
      company.answers.each do |ans|
        ans.update_attributes({:validated => true})
      end
      company.calculate_score
      flash[:success] = "Successfully validated the company #{company_name}!"
    else
      company.answers.each do |ans|
        ans.update_attributes({:validated => false})
      end
      flash[:warning] = "Now you need to validate #{company_name} again!"
    end
    
    redirect_to companies_path
  end
  
  private
  
    def correct_user
      if !validator?
        flash[:danger] = "Please log in as correct user."
        redirect_to root_url and return
      end
    end
    
    def company_params
      params.require(:company).permit(:validated)
    end  
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :login_id)
    end
    
end
