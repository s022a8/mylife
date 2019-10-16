class QuestionnaireItem < ApplicationRecord
    has_many :users_questionnaires
    belongs_to :questionnaire

    validates :content, presence: true, length: { maximum: 84 }
end
