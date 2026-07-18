class CartsController < ApplicationController
  def clear
    @cart_items = current_cart.cart_items.to_a
    current_cart.cart_items.destroy_all
    respond_to do |format|
      format.turbo_stream
    end
  end
end
