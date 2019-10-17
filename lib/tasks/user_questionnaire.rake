namespace :user_questionnaire do
    desc "期限の過ぎたアンケートの削除"
    task :expire => :environment do
        questionnaires = Questionnaire.all
        questionnaires.each do |question|
            if question.created_at < 1.months.ago
                question.destroy
            end
        end
    end
end
