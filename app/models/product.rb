class Product < ApplicationRecord

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 1}
  validates :title, uniqueness: true


end
