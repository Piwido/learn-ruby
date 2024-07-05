# Pour importer sans le include
# Ce sont des méthodes de classes

module Crud2
  require 'bcrypt'
  puts "Module Crud2 loaded"
  
  def Crud2.create_hash_digest(password)
    BCrypt::Password.create(password)
  end
  
  def Crud2.verify_hash_digest(password)
    BCrypt::Password.new(password)
  end
  
  def Crud2.create_secure_users(list_of_users)
    list_of_users.each do |user_record|
      user_record[:password] = create_hash_digest(user_record[:password])
    end
    list_of_users
  end


  def Crud2.authenticate_user(username, password, list_of_users)
    list_of_users.each do |user_record|
      if user_record[:username]==username && verify_hash_digest(user_record[:password])
        return user_record
      end
    end
    puts "Invalid username or password"

  end

end

# # main.rb
# require_relative 'crud2'
# #include Crud2

# users = [
#     { username: "mashrur", password: "password1" },
#     { username: "jack", password: "password2" },
#     { username: "arya", password: "password3" },
#     { username: "jonshow", password: "password4" },
#     { username: "heisenberg", password: "password5" }
#   ]

# # Create secure users
# hashed_users = Crud2.create_secure_users(users)
# puts hashed_users

# # Authenticate a user
# puts Crud2.authenticate_user("mashrur", "password1", hashed_users)

# module Crud3
#   require 'bcrypt'
#   puts "Module Crud3 loaded"
  
#   def self.create_hash_digest(password)
#     BCrypt::Password.create(password)
#   end
  
#   def self.verify_hash_digest(password)
#     BCrypt::Password.new(password)
#   end
  
#   def self.create_secure_users(list_of_users)
#     list_of_users.each do |user_record|
#       user_record[:password] = create_hash_digest(user_record[:password])
#     end
#     list_of_users
#   end


#   def self.authenticate_user(username, password, list_of_users)
#     list_of_users.each do |user_record|
#       if user_record[:username]==username && verify_hash_digest(user_record[:password])
#         return user_record
#       end
#     end
#     puts "Invalid username or password"

#   end

# end