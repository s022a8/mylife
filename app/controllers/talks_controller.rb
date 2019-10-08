class TalksController < ApplicationController

  def index
    @rooms = current_user.rooms.page(params[:page]).per(10)
  end


  def show
    @room = Room.find(params[:id])

    #ルーム内のユーザー取り出し
    @room.entries.each_with_index do |entry, i|
      var = "@entry#{i}"
      value = "entry.user"
      eval("#{var} = #{value}")
    end

    #message関連
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
    else
      redirect_back(fallback_location: root_path)
    end
  end


  def create
    #トークを初めた直後にブラウザバックしてしまったときの対処
    current_user_entries = current_user.entries
    other_user_entries = User.find(params[:entry][:user_id]).entries
    current_user_entries.each do |cue|
      other_user_entries.each do |oue|
        if cue.room.id == oue.room.id
          flash[:notice] = "トークルームは既に作成されています。"
          flash[:alert] = "ブラウザバックした場合に、このメッセージが表示されます。"
          redirect_to talk_path(cue.room.id) and return
        end
      end
    end

    #デフォルトの挙動
    @room = Room.create
    @entry1 = current_user.entries.build(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.new(entry_params.merge(room_id: @room.id))
    if @entry1.save && @entry2.save
      flash[:notice] = "トークルームが作成されました。"
      redirect_to talk_path(@room.id)
    else
      flash[:alert] = "トークを始めることができませんでした。"
      redirect_to root_path
    end
  end


  private

    def entry_params
      params.require(:entry).permit(:user_id)
    end
end
