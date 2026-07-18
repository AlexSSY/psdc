class PizzaVariantsController < ApplicationController
  def variant_partial
    @variant = PizzaVariant.catalog_query(cart: current_cart).find_by(id: params[:id])
    respond_to do |format|
      format.turbo_stream
    end
  end
end
