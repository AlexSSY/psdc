class Pizza::CatalogQuery < ApplicationQuery
  def resolve(cart:)
    pizzas = relation
      .includes(image_attachment: :blob)
      .select(<<~SQL)
      pizzas.*,
      pizza_sizes.name AS pizza_size_name,
      pizza_crusts.name AS pizza_crust_name,
      pizza_doughs.name AS pizza_dough_name,
      COALESCE(pizza_crust_infos.price, 0)
        + pizza_dough_infos.price
        + SUM(pizza_ingredients.quantity * pizza_tops.price)
        AS total_pizza_price,
      GROUP_CONCAT(
        CONCAT(pizza_tops.name, ' x', pizza_ingredients.quantity)
        SEPARATOR ','
      ) AS ingredients_list
    SQL
      .joins(:pizza_size)
      .joins(:pizza_dough)
      .joins(pizza_ingredients: :pizza_top)
      .joins(<<~SQL)
        LEFT JOIN pizza_crusts
          ON pizza_crusts.id = pizzas.pizza_crust_id
      SQL
      .joins(<<~SQL)
        LEFT JOIN pizza_crust_infos
          ON pizza_crust_infos.pizza_crust_id = pizzas.pizza_crust_id
         AND pizza_crust_infos.pizza_size_id = pizzas.pizza_size_id
      SQL
      .joins(<<~SQL)
        JOIN pizza_dough_infos
          ON pizza_dough_infos.pizza_dough_id = pizzas.pizza_dough_id
         AND pizza_dough_infos.pizza_size_id = pizzas.pizza_size_id
      SQL
      .group("pizzas.id")

    # preload_variants(pizzas, cart)

    pizzas
  end

  private

  def preload_variants(pizzas, cart)
    ActiveRecord::Associations::Preloader.new(
      records: pizzas.load,
      associations: :pizza_variants,
      scope: PizzaVariant.catalog_query(cart:)
    ).call
  end
end
