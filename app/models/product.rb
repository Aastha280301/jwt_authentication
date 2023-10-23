class Product < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :images, as: :imageable
  belongs_to :order, dependent: :destroy
  has_many :ratings, dependent: :destroy
end