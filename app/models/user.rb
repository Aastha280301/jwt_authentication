class User < ApplicationRecord

  require "securerandom"
  
  has_secure_password

  has_many :products, dependent: :destroy
  validates :email, format: URI::MailTo::EMAIL_REGEXP
 
end
