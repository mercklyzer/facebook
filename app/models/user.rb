class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password,
    presence: true,
    length: {within: 8..ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED}
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  validate :username_should_not_match_any_email

  private

  def username_should_not_match_any_email
    if User.where(email: username).exists? || User.where(username: email).exists?
      errors.add(:username, "has already been taken")
    end
  end
end
