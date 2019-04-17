class ScenarioWeight < ApplicationRecord
  belongs_to :company, :foreign_key => :company_id, :class_name => "Company"
  belongs_to :scenario, :foreign_key => :scenario_id, :class_name => "Scenario"
end
