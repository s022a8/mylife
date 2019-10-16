class Questionnaire < ApplicationRecord
    has_many :questionnaire_items, inverse_of: :questionnaire, dependent: :destroy
    belongs_to :user

    accepts_nested_attributes_for :questionnaire_items, 
                    reject_if: proc { |attributes| attributes['content'].blank? }, allow_destroy: true

    validates :theme, presence: true, length: { maximum: 132, minimum: 2 }
    validate :max_questionnaire_size
    validate :questionnaire_item_size


    # アンケート項目のバリデーションもする
    validates_associated :questionnaire_items


    ## アンケートのアンケート項目数を制限
    def questionnaire_item_size
        errors.add(:questionnaire_items, "項目数は２つ以上です。") if self.questionnaire_items.size < 2
        errors.add(:questionnaire_items, "項目数は８つまでです。") if self.questionnaire_items.size > 8
    end

    # 作れるアンケートの数を制限
    def max_questionnaire_size
        errors.add(:questionnaires, "登録数は５つまでです。") if self.user.questionnaires.size > 5
    end
end
