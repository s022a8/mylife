class HistoriesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
  end

  def new
  end

  def edit
  end
end
