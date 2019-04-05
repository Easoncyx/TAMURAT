class Scenario < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }
end
