class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :history

    validates :body, presence: true, length: { maximum: 35 }
end
