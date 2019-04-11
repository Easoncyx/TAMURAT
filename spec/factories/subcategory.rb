
FactoryBot.define do
    factory :sub, :class => Subcategory do
        name {"Business_1"}
        weight_sum {3}
#        category_id {nil}
        weight {1}
    end
end

