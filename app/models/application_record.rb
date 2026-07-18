class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def get_fingerprint_for_hash(hash_value)
    
  end
end
