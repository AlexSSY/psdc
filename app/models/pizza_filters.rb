class PizzaFilters
  extend Dry::Initializer

  option :sort, optional: true
  option :sort_by, optional: true
  option :ingredients, default: proc { [] }
end
