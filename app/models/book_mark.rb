class BookMark < ApplicationRecord
    belongs_to :user
    belongs_to :history

    validates_uniqueness_of :user_id, scope: :history_id
end
