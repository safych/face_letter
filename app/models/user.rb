class User < ApplicationRecord
  has_many :user_link, dependent: :destroy
  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, presence: true, uniqueness: true, format: { with: /\A\S+@.+\.\S+\z/, message: :invalid }
  validates :password, presence: true, length: { minimum: 8, maximum: 128 }
  validates :password, format: { 
    with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/,
    message: I18n.t("models.user.password_validates_format")
  }, if: :password_required?
  validates :name, presence: true, length: { maximum: 50 }, unless: :google_auth?
  validates :surname, presence: true, length: { maximum: 50 }, unless: :google_auth?

  def self.from_google(u)
    create_with(
      uid: u[:uid],
      provider: 'google',
      password: Devise.friendly_token[0, 20]
    ).find_or_create_by!(email: u[:email])
  end

  private

  def password_required?
    provider.blank? || !password.nil?
  end

  def google_auth?
    provider == 'google'
  end
end
