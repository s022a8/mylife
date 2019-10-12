class HistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    
    ## DM機能に関して
    @current_user_entry = current_user&.entries.includes(:room) #includes
    @other_user_entry = @user&.entries.includes(:room) #includes
    # 現在のユーザと対象ユーザの
    # 同じRoomと紐付いているEntryがあるか調べる。
    @current_user_entry&.each do |cue|
      @other_user_entry&.each do |oue|
        if cue.room.id == oue.room.id
          @isRoom = true
          @roomId = cue.room.id
          break
        end
      end
    end
    # Roomがなかった場合
    unless @isRoom
      @room = Room.new
      @entry = Entry.new
    end

    ## gon
    gon.user_name = @user.name
    gon.history_ages = @user.histories.order(:age).map { |history| history.age }
    gon.history_barometers = @user.histories.order(:age).map { |history| history.barometer }
    gon.history_events = @user.histories.order(:age).map { |history| history.event }
  end

  def show
    @user = User.find(params[:user_id])
    @history = History.find(params[:id])
    # コメント機能
    @comment = Comment.new
    @comments = @history.comments.includes(:user) # includes
  end

  def new
    @user = User.find(params[:user_id])
    @history = @user.histories.build
    @sub_event = @history.sub_events.build
  end

  def create
    @user = User.find(params[:user_id])
    @history = @user.histories.build(history_params)
    if @history.save
      redirect_to user_histories_path(@user.id)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @history = History.find(params[:id])
    #@sub_event = @history.sub_events
  end

  def update
    @user = User.find(params[:user_id])
    @history = History.find(params[:id])
    if @history.update_attributes(history_params)
      redirect_to user_histories_path(@user.id)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @history = History.find(params[:id])
    if @history.destroy
      flash[:notice] = "正常に削除されました。"
      redirect_to user_histories_path(@user.id)
    else
      redirect_to edit_user_history_path(@user.id, @history.id)
    end
  end

  #ヒストリー画像へ
  def gallery
    @user = User.find(params[:user_id])
    @histories = @user.histories
  end


  private

    def history_params
      params.require(:history).permit(:age, :event, :barometer, :history_image,
                              sub_events_attributes: [:id, :_destroy, :part, :detail])
    end
end
