require 'bcrypt'

my_password = BCrypt::Password.create("my password")

puts my_password
puts my_password.version
puts my_password.cost
puts my_password=="my password"
puts my_password=="bl"

my_password = BCrypt::Password.new("$2a$12$/G9phbytZ8zrteiWn0r26OBP7INJC6qn40w.mPFzdmuzLcznkhM3q")
puts my_password == "my password"


my_test_pw = BCrypt::Password.create("test")
my_test_pw1 = BCrypt::Password.create("test")
my_test_pw2 = BCrypt::Password.create("test")

puts my_test_pw == my_test_pw1 #false
puts my_test_pw == "test" #true
