class QuestionnairesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @questionnaires = Questionnaire.all.order(created_at: :desc)
  end

  def new
    @questionnaire = current_user.questionnaires.build
    @question_item = @questionnaire.questionnaire_items.build
  end

  def create
    @questionnaire = current_user.questionnaires.build(questionnaire_params)
    if @questionnaire.save!
      redirect_to questionnaires_path
    else
      render 'new'
    end
  end

  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.destroy
      flash[:notice] = "正常に削除されました。"
      redirect_to questionnaires_path
    else
      redirect_to questionnaires_path
    end
  end


  private

    def questionnaire_params
      params.require(:questionnaire).permit(:theme, 
                questionnaire_items_attributes: [:id, :_destroy, :content]
              )
    end
end
