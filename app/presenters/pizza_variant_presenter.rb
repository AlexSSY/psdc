class PizzaVariantPresenter < Keynote::Presenter
  presents :pizza_variant

  delegate :id, :price, :quantity, to: :pizza_variant

  def dom_id
    @dom_id ||= [
      pizza_variant.class.name.underscore,
      "cart_item_button",
      pizza_variant.id
    ].join("_")
  end

  def class_name
    pizza_variant.class.name
  end

  def cart_itemable_type
    class_name
  end

  def cart_itemable_id
    id
  end

  def js_data_variant
    "#{pizza_variant.pizza_size_id}#{pizza_variant.pizza_dough_id}#{pizza_variant.pizza_crust_id || 0}"
  end

  def json_map_key
    "#{pizza_variant.pizza_crust_id || 0}#{pizza_variant.pizza_size_id}#{pizza_variant.pizza_dough_id}"
  end
end
