# frozen_string_literal: true

class FormFieldComponent < ApplicationComponent
  option :builder
  option :attribute
  option :type, default: -> { :text }
  option :input_class, default: -> { "" }

  def form
    builder.object
  end

  def errors
    form.errors.full_messages_for(attribute)
  end

  def invalid?
    errors.any?
  end

  def input_classes
    classes = "rounded-xl py-2 px-3 border border-black/20 w-full"
    classes += " #{input_class}" unless input_class.empty?
    classes += " border-red-500" if invalid?
    classes
  end
end
