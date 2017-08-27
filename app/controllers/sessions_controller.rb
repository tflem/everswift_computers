class SessionsController < ApplicationController

  def new
  end

  def create
    # Log user in and redirect to user show page
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      # Create error message
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
