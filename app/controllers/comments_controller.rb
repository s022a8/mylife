class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @history = History.find(params[:history_id])
        comment = current_user.comments.build(comment_params.merge(history_id: @history.id))
        if comment.save
            redirect_to user_history_path(@history.user.id, @history.id)
        else
            @user = @history.user
            @comment = Comment.new
            @comments = @history.comments
            flash.now[:alert] = "コメントできませんでした。文字がからであるか、文字数が多すぎます。"
            render 'histories/show'
        end
    end

    def destroy
        @history = History.find(params[:history_id])
        @comment = Comment.find(params[:id])
        if @comment.destroy
            redirect_to user_history_path(@history.user.id, @history.id)
        else
            @user = @history.user
            @comment = Comment.new
            @comments = @history.comments
            flash.now[:alert] = "正常に削除が行われませんでした。"
            render 'histories/show'
        end
    end


    private

        def comment_params
            params.require(:comment).permit(:body)
        end
end
