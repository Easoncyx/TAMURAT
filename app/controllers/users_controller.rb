class UsersController < ApplicationController
  include CompaniesHelper
  before_action :logged_in_user, only: [:destory, :index, :show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :company_user,   only: [:show]
  before_action :admin_user,     only: [:destroy, :index, :importnew, :import]
  before_action :invite_user,    only: [:new]

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
      @users = User.where(role: @selected_roles_name).search(params[:search]).order(:login_id).paginate(page: params[:page])
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

    # logged in as admin invite another admin
    if admin?
      password = rand(36 ** 10).to_s(36)
      @user.password = password
      @user.password_confirmation = password
      @user.role = "Administrator"
    elsif company_representative?
      password = rand(36 ** 10).to_s(36)
      @user.password = password
      @user.password_confirmation = password
      @user.role = "Company Representative"
    end

    if @user.save
      if company_representative?
        @newcompany = Company.new(user_id: @user.id)
        @current_company = current_user.company
        @newcompany.parent_id = @current_company.id
        @newcompany.save
        flash[:info] = "Send invitation to subcompany."
      elsif admin?
        flash[:info] = "Send invitation to Administrator."
      else
        flash[:info] = "Please wait for approval from Administrator, and your login_id to be sent to your email."
      end
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
    password = update_params[:password]
    flag = @user.authenticate(password)
    if !flag && password != ""
      if @user.update_attributes(update_params)
        flash[:warning] = "Password has been changed, you need to login again."
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


  def importnew
    @user = User.new
  end

  def import #import zip file for company
    if user_import_params['file'] # must have file selected
      if Answer.csv_check?(user_import_params[:file].path)
        if user_import_params['parent_login_id'] != "" # parent id not empty
          parent_user = User.find_by(login_id: user_import_params['parent_login_id'])
          if parent_user && (parent_user.role == 'Company Representative')
            @user = User.new(name: user_import_params['name'], email: user_import_params['email'])
            if User.maximum(:id)
              @user.login_id = User.maximum(:id).next + 1000
            else
              @user.login_id = 1000
            end

            password = rand(36 ** 10).to_s(36)
            @user.password = password
            @user.password_confirmation = password
            @user.role = "Company Representative"
            @user.activated = true
            @user.activated_at = Time.zone.now

            if @user.save
              @newcompany = Company.new(user_id: @user.id)

              # check to save as subcompany
              parent_company = Company.find_by(user_id: parent_user.id)
              if parent_company
                @newcompany.parent_id = parent_company.id
                @newcompany.save
                flash[:info] = "A new company user is created."
              else
                flash[:danger] = "Company doesn't exist."
                redirect_to importnew_users_path and return
              end
              Answer.import(user_import_params[:file].path, @newcompany.id)
              flash[:info] = "User and answers added successfully."
              redirect_to root_url
            else
              render 'new'
            end
          else # parent company doesn't exist
            flash[:danger] = "Parent user doesn't exist or Parent user isn't a Company Representative."
            redirect_to importnew_users_path and return
          end

        else # no parent_login_id
          @user = User.new(name: user_import_params['name'], email: user_import_params['email'])
          if User.maximum(:id)
            @user.login_id = User.maximum(:id).next + 1000
          else
            @user.login_id = 1000
          end

          password = rand(36 ** 10).to_s(36)
          @user.password = password
          @user.password_confirmation = password
          @user.role = "Company Representative"
          @user.activated = true
          @user.activated_at = Time.zone.now

          if @user.save
            @newcompany = Company.new(user_id: @user.id)
            @newcompany.save
            Answer.import(user_import_params[:file].path, @newcompany.id)
            flash[:info] = "User and answers added successfully."
            redirect_to root_url
          else
            render 'new'
          end
        end
      else
        flash[:danger] = "Invalid zip file!"
        redirect_to importnew_users_path and return
      end
    else
      flash[:danger] = "No zip file selected"
      redirect_to importnew_users_path and return
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :login_id)
    end
    def user_import_params
      params.require(:user).permit(:name, :email, :parent_login_id, :file)
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
      redirect_to(root_url) unless current_user?(@user)
      # may conflict with the previous flash
      # flash[:danger] = "Please log in as correct user."
    end

    def company_user
      @user = User.find_by_id(params[:id])
      if company_representative? && @user.role == "Company Representative" && ancestor?(current_user.company, @user.company)
        return
      else
        redirect_to(root_url) unless current_user?(@user)
      end
      # may conflict with the previous flash
      # flash[:danger] = "Please log in as correct user."
    end

    def invite_user
      if logged_in? and !company_representative? and !admin?
        flash[:warning] = "You do not have permission to invite other users."
        redirect_to root_url
      end
    end

end
