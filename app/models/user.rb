class User < ApplicationRecord
  has_secure_password
  has_many :reservations, dependent: :destroy

  validates :email, presence: true, uniqueness: true,
                   format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validate :password_complexity

  private

  def password_complexity
    return if password.blank?
    return if password.match?(/^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()]).{12,70}$/)

    errors.add :password, "deve ter pelo menos 12 caracteres, incluindo uma letra maiúscula, " \
                         "uma letra minúscula, um número e um caractere especial"
  end
end
