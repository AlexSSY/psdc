class PizzaCustomIngredient < ApplicationRecord
  include QuantityGoodies

  belongs_to :pizza_custom
  belongs_to :pizza_top

  delegate :name, to: :pizza_top
  delegate :image, to: :pizza_top

  def price
    pizza_top.price * quantity
  end
end
