class MessagesController < ApplicationController
    before_action :authenticate_user!


    def create
        roomId = params[:talk_id]

        if Entry.where(user_id: current_user.id, room_id: roomId).present?
            @message = current_user.messages.build(message_params.merge(room_id: roomId))
            if @message.save
                @messages = Room.find(roomId).messages
                respond_to do |format|
                    format.html { redirect_to talk_path(roomId) }
                    format.js
                end
                # redirect_to talk_path(roomId)
            else
                respond_to do |format|
                    format.html { 
                        flash.now[:alert] = "メッセージが長すぎます。140文字以内にしてください。"

                        @room = Room.find(roomId)
                        #ルーム内のユーザー取り出し
                        @room.entries.each_with_index do |entry, i|
                            var = "@entry#{i}"
                            value = "entry.user"
                            eval("#{var} = #{value}")
                        end
                        @messages = @room.messages

                        render 'talks/show'
                    }
                    format.js { render 'error_message' }
                end
            end
        end
    end


    private

        def message_params
            params.require(:message).permit(:content)
        end

end
