class PizzaCustom < ApplicationRecord
  class << self
    def hash_request_params(request_params)
      Digest::SHA256.hexdigest(
        request_params
          .to_h
          .deep_stringify_keys
          .sort.to_h
          .to_json
        )
    end
  end

  include CartItemable

  belongs_to :pizza
  belongs_to :pizza_size
  belongs_to :pizza_crust, optional: true
  belongs_to :pizza_dough
  has_many :pizza_custom_ingredients
  has_many :pizza_tops, through: :pizza_custom_ingredients

  accepts_nested_attributes_for :pizza_custom_ingredients

  delegate :constructor_image, to: :pizza
  delegate :name, to: :pizza

  def pizza_crust_price
    if pizza_crust_id.present?
      return PizzaCrustInfo.find_by(
        pizza_size_id: pizza_size_id,
        pizza_crust_id: pizza_crust_id
      )&.price || 0
    end
    0
  end

  def pizza_dough_price
    PizzaDoughInfo.find_by(
      pizza_size_id: pizza_size_id,
      pizza_dough_id: pizza_dough_id
    )&.price || 0
  end

  def ingredients_price
    result = 0
    pizza_custom_ingredients.each do |ingredient|
      result += ingredient.price * ingredient.quantity
    end
    result
  end

  def price
    pizza_crust_price +
    pizza_dough_price +
    ingredients_price
  end
end
