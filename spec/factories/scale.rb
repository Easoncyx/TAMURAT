
FactoryBot.define do
    factory :scale1, :class => Scale do
        name {'B trust level 0'}
        level {'N/A'}
#        category_id {nil}
        score {0}
    end
    factory :scale2, :class => Scale do
        name {'B trust level 1'}
        level {'1'}
#        category_id {nil}
        score {0.1}
    end
end



