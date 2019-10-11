class History < ApplicationRecord
    belongs_to :user
    has_many :sub_events, inverse_of: :history, dependent: :destroy
    validates_associated :sub_events
    has_many :comments, dependent: :destroy
    has_many :book_marks, dependent: :destroy

    #activestorage
    has_one_attached :history_image

    accepts_nested_attributes_for :sub_events, 
                    reject_if: proc { |attributes| attributes['part'].blank? }, allow_destroy: true


    validates :age, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 125 }
    validates :event, presence: true, length: { maximum: 50 }
    validates :barometer, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 101 }
end
