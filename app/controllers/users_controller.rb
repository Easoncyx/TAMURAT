class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destory, :index, :show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:destroy, :index]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @scenarios = @user.scenarios.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.maximum(:id)
      @user.login_id = User.maximum(:id).next + 1000
    else
      @user.login_id = 1000
    end
    if @user.save
      #UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please wait for approval from Administrator, and your login_id to be sent to your email."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
     User.find(params[:id]).destroy
     flash[:success] = "User deleted"
     redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :login_id)
    end

    

    def correct_user
      @user = User.find(params[:id])
      # may conflict with the previous flash
      # flash[:danger] = "Please log in as correct user."
      redirect_to(root_url) unless current_user?(@user)
    end

    # 确保是管理员
    def admin_user
      redirect_to(root_url) unless admin?
    end
end
