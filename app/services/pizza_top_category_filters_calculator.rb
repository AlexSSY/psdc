class PizzaTopCategoryFiltersCalculator < ApplicationService  
  def call
    PizzaTopCategory.includes(:pizza_tops).to_h do |category|
      [
        category.name,
        category.pizza_tops.to_h { |top| [ top.name, top.id ] }
      ]
    end
  end
end
