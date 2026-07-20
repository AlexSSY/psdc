# frozen_string_literal: true

class PizzaFiltersComponent < ApplicationComponent
  option :pizza_filters
  option :ingredients

  def sort_by_select_items
    { "select" => "", "Price Asc" => "price_asc", "Price Desc" => "price_desc" }
  end

  def selected_ingredients(category)
    pizza_filters.ingredients.select { |ingredient| ingredients[category].values.include?(ingredient.to_i) }
  end
end
