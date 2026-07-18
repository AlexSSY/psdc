class PizzasProcessor < Rubanok::Processor
  SORT_ORDERS = %w[asc desc].freeze
  SORTABLE_FIELDS = %w[id name created_at].freeze

  def pizzas
    @pizzas_table ||= Pizza.arel_table
  end

  match :sort_by, :sort do
    having "price", "asc" do
      raw.order(Arel.sql("total_pizza_price ASC"))
    end

    having "price", "desc" do
      raw.order(Arel.sql("total_pizza_price DESC"))
    end
  end
end
