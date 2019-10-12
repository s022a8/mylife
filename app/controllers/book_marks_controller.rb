class BookMarksController < ApplicationController
  before_action :authenticate_user!

  def index
    # includes
    @book_marks = current_user.book_marks.page(params[:page]).per(15).includes(history: {user: {profile_image_attachment: :blob}} )
  end

  def create
    @history = History.find(params[:history_id])
    current_user.book_mark(@history)
    respond_to do |format|
      format.html { redirect_to user_histories_path(current_user.id) }
      format.js
    end
  end

  def destroy
    @history = History.find(params[:id])
    current_user.un_book_mark(@history)
    respond_to do |format|
      format.html { redirect_to user_histories_path(current_user.id) }
      format.js
    end
  end

end
