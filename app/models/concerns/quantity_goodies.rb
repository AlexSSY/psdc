module QuantityGoodies
  extend ActiveSupport::Concern

  included do
    validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

    def increase_quantity!
      self.quantity += 1
      self.save!
    end

    def decrease_quantity!
      self.quantity -= 1
      if self.quantity > 0
        self.save!
      else
        self.destroy!
      end
    end
  end
end
