class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(16)
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
