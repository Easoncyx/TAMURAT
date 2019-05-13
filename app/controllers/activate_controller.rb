class ActivateController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def activate
    @user = User.find_by(login_id: params[:login_id])
    if !@user
      flash[:warning] = "Please provide valid loginID information."
    else
      if !@user.activated
        @user.create_activation_digest
        # byebug
        UserMailer.account_activation(@user).deliver_now
        flash[:success] = "Successfully send email"
      else
        flash[:warning] = "User Already Activated!"
      end
    end
    redirect_to users_url
  end
end
