# frozen_string_literal: true

class HeaderCartComponent < ApplicationComponent
  option :cart

  delegate :user_signed_in?, to: :helpers
end
