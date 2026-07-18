# frozen_string_literal: true

class LazyImageComponent < ApplicationComponent
  option :image
  option :width, optional: true
  option :height, optional: true

  private

  def result_image
    @result_image ||= begin
      return image unless width || height
      image.variant(resize_to_limit: [ width, height ])
    end
  end
end
