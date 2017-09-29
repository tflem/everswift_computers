class UserAccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Your Account Is Activated!"
      redirect_to user
    else
      flash[:danger] = "Account Activation Link Invalid"
      redirect_to login_url
    end
  end
end
