class PizzasProcessor < Rubanok::Processor
  SORT_ORDERS = %w[asc desc].freeze
  SORTABLE_FIELDS = %w[id name created_at].freeze

  def pizzas_table
    @pizzas_table ||= Pizza.arel_table
  end

  match :sort_by do
    having "price_asc" do
      raw.order(Arel.sql("total_pizza_price ASC"))
    end

    having "price_desc" do
      raw.order(Arel.sql("total_pizza_price DESC"))
    end
  end

  map :ingredients do |ingredients:|
    raw.joins(:pizza_ingredients)
        .where(pizzas_table[:id].in(
          PizzaIngredient.arel_table
                        .project(PizzaIngredient.arel_table[:pizza_id])
                        .where(PizzaIngredient.arel_table[:pizza_top_id].in(ingredients))
        )
      )
  end
end
