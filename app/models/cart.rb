class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def price = CartPriceCalculator.new(self).call

  # def quantity_for(cart_itemable)
  #   items_by_key[[
  #     cart_itemable.class.base_class.name,
  #     cart_itemable.id
  #   ]] || 0
  # end

  # private

  # def items_by_key
  #   @items_by_key ||= begin
  #     if cart_items.loaded?
  #       cart_items.each_with_object({}) do |item, hash|
  #         hash[[ item.cart_itemable_type, item.cart_itemable_id ]] = item.quantity
  #       end
  #     else
  #       cart_items.pluck(
  #         :cart_itemable_type,
  #         :cart_itemable_id,
  #         :quantity
  #       ).each_with_object({}) do |(type, id, quantity), hash|
  #         hash[[ type, id ]] = quantity
  #       end
  #     end
  #   end
  # end
end
