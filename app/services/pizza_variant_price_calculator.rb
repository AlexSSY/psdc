class PizzaVariantPriceCalculator < ApplicationService
  def initialize(pizza_variant)
    @pizza_variant = pizza_variant
  end

  def call
    pv  = PizzaVariant.arel_table
    pci = PizzaCrustInfo.arel_table
    pdi = PizzaDoughInfo.arel_table

    price =
    Arel::Nodes::Addition.new(
      Arel::Nodes::NamedFunction.new(
        "COALESCE",
        [ pci[:price], 0 ]
      ),
      pdi[:price]
    )

    query = pv
    .project(price.as("price"))
    .join(
      pci,
      Arel::Nodes::OuterJoin
    ).on(
      pci[:pizza_crust_id].eq(pv[:pizza_crust_id])
        .and(pci[:pizza_size_id].eq(pv[:pizza_size_id]))
    )
    .join(pdi)
    .on(
      pdi[:pizza_dough_id].eq(pv[:pizza_dough_id])
        .and(pdi[:pizza_size_id].eq(pv[:pizza_size_id]))
    )
    .where(pv[:id].eq(@pizza_variant.id))

    PizzaVariant.connection.select_value(query.to_sql).to_d
  end
end
