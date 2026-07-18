class CartItem::TotalPriceQuery < ApplicationQuery
  def resolve
    relation.sum(&:total_price)
  end
end
