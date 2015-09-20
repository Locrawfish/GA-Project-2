module SessionsHelper
  #Logs in the user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #Returns or finds the current user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  # Returns true if the user is logged in, false if not
  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_path, notice: "Please sign in."
    end
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
