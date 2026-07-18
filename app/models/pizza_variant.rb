class PizzaVariant < ApplicationRecord
  class << self
    def hash_request_params(params)
      normalized = params.deep_stringify_keys.sort.to_h
      Digest::SHA256.hexdigest(normalized.to_json)
    end
  end

  scope :with_price, WithPriceQuery
  scope :with_quantity, WithQuantityQuery
  scope :catalog_query, CatalogQuery

  include CartItemable

  belongs_to :pizza
  belongs_to :pizza_size
  belongs_to :pizza_dough
  belongs_to :pizza_crust, optional: true
  has_many :pizza_variant_ingredients
  has_many :pizza_tops, through: :pizza_variant_ingredients

  delegate :name, to: :pizza
  delegate :constructor_image, to: :pizza
  validates :fingerprint, uniqueness: true

  accepts_nested_attributes_for :pizza_variant_ingredients

  def price
    self[:price] || PizzaVariantPriceCalculator.new(self).call()
  end
end
