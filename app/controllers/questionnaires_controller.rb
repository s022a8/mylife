class QuestionnairesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :myquestion]

  def index
    @questionnaires = Questionnaire.page(params[:page]).per(12).order(created_at: :desc)
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
