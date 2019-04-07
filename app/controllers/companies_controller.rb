class CompaniesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  def index
    @companies = Company.all
  end
  
  private
    def correct_user
      if !validator?
        flash[:danger] = "Please log in as correct user."
        redirect_to root_url and return
      end
    end
end
