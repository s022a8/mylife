class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :warning, :leave]

  def index
    ## アカウント名による検索
    if params[:search_names]
      split_keywords = params[:search_names].split(/[[:blank:]]+/)
      array_users = []
      split_keywords.each do |keyword|
        next if keyword == ""
        tagging_user = User.where('name LIKE ?', "%#{keyword}%")
        tagging_user.each do |user|
          array_users << user
        end
      end
      array_users.uniq!
      #配列をActiveRecordに変換
      users = User.where(id: array_users.map{ |user| user.id })
      @users = users.page(params[:page]).per(12)

    ## タグによる検索
    elsif params[:search_tags]
      split_keywords = params[:search_tags].split(/[[:blank:]]+/)
      array_users = []
      split_keywords.each do |keyword|
        next if keyword == ""
        tagging_user = User.tagged_with("#{keyword}")
        tagging_user.each do |user|
          array_users << user
        end
      end
      array_users.uniq!
      #配列をActiveRecordに変換
      users = User.where(id: array_users.map{ |user| user.id })
      @users = users.page(params[:page]).per(12)

    ## デフォルトの一覧ページを表示
    else
      @users = User.order(created_at: :desc).page(params[:page]).per(12).includes({profile_image_attachment: :blob}, :taggings) # includes
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
