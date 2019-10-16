class QuestionnaireItemsController < ApplicationController
    before_action :authenticate_user!

    def update
        # puts 'hello'
        @questionnaire = {}
        @questionnaire_item = QuestionnaireItem.find(params[:question_item_id])
        @questionnaire.merge!("questionnaire_item" => @questionnaire_item)
        @user_questionnaire = current_user.users_questionnaires.find_by(questionnaire_item_id: params[:question_item_id])
        # 新規の投票か既存の投票の変更かで条件分岐
        if @user_questionnaire.nil?
            # 新規投票
            @new_user_questionnaire = current_user.users_questionnaires.build(
                    questionnaire_item_id: params[:question_item_id], point: params[:point]
                )
            if @new_user_questionnaire.save!
                # アンケートの総投票数の計算
                all_point = 0
                @questionnaire_item.users_questionnaires.each do |uqp|
                    all_point += uqp.point
                end
                @questionnaire.merge!(all_point: all_point)
                @questionnaire.merge!({"user_questionnaire" => @new_user_questionnaire})
                render json: @questionnaire
            else
            end
        else
            # 既存の投票の更新
            if @user_questionnaire.update_attributes(point: params[:point])
                # アンケートの総投票数の計算
                all_point = 0
                @questionnaire_item.users_questionnaires.each do |uqp|
                    all_point += uqp.point
                end
                @questionnaire.merge!(all_point: all_point)
                @questionnaire.merge!({"user_questionnaire" => @user_questionnaire})
                render json: @questionnaire
            else
            end
        end
    end
end
