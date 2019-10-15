class Questionnaire < ApplicationRecord
    has_many :questionnaire_items
    belongs_to :user

    validates :theme, presence: true, length: { maximum: 100, minimum: 2 }
end
