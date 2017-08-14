class SessionsController < ApplicationController

  def new
  end

  def create
    # Log user in and redirect to user show page
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    else
      # Create error message
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
  end
end
