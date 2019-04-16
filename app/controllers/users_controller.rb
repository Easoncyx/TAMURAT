class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destory, :index, :show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:destroy, :index]

  def index
    @users = User.search(params[:search]).paginate(page: params[:page])
    @all_roles_name = User.distinct.pluck(:role)
    @selected_roles_name = []
    redirect_flag = false

    if params[:roles]
      @selected_roles_name = params[:roles].keys
      session[:roles] = params[:roles]
    elsif session[:roles]
      @selected_roles_name = session[:roles].keys
      redirect_flag = true
    else
      @selected_roles_name = User.distinct.pluck(:role)
    end
    # @users = User.where(role: @selected_roles_name).paginate(page: params[:page])

    if redirect_flag
      # flash.keep
      redirect_to users_path(roles: session[:roles], search:params[:search])
    else
      @users = User.where(role: @selected_roles_name).search(params[:search]).paginate(page: params[:page])
    end
  end

  def show
    id = params[:id]
    @user = User.find(id)
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
    if update_params[:password] 
      if @user.update_attributes(update_params)
        flash[:primary] = "Account has been changed, please login again."
        log_out
        redirect_to root_path
      else
        render 'edit'
      end
    else
      if @user.update_attributes(update_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
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

    def company_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :login_id)
    end

    def update_params
      params.require(:user).permit(:name, :password, :password_confirmation)
      #params.permit(:name, :email, :password, :password_confirmation, :role, :login_id)
    end

 

    def correct_user
      @user = User.find_by_id(params[:id])
      # may conflict with the previous flash
      # flash[:danger] = "Please log in as correct user."
      redirect_to(root_url) unless current_user?(@user)
    end


end