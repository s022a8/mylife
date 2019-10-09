class Admin::HistoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:user_id])
    @histories = @user.histories
  end

  def show
    @history = History.find(params[:id])
    @sub_events = @history.sub_events
  end

  def destroy
    @history = History.find(params[:id])
    @history.destroy
    redirect_to admin_user_histories_path(@history.user)
  end
end
