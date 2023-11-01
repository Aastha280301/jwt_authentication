class User < ApplicationRecord
  rolify

  require "securerandom"
  
  has_secure_password
  # has_and_belongs_to_many :role, :join_table => :users_roles
  has_many :products, dependent: :destroy
  validates :email, format: URI::MailTo::EMAIL_REGEXP
  has_many :images, as: :imageable
  has_one :token
 
end
