FactoryBot.define do
    factory :question, :class => Question do
        name  {'Business_1_q1'}
        weight {1}
        #subcategory_id {1}
    end
    
    factory :subcategory, :class => Subcategory do
        name  {'Business_1'}
        weight_sum {3}
        category_id {1}
        weight {1} 
    end    
    
    
    
    
end


