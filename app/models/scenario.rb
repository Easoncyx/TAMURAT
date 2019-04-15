class Scenario < ApplicationRecord
  has_many :privileges, class_name: "Privilege", foreign_key: "scenario_id", dependent: :destroy
  has_many :users, through: :privileges
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }

end
