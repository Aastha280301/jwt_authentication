class User < ApplicationRecord

  require "securerandom"
  
  has_secure_password

  validates :email, format: URI::MailTo::EMAIL_REGEXP
 
end
