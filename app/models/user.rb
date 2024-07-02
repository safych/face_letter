class User < ApplicationRecord
  has_many :users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :password, presence: true, length: { minimum: 8, maximum: 128 }
  validates :password, format: { 
    with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/,
    message: I18n.t("password_validates_format")
  }

  def self.from_google(u)
    create_with(uid: u[:uid], provider: 'google',
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
  end
end
