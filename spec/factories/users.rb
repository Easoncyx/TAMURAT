require "faker"

FactoryBot.define do
    factory :user, :class => User do
        email {"szy@tamu.edu"}
        name {"szy"}
        password {"111111"}
        login_id {"1"}
        role {"Administrator"}
    end
    
    factory :pw_changer,:class => User  do
        email {"szy1@tamu.edu"}
        name {"szy1"}
        password {nil}
        login_id {"2"}
        role {"Administrator"}
    end
    
    
    factory :login_user, :class => User do

    
        factory :admin, :class => User do 
            email {Faker::Internet.email}
            name {Faker::Internet.user_name}
            password {"111111"}
            password_confirmation {"111111"}
#            sequence(:login_id) { |n| "user#{n}"}
            login_id {"1000"}
            role {"Administrator"}    
        end
        
        factory :admin_for_create, :class => User do 
            email {Faker::Internet.email}
            name {Faker::Internet.user_name}
            password {"111111"}
            password_confirmation {"111111"}
#            sequence(:login_id) { |n| "user#{n}"}
            login_id {nil}
            role {"Administrator"}    
        end        
        
        factory :failed, :class => User do 
            email {nil}
            name {Faker::Internet.user_name}
            password {"111111"}
            password_confirmation {"111111"}
#            sequence(:login_id) { |n| "user#{n}"}
            login_id {nil}
            role {"Administrator"}    
        end         
        
    end
end