class HistoriesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @history = History.find(params[:id])
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
    # @sub_event = @history.sub_events
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


  private

    def history_params
      params.require(:history).permit(:age, :event, :barometer, 
                              sub_events_attributes: [:id, :_destroy, :part])
    end
end
