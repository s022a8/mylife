class MessagesController < ApplicationController

    def create
        @roomId = params[:talk_id]

        if Entry.where(user_id: current_user.id, room_id: @roomId).present?
            @message = current_user.messages.build(message_params.merge(room_id: @roomId))
            if @message.save
                redirect_to talk_path(@roomId)
            else
                render 'talks/show'
            end
        end
    end


    private

        def message_params
            params.require(:message).permit(:content)
        end

end
