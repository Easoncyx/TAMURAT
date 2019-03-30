class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # redirect_to user_url(@user)
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


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :login_id)
    end

    # make sure the user is logged in before action like edit
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      # may conflict with the previous flash
      # flash[:danger] = "Please log in as correct user."
      redirect_to(root_url) unless current_user?(@user)
    end
end
