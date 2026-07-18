class Drink < ApplicationRecord
  has_many :drink_variants
  has_one_attached :image
  has_one_attached :detail_image do |attachable|
    attachable.variant :thumb, resize_to_fit: [ 80, 80 ]
  end
end
