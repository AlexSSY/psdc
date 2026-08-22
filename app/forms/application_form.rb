class ApplicationForm
  include ActiveModel::API
  include ActiveModel::Attributes

  define_callbacks :save, only: :after
  define_callbacks :commit, only: :after

  class << self
    delegate :from, to: :new
  end

  def from(params)
    attr_list = self.class.attribute_names.map(&:to_sym)
    assign_attributes(params.permit(**attr_list))
    self
  end

  def save
    return false unless valid?

    with_transaction { submit! }
  end

  private

  def with_transaction(&)
    ApplicationRecord.transaction(&)
  end

  def submit!
    raise NotImplementedError
  end
end
