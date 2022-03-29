# ユーザー管理に関するモデル
# @todo バリデーション失敗時のエラー文を設定する
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :driving_requests

  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, presence: true
  validates :email, :password, :first_name, :last_name, :first_name_kana, :last_name_kana, length: { maximum: 255 }

  # パスワードを英数字混合必須、記号も入力可能に設定
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[!-~]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, on: :create

  # 全角の漢字or平仮名or片仮名を使用しているか検証
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :first_name
    validates :last_name
  end

  # 全角のカタカナを使用してるか検証
  with_options format: { with: /\A[ァ-ヶー]+\z/ } do
    validates :first_name_kana
    validates :last_name_kana
  end

  # 数字のみの10~11桁であることを検証
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }
end
