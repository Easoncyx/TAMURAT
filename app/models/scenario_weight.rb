class ScenarioWeight < ApplicationRecord
  belongs_to :company, :foreign_key => :company_id, :class_name => "Company"
  belongs_to :scenario, :foreign_key => :scenario_id, :class_name => "Scenario"

  validates :weight, presence: true, format:{ with: self.valid_weight_regex }
end
