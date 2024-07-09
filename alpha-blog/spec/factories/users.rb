FactoryBot.define do
    factory :user, class: User do
      username { "John" }
      email    { "john.doe@example.com" }
      password { "12345uihdeozigd6" }  # Ensure this meets Devise's minimum length requirement
      role     { "user" }
    end
  
    factory :admin, class: User do
      username { "Jonadmin" }
      email    { "test@example.com" }
      password { "1234pidhzepidh56" }  # Same here, use a secure password in actual apps
      role     { "admin" }
    end
  
    factory :restricted, class: User do 
      username { "Jonrestricted" }
      email    { "jonrest@example.com" }
      password { "123pihdzeph456" }
      role     { "restricted" }
    end
  end
  