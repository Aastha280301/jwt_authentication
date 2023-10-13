class User < ApplicationRecord
  rolify

  require "securerandom"
  
  has_secure_password

  has_many :products, dependent: :destroy
  validates :email, format: URI::MailTo::EMAIL_REGEXP
  has_many :images, as: :imageable
 
end
