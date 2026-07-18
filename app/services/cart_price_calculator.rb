class CartPriceCalculator < ApplicationService
  def initialize(cart)
    @cart = cart
  end

  def call
    table = CartItem.arel_table

    query = table
      .project(
        Arel::Nodes::NamedFunction.new(
          "SUM",
          [ table[:unit_price] * table[:quantity] ]
        )
      )
      .where(table[:cart_id].eq(@cart.id))

    CartItem.connection.select_value(query.to_sql).to_d
  end
end
