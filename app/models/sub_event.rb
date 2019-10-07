class SubEvent < ApplicationRecord
    belongs_to :history

    validates :part, presence: true, length: { maximum: 15 }
    validates :detail, length: { maximum: 50 }
end
