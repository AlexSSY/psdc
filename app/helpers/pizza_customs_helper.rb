module PizzaCustomsHelper
  def pizza_editor_field(record, field_name, options = {})
    options.update({
      data: {
          pizza_editor_target: field_name.to_s.gsub("_id", "_input")
        }
      })
    hidden_field_tag(field_name, record.send(field_name), options)
  end
end
