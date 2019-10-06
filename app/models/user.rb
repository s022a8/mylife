class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #activestorage
  has_one_attached :profile_image

  #acts-as-taggable-on
  acts_as_taggable
  acts_as_taggable_on :parts

  #validation
  validates :email, presence: true
  validates :name, presence: true
end
