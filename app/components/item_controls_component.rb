# frozen_string_literal: true

class ItemControlsComponent < ApplicationComponent
  option :cart_itemable
  option :quantity

  def turbo_params
    {
      cart_itemable_type: helpers.k(cart_itemable).cart_itemable_type,
      cart_itemable_id: helpers.k(cart_itemable).cart_itemable_id
    }
  end

  def decrease_icon
    quantity == 1 ? helpers.icon("trash") : helpers.icon("minus")
  end
end
