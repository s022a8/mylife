class History < ApplicationRecord
    belongs_to :user
    has_many :sub_events
    has_many :comments
    has_many :book_marks
end
