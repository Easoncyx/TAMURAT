require "faker"

FactoryBot.define do
    factory :scenario1, :class => Scenario do
        name {'shigure'}
        description {'kancolle'}
        user_id {nil}
    end
    factory :scenario2, :class => Scenario do
        name {'kongo'}
        description {'kancolle'}
        user_id {nil}
    end    
end