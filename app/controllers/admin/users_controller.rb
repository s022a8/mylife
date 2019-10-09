class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
  end

  def warning
    @user = User.find(params[:id])
  end

  def remove
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_url
  end
end
