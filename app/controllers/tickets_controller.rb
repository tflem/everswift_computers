class TicketsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
