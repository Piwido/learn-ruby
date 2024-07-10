FactoryBot.define do 
    factory :category do 
        name { "Testcategory" }
    end 

    trait :no_name do 
        name { nil }
    end 

    trait :short_name do 
        name { "a" }
    end 
end 