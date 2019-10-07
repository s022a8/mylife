class TalksController < ApplicationController

  def index
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.create
    @entry1 = current_user.entries.build(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.new(entry_params.merge(room_id: @room.id))
    if @entry1.save && @entry2.save
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
