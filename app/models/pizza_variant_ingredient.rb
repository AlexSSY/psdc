class PizzaVariantIngredient < ApplicationRecord
  include QuantityGoodies

  belongs_to :pizza_variant
  belongs_to :pizza_top
end
