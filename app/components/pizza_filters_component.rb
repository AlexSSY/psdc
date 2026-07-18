# frozen_string_literal: true

class PizzaFiltersComponent < ApplicationComponent
  option :pizza_filters
  option :ingredients

  def price_select_items
    { "---" => "", "Price" => "price" }
  end

  def sort_by_select_items
    { "---" => "", "Asc" => "asc", "Desc" => "desc" }
  end
end
