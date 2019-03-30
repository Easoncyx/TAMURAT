class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(login_id: params[:session][:login_id])
    if user && user.authenticate(params[:session][:password])
      log_in user
      if user.role == "Admin"
        redirect_back_or(user)
      elsif user.role == "Decision Maker"
        redirect_back_or(user)
      elsif user.role == "Validtor"
        redirect_back_or(user)
      elsif user.role == "Company Representatives"
        redirect_back_or(user)
      end
    else
      flash[:danger] = 'Invalid email/password combination' # 不完全正确
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
