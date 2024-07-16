class User < ApplicationRecord
  has_many :user_link, dependent: :destroy
  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, presence: true, uniqueness: true, format: { with: /\A\S+@.+\.\S+\z/, message: :invalid }
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

  def google_auth?
    provider == 'google'
  end
end
