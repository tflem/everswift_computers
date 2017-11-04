class TicketsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def new
    @ticket = current_user.tickets.build if logged_in?
  end

  def create
    @ticket = current_user.tickets.build(ticket_params)
    if @ticket.save
      flash[:success] = "Your Ticket Has Been Created."
      redirect_to current_user
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  private

  def ticket_params
    params.require(:ticket).permit(:category, :title, :status, :message)
  end
end
