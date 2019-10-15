class Questionnaire < ApplicationRecord
    has_many :questionnaire_items
    belongs_to :user

    accepts_nested_attributes_for :questionnaire_items, 
                    reject_if: proc { |attributes| attributes['content'].blank? }, allow_destroy: true

    validates :theme, presence: true, length: { maximum: 100, minimum: 2 }
end
