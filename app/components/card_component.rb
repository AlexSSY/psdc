# frozen_string_literal: true

class CardComponent < ApplicationComponent
  renders_one :image
  renders_one :title
  renders_one :body
end
