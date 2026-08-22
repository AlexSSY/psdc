class ApplicationForm
  include ActiveModel::API
  include ActiveModel::Attributes

  define_callbacks :save, only: :after
  define_callbacks :commit, only: :after

  class << self
    delegate :from, to: :new

    def model_name
      @model_name ||= ActiveModel::Name.new(nil, nil, self.name.sub(/Form$/, ""))
    end

    def model_name=(name)
      @model_name = ActiveModel::Name.new(nil, nil, name)
    end
  end

  delegate :model_name, to: :class

  def from(params)
    attr_list = self.class.attribute_names.map(&:to_sym)
    assign_attributes(params.permit(*attr_list))
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

  def merge_errors!(other)
    other.errors.each do |e|
      errors.add(e.attribute, e.type, message: e.message)
    end
  end
end
