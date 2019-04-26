class Scale < ApplicationRecord
  belongs_to :category
  validates :category_id, presence: true
  validates :name, presence: true
  validates :level, presence: true
  validates :score, presence: true, format:{ with: self.valid_weight_regex }
end
