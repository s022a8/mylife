class QuestionnairesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :myquestion]

  def index
    ## カテゴリー名による検索
    if params[:search_categories]
      split_keywords = params[:search_categories].split(/[[:blank:]]+/)
      array_questions = []
      split_keywords.each do |keyword|
        next if keyword == ""
        tagging_question = Questionnaire.where('category LIKE ?', "%#{keyword}%")
        tagging_question.each do |question|
          array_questions << question
        end
      end
      array_questions.uniq!
      #配列をActiveRecordに変換
      questions = Questionnaire.where(id: array_questions.map{ |question| question.id })
      @questionnaires = questions.page(params[:page]).per(12)
    else
      # デフォルトの挙動
      @questionnaires = Questionnaire.page(params[:page]).per(12).order(created_at: :desc)
    end
  end

  def new
    @questionnaire = current_user.questionnaires.build
    @question_item = @questionnaire.questionnaire_items.build
  end

  def create
    @questionnaire = current_user.questionnaires.build(questionnaire_params)
    if @questionnaire.save
      redirect_to questionnaires_path
    else
      render 'new'
    end
  end

  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.destroy
      flash[:notice] = "正常に削除されました。"
      redirect_to myquestion_path
    else
      redirect_to myquestion_path
    end
  end

  def myquestion
    @my_questionnaire = current_user.questionnaires
  end


  private

    def questionnaire_params
      params.require(:questionnaire).permit(:theme, :category,
                questionnaire_items_attributes: [:id, :_destroy, :content]
              )
    end
end
