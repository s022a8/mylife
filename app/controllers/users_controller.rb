class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :warning, :leave]

  def index
    if params[:search_names]
      @users = User.where(['name LIKE ?', "%#{params[:search_names]}"]).page(params[:page]).per(12)
    elsif params[:search_tags]
      @users = User.tagged_with("#{params[:search_tags]}").page(params[:page]).per(12)
    else
      @users = User.page(params[:page]).per(12)
    end
  end

  def show
    @user = current_user
  end

  def warning
  end

  def leave
    @user = current_user
    if @user.destroy
      flash[:notice] = "正常に退会が行われました。"
      redirect_to root_path
    else
      flash[:alert] = "退会処理が正常に行われませんでした。"
      redirect_to users_path
    end
  end

end
