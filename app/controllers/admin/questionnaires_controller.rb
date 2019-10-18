class Admin::QuestionnairesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:user_id])
    @questionnaires = @user.questionnaires
  end

  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.destroy
    redirect_to admin_user_questionnaires_url(@questionnaire.user.id)
  end
end
