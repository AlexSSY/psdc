class CartItem < ApplicationRecord
  include QuantityGoodies

  belongs_to :cart
  belongs_to :cart_itemable, polymorphic: true

  def total_price
    cart_itemable.price * quantity
  end

  def partial_path
    "cart_items/#{cart_itemable_type.underscore}"
  end
end
