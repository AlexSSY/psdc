class Pizza < ApplicationRecord
  scope :catalog, CatalogQuery

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  belongs_to :pizza_size
  belongs_to :pizza_crust, optional: true
  belongs_to :pizza_dough
  has_many :pizza_ingredients
  has_many :pizza_variants

  has_one_attached :image
  has_one_attached :constructor_image do |attachable|
    attachable.variant :thumb, resize_to_fit: [ 80, 80 ]
  end

  def to_param
    slug
  end
end
