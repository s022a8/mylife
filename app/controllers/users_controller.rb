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
      # 最新の歴史を投稿している順に並べる
      tmp_users = User.all  
      all_histories = []
      all_users = []
      none_history_users = []
      tmp_users.includes(:histories, {profile_image_attachment: :blob}, :taggings).each do |user| #includes
        if user.histories.empty?
          none_history_users << user
        else
          # 各ユーザーの最新のhistoryを取り出す
          all_histories << user.histories.order(created_at: :desc).first
        end
      end
      # 全ユーザーのhistoryを最新順に並べる
      latest_histories = all_histories.sort { |a, b| (-1) * (a.created_at.to_i <=> b.created_at.to_i) }
      latest_histories.each do |l_history|
        all_users << l_history.user
      end

      # 配列をページネーションに対応させる
      @users = Kaminari.paginate_array(all_users.concat(none_history_users)).page(params[:page]).per(12)


      # @users = User.order(created_at: :desc).page(params[:page]).per(12).includes({profile_image_attachment: :blob}, :taggings) # includes
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
