class User < ApplicationRecord

  require "securerandom"
  
  has_secure_password

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  # validates :email, presence: true
  # validates :password, presence: true
  # validates :username, presence: true, uniqueness: true

end
