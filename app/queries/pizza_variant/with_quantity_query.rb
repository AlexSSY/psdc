class PizzaVariant::WithQuantityQuery < ApplicationQuery
  def resolve(cart:)
    relation
      .joins(<<~SQL)
        LEFT JOIN cart_items
          ON cart_items.cart_itemable_type = 'PizzaVariant'
         AND cart_items.cart_itemable_id = pizza_variants.id
         AND cart_items.cart_id = #{cart.id}
      SQL
      .select(<<~SQL)
        pizza_variants.*,
        COALESCE(MAX(cart_items.quantity), 0) AS quantity
      SQL
  end
end
