class TalksController < ApplicationController
  before_action :authenticate_user!


  def index
    # コメントの最新順に部屋を並べる
    @rooms = current_user.rooms
    all_messages = []
    all_room_id = []
    @rooms.each do |room|
      room_id = room.id
      if room.messages.nil?
        all_room_id << room_id
      else
        room.messages.each do |msg|
          if !all_room_id.include?(room_id)
            all_room_id << room_id
            all_messages << msg
          end
            all_messages.each do |each_msg|
              if each_msg.room.id == msg.room.id
                if msg.created_at.to_i > each_msg.created_at.to_i
                  all_messages.delete(each_msg)
                  all_messages << msg
                end
              end
            end
        end
      end
    end
    @active_all_messages = Message.where(id: all_messages.map{ |msg| msg.id }).order(created_at: :desc)
    

    # includes
    # @rooms = current_user.rooms.page(params[:page]).per(10).includes(entries: {user: {profile_image_attachment: :blob}})
  end


  def show
    @room = Room.find(params[:id])

    #ルーム内のユーザー取り出し
    @room.entries.includes(user: {profile_image_attachment: :blob}).each_with_index do |entry, i| #includes
      var = "@entry#{i}"
      value = "entry.user"
      eval("#{var} = #{value}")
    end

    #message関連
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.includes(:user)
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
