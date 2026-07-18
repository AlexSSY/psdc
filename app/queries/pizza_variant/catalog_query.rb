class PizzaVariant::CatalogQuery < ApplicationQuery
  def resolve(cart:)
    relation
      .preload(:pizza_variant_ingredients)
      .joins(<<~SQL)
        JOIN pizza_dough_infos
          ON pizza_dough_infos.pizza_size_id = pizza_variants.pizza_size_id
         AND pizza_dough_infos.pizza_dough_id = pizza_variants.pizza_dough_id
      SQL
      .joins(<<~SQL)
        LEFT JOIN pizza_crust_infos
          ON pizza_crust_infos.pizza_size_id = pizza_variants.pizza_size_id
         AND pizza_crust_infos.pizza_crust_id = pizza_variants.pizza_crust_id
      SQL
      .joins(:pizza_variant_ingredients)
      .joins("JOIN pizza_tops ON pizza_tops.id = pizza_variant_ingredients.pizza_top_id")
      .joins(<<~SQL)
        LEFT JOIN cart_items
          ON cart_items.cart_itemable_type = 'PizzaVariant'
         AND cart_items.cart_itemable_id = pizza_variants.id
         AND cart_items.cart_id = #{cart.id}
      SQL
      .select(<<~SQL)
        pizza_variants.*,
        (
          pizza_dough_infos.price
          + COALESCE(pizza_crust_infos.price, 0)
          + SUM(pizza_tops.price * pizza_variant_ingredients.quantity)
        ) AS price,
        COALESCE(MAX(cart_items.quantity), 0) AS quantity
      SQL
      .group(:id)
  end
end
