class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(login_id: params[:session][:login_id])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        if user.role == "Administrator"
          redirect_back_or(user)
        elsif user.role == "Decision Maker"
          redirect_back_or(user)
        elsif user.role == "Validtor"
          redirect_back_or(user)
        elsif user.role == "Company Representative"
          redirect_back_or(user)
        end
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
