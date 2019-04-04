class ActivateController < ApplicationController
    def activate
      if admin?
        user = User.find_by(login_id: params[:login_id])
        if !user.approved
          user.update_attribute(:approved,    true)
          user.update_attribute(:activation_token, Activate.new_token)
          user.update_attribute(:activation_digest,Activate.digest(user.activation_token))
        # user.activation_token = Activate.new_token
        # user.activation_digest = Activate.digest(user.activation_token)
          UserMailer.account_activation(user).deliver_now
          flash[:success] = "Successfully send email"
          redirect_to users_url
        else
          flash[:warning] = "User Already Activated!"
          redirect_to users_url
        end
      else
        flash[:danger] = "You do not have permission."
        redirect_to show_user_url
      end
    end
end