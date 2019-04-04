FactoryBot.define do
    factory :user, :class => User do
        email {"szy@tamu.edu"}
        name {"szy"}
        password {"111111"}
        login_id {"2"}
        role {"Administrator"}
    end
    
    factory :pw_changer,:class => User  do
        email {"szy1@tamu.edu"}
        name {"szy1"}
        password {nil}
        login_id {"5"}
        role {"Administrator"}
    end
end