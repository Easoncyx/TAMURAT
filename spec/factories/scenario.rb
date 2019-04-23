require "faker"

FactoryBot.define do
    factory :scenario1, :class => Scenario do
        name {'shigure'}
        description {'kancolle'}
        score {1}
    end
    factory :scenario2, :class => Scenario do
        name {'kongo'}
        description {'kancolle'}
        score {2}
    end    
    
    factory :scenario3, :class => Scenario do
        name {'kongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongokongo'}
        description {'kancolle'}
        score {2}
    end     
end