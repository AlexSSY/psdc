class ApplicationForm
  include ActiveModel::API
  include ActiveModel::Attributes

  define_callbacks :save, only: :after
  define_callbacks :commit, only: :after

  class << self
    def from(params)
      new(params.permit(attribute_names.map(&:to_sym)))
    end

    def model_name
      @model_name ||= ActiveModel::Name.new(nil, nil, self.name.sub(/Form$/, ""))
    end

    def model_name=(name)
      @model_name = ActiveModel::Name.new(nil, nil, name)
    end
  end

  delegate :model_name, to: :class

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
