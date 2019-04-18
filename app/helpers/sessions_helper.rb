module SessionsHelper

  # 登入指定的用户
  def log_in(user)
    session[:user_id] = user.id
  end

  # 返回当前登录的用户（如果有的话） or nil
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # 如果指定用户是当前用户，返回 true
  def current_user?(user)
    user == current_user
  end

  # 如果用户已登录，返回 true，否则返回 false
  def logged_in?
    !current_user.nil?
  end

  #if the current user is admin, return true
  def admin?
    !current_user.nil? and current_user.role == "Administrator"
  end

  def decision_maker?
    !current_user.nil? and current_user.role == "Decision Maker"
  end

  def validator?
    !current_user.nil? and current_user.role == "Validator"
  end

  def company_representative?
    !current_user.nil? and current_user.role == "Company Representative"
  end

  # 退出当前用户
  def log_out
    session.delete(:user_id)
    session.delete(:categories)
    @current_user = nil
  end

 # 重定向到存储的地址或者默认地址
 def redirect_back_or(default)
   redirect_to(session[:forwarding_url] || default)
   session.delete(:forwarding_url)
 end

 # 存储后面需要使用的地址
 def store_location
   session[:forwarding_url] = request.original_url if request.get?
 end
end
