class ActivateController < ApplicationController
  before_action :logged_in_user
  def activate
    if admin?
      @user = User.find_by(login_id: params[:login_id])
      if !@user
        flash[:warning] = "Please provide valid loginID information."
        redirect_to users_url
      else
        if !@user.approved
          @user.create_activation_digest
          @user.create_company
          UserMailer.account_activation(@user).deliver_now
          flash[:success] = "Successfully send email"
          redirect_to users_url
        else
          flash[:warning] = "User Already Activated!"
          redirect_to users_url
        end
      end
    else
      flash[:danger] = "You do not have permission."
      redirect_to root_url
    end
  end
  
end
