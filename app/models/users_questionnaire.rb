class UsersQuestionnaire < ApplicationRecord
    belongs_to :user 
    belongs_to :questionnaire_item

    validates :point, numericality: { only_integer: true, greater_than: -1, less_than: 6 }, presence: true
end
