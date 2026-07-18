class ApplicationComponent < ViewComponent::Base
  include ActiveModel::Validations
  include Keynote::Helper
  extend Dry::Initializer[undefined: false]
end
