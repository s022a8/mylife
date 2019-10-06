class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #relationship
  has_many :histories
  has_many :comments
  has_many :book_marks
  has_many :entries
  has_many :messages
  has_many :rooms, through: :entries

  #activestorage
  has_one_attached :profile_image

  #acts-as-taggable-on
  acts_as_taggable
  acts_as_taggable_on :parts

  #validation
  validates :email, presence: true
  validates :name, presence: true
  validate :max_tag_size



  #タグの文字数、タグ自体の数のバリデーション
  def max_tag_size
    errors[:part_list] << "登録数は3つまでです。" if self.part_list.count > 3
    self.part_list.each do |tag|
      if tag.length > 8
        errors[:part_list] << "文字数は8文字以下です。"
      end
    end
  end
end
