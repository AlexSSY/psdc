module ApplicationHelper
  def component(name, *args, **kwargs, &block)
    render "components/#{name}", *args, **kwargs, &block
  end

  def cart_button_for(record)
    component("#{record.class.name.underscore}_cart_button")
  end

  def product_card_for(record)
    component("product_cards/#{record.class.name.underscore}", record: record)
  end

  def cart_item_for(record)
    component("cart_items/#{record.cart_itemable_type.underscore}", cart_item: record)
  end

  def pizza_custom_path_for(pizza_variant)
    new_pizza_custom_path(
      pizza_id: pizza_variant.pizza.id,
      pizza_size_id: pizza_variant.pizza_size_id,
      pizza_dough_id: pizza_variant.pizza_dough_id,
      pizza_crust_id: pizza_variant.pizza_crust_id,
      pizza_custom_ingredients_attributes:
        pizza_variant.pizza_variant_ingredients.map do |i|
          {
            pizza_top_id: i.pizza_top_id,
            quantity: i.quantity
          }
        end
    )
  end

  def turbo_button_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}

    html_options[:form] ||= {}
    html_options[:form][:data] ||= {}
    html_options[:form][:data][:turbo_stream] = true

    button_to(name, options, html_options, &block)
  end

  def post_button_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    html_options[:form] ||= {}
    html_options[:form][:data] ||= {}
    html_options[:form][:data][:turbo_stream] = true

    options ||= {}
    options[:method] = :post

    button_to(name, options, html_options, &block)
  end

  def delete_button_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    html_options[:form] ||= {}
    html_options[:form][:data] ||= {}
    html_options[:form][:data][:turbo_stream] = true

    options ||= {}
    options[:method] = :delete

    button_to(name, options, html_options, &block)
  end
end
