class PizzaIngredient < ApplicationRecord
  include QuantityGoodies

  belongs_to :pizza
  belongs_to :pizza_top

  delegate :name, to: :pizza_top

  def price
    pizza_top.price * quantity
  end
end
