require "faker"

FactoryBot.define do
    factory :user, :class => User do
        email {"szy@tamu.edu"}
        name {"szy"}
        password {"111111"}
        password_confirmation {"111111"}
        login_id {"1"}
        role {"Administrator"}
        
        factory :user_pw, :class => User do
            password {"1111111"}
            password_confirmation {"1111111"}
        end
    end

    
    factory :pw_changer,:class => User  do
        email {Faker::Internet.email}
        name {Faker::Internet.user_name}
        password {111111}
        login_id {"3"}
        role {"Administrator"}
    end
    
    factory :validator,:class => User  do
        email {Faker::Internet.email}
        name {Faker::Internet.user_name}
        password {"1111111"}
        password_confirmation {"1111111"}
        login_id {"2"}
        role {"Validator"}
    end
    
    
    factory :login_user, :class => User do
        
        factory :representative, :class => User do 
            email {Faker::Internet.email}
            name {Faker::Internet.user_name}
            password {"111111"}
            password_confirmation {"111111"}
#            sequence(:login_id) { |n| "user#{n}"}
            login_id {"1001"}
            role {"Company Representative"}    
        end
    
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
        
        factory :DM, :class => User do 
            email {Faker::Internet.email}
            name {Faker::Internet.user_name}
            password {"111111"}
            password_confirmation {"111111"}
            login_id {1002}
            role {"Decision Maker"}    
        end         

        factory :failed2, :class => User do 
            email {Faker::Internet.email}
            name {Faker::Internet.user_name}
            password {"111111"}
            password_confirmation {"1111111"}
#            sequence(:login_id) { |n| "user#{n}"}
            login_id {nil}
            role {"Administrator"}    
        end   
 
        factory :failed3, :class => User do 
            email {Faker::Internet.email}
            name {nil}
            password {"111111"}
            password_confirmation {"111111"}
#            sequence(:login_id) { |n| "user#{n}"}
            login_id {nil}
            role {"Company Representative"}    
        end         

        factory :failed4, :class => User do 
            email {Faker::Internet.email}
            name {Faker::Internet.user_name}
            password {"111111"}
            password_confirmation {"1111111"}
#            sequence(:login_id) { |n| "user#{n}"}
            login_id {nil}
            role {"Company Representative"}    
        end       
    end
end