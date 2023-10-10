class Product < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable
  belongs_to :order
end