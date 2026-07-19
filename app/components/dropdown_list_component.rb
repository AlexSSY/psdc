# frozen_string_literal: true

class DropdownListComponent < ApplicationComponent
  renders_one :button
  renders_many :items
end
