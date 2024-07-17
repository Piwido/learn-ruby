FactoryBot.define do
  factory :user do
    sequence :username do |n|
      "personne#{n}"
    end
    sequence :email do |n|
      "personne#{n}@example.com"
    end
    password { '12345uihdeozigd6' }
    role     { 'user' }

    trait :admin do
      role { 'admin' }
    end

    trait :restricted do
      role { 'restricted' }
    end

    trait :no_mail do
      email { '' }
    end

    trait :no_username do
      username { '' }
    end

    trait :short_password do
      password { '123' }
    end

    trait :wrong_password do
      password { 'A wrong password' }
    end

    trait :no_role do
      role { nil }
    end

    trait :user2 do
      username { 'Jane' }
      email    { 'Janet.doe22@exa.com' }
    end
  end

  factory :another_user do
    username { 'Janet' }
    email    { 'test.test@test.test' }
    password { '12345uihdeozigd6' }
    role     { 'user' }
  end
end
