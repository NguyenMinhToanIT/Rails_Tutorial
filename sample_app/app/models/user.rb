class User < ApplicationRecord
  has_secure_password
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum:3, maximum: 50}
  validates :email, presence: true, length: {minimum:3, maximum: 255},
    format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: true}

  validates :password, presence: true, length: {minimum: 1, maximum: 30}
end