class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  #relationship
  has_many :histories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :entries

  #activestorage
  has_one_attached :profile_image

  #acts-as-taggable-on
  acts_as_taggable
  acts_as_taggable_on :parts

  #validation
  validates :email, presence: true
  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  validate :max_tag_size



  ##タグの文字数、タグ自体の数のバリデーション
  def max_tag_size
    errors[:part_list] << "登録数は3つまでです。" if self.part_list.count > 3
    self.part_list.each do |tag|
      if tag.length > 8
        errors[:part_list] << "文字数は8文字以下です。"
      end
    end
  end


  ## ブックマーク機能について
  # 既にブックマークしているか？
  def book_mark?(history)
    book_marks.exists?(history_id: history.id)
  end

  # ブックマークする
  def book_mark(history)
    book_mark = book_marks.build(history_id: history.id)
    book_mark.save
  end

  # ブックマークをやめる
  def un_book_mark(history)
    book_mark = book_marks.find_by(history_id: history.id)
    book_mark.destroy
  end


  ## omniauth認証
  # findメソッド
  def self.find_for_oauth(auth)
    puts auth
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        name: auth.info.name.slice(0, 15),
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  # 先にFacebookでユーザ情報が登録されてしまった場合
  def self.new_with_session(params, session)
    if session["devise.facebook_data"]
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
          user.name = data["name"] if user.name.blank?
        end
      end
    else 
      super
    end
  end

  # trueならパスワードに関するバリデーションを行う（override）
  # 元々は新しいレコードであるか、passwordかpassword_confirmationの値がからでないならバリデーションを行う
  def password_required?
    provider.blank? && super
  end

  # SNS認証で登録したユーザーならfalseを返す
  def omniauth_login_user?
    provider.blank?
  end
end
