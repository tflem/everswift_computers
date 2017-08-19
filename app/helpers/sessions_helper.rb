module SessionsHelper

  # Log in user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Return current logged-in user, if any
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if user logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # Logs out current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
