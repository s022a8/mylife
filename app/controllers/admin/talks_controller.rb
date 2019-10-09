class Admin::TalksController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:user_id])
    @rooms = @user.rooms
  end

  def show
    @room = Room.find(params[:id])

    #ルーム内のユーザー取り出し
    @room.entries.each_with_index do |entry, i|
      var = "@entry#{i}"
      value = "entry.user"
      eval("#{var} = #{value}")
    end
  end
end
