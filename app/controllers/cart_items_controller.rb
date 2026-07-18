class CartItemsController < ApplicationController
  before_action :moderate_cart_itemable_type
  before_action :set_cart_item

  def create
    @cart_item.increase_quantity!
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @cart_item.decrease_quantity!
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy_all
    @cart_item.destroy!
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_cart_item
    @cart_itemable = request_params[:cart_itemable_type]
      .constantize.find_by(id: request_params[:cart_itemable_id])

    @cart_item = current_cart.cart_items.find_or_initialize_by(cart_itemable: @cart_itemable)
    return unless @cart_item.new_record?
    @cart_item.quantity = 0
    @cart_item.unit_price = @cart_itemable.price
  end

  def request_params
    params.permit(:cart_itemable_type, :cart_itemable_id)
  end

  ALLOWED_CART_ITEMABLES = %w[PizzaVariant DrinkVariant PizzaCustom].freeze
  def moderate_cart_itemable_type
    head :forbidden unless ALLOWED_CART_ITEMABLES.include? params[:cart_itemable_type]
  end
end
