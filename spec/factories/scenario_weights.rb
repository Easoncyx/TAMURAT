require "faker"

FactoryBot.define do
    factory :scenario_weight1, :class => ScenarioWeight do
        company_id {nil}
        scenario_id {nil}
        weight {2}
    end
    factory :scenario_weight2, :class => ScenarioWeight do
        company_id {nil}
        scenario_id {nil}
        weight {1}
    end    
end