class SessionsController < ApplicationController

  def new
  end

  def create
    # Log user in and redirect to user show page
    @user = User.find_by(email: params[:session][:email].downcase)
    if  @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
      # Create error message
        message = "Account Not Activated. "
        message += "Check Email for an Activation Link."
        flash[:warning] = message
        redirect_to login_url
      end
    else
      flash.now[:danger] = "Invalid Email/Password Combination"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
  end
end
