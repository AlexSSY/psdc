class PizzaCustomsController < ApplicationController
  before_action :set_pizza_custom

  def new
    @pizza_tops = PizzaTop.all
    @pizza_sizes = PizzaSize.all
    @pizza_crusts = PizzaCrust.all
    @pizza_doughs = PizzaDough.all
    @pizza_top_categories = PizzaTopCategory.all

    if @pizza_custom.new_record?
      @pizza_custom.assign_attributes(create_params)
      @pizza_custom.save!
    end
  end

  def edit
  end

  def create
    if @pizza_custom.new_record?
      @pizza_custom.pizza_id = base_pizza&.id || Pizza.find_by!(slug: "baza").id
      @pizza_custom.assign_attributes(create_params)
      @pizza_custom.save!
    else
      # update
    end

    respond_to do |foramt|
      format.turbo_stream
    end
  end

  private

  def set_pizza_custom
    @pizza_custom = PizzaCustom.find_or_initialize_by(
      fingerprint: PizzaCustom.hash_request_params(create_params)
    )
  end

  def create_params
    params.permit(
      :pizza_id,
      :pizza_size_id,
      :pizza_dough_id,
      :pizza_crust_id,
      pizza_custom_ingredients_attributes: [
        :pizza_top_id,
        :quantity
      ]
    )
  end
end
