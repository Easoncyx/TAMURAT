class StaticPagesController < ApplicationController
  def home
    @scenario = current_user.scenarios.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
