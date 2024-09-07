class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password,
    presence: true,
    length: {within: 8..ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED}
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
