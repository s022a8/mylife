class SubEvent < ApplicationRecord
    belongs_to :history

    validates :part, presence: true, length: { maximum: 70 }
end
