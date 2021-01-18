class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ } do # #どちらも全角（漢字・ひらがな・カタカナ）での入力が必須
    validates :first_name, presence: true
    validates :last_name, presence: true
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ一]+\z/ } do   # #どちらも全角カタカナ
    validates :last_name_kana, presence: true
    validates :first_name_kana, presence: true
  end

  validates :birth_date, presence: true
end
