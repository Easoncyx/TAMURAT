class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  VALID_WEIGHT_REGEX = /\A[0-9]+(\.[0-9]+)?\z/
  def self.valid_weight_regex
    @regex = VALID_WEIGHT_REGEX
  end
end
