# frozen_string_literal: true

class CartButtonComponent < ApplicationComponent
  option :cart_itemable
  option :quantity
  option :variant, optional: true, default: proc { :normal }

  validates :variant, inclusion: { in: [ :normal, :big ] }

  def in_cart?
    quantity > 0
  end
end
