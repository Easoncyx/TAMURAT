class Privilege < ApplicationRecord
    belongs_to :user, class_name: "User"
    belongs_to :scenario, class_name: "Scenario"
    validates :user_id, presence: true
    validates :scenario_id, presence: true
end
