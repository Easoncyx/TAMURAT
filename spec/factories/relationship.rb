FactoryBot.define do
    factory :relationship, :class => Relationship do 
        answer_id {nil}
        evidence_id {nil}
        comment {nil}
    end
    
    # factory :company1, :class => Company do 
    #     user_id {nil}
    #     validated {true}
    #     weight_sum {5}
    #     score {4}
    # end
end
