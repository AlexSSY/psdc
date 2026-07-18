class PizzaPresenter < Keynote::Presenter
  presents :pizza

  delegate  :pizza_size_id,
            :pizza_crust_id,
            :pizza_dough_id,
            :pizza_variants,
            :image,
            :name,
            :pizza_dough_name,
            :pizza_crust_name,
            :pizza_size_name, to: :pizza

  def ingredients
    pizza.ingredients_list.split(",")
  end

  def default_variant
    pizza.pizza_variants.first
  end

  def json_variants_map
    pizza.pizza_variants.to_h do
      [ k(_1).json_map_key, _1.id ]
    end.to_json
  end
end
