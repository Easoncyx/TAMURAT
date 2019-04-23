FactoryBot.define do
    factory :answer, :class => Answer do 
        company_id {nil}
        question_id {nil}
        level {1}
        validated {false}
        validator_id {nil}
        validator_comment {nil}
        score {3}
    end
end
