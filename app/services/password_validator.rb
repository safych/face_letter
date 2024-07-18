class PasswordValidator
  include ActiveModel::Model

  attr_accessor :password

  validates :password, presence: true, length: { minimum: 8, maximum: 128 }
  validates :password, format: { 
    with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/,
    message: I18n.t("models.user.password_validates_format")
  }

  def initialize(password)
    @password = password
  end
end