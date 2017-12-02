class TicketsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :set_ticket,     only: [:edit, :update]

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
    if @ticket.update_attributes(ticket_params)
      flash[:success] = "Your Ticket Has Been Updated."
      redirect_to current_user
    else
      flash[:alert] = "Title/Message Fields Cannot Be Blank."
      redirect_to edit_ticket_path(@ticket)
    end
  end

  private

    def ticket_params
      params.require(:ticket).permit(:category, :title, :status, :message)
    end

    def set_ticket
      @ticket = current_user.tickets.find(params[:id])
    end
end
