class PizzasController < ApplicationController
  before_action :prepare_pizza_parameters, only: %w[index]
  before_action :prepare_filters, only: %w[index]

  def index
    @pizzas = PizzasProcessor.call(
      Pizza.catalog(cart: current_cart).all,
      params
    )

    ActiveRecord::Associations::Preloader.new(
      records: @pizzas.load,
      associations: :pizza_variants,
      scope: PizzaVariant.catalog_query(cart: current_cart)
    ).call
  end

  private

  def prepare_filters
    @pizza_filters = PizzaFilters.new(**params.permit(:sort, :sort_by, ingredients: []).to_h.symbolize_keys)
    @ingredients = PizzaTopCategoryFiltersCalculator.new.call
  end

  def prepare_pizza_parameters
    @pizza_sizes = PizzaSize.all
    @pizza_doughs = PizzaDough.all
    @pizza_crusts = PizzaCrust.all
  end
end
