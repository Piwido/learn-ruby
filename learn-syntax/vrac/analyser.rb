
puts "What is your first name ?"
first_name = gets.chomp

puts "What is your last name ?"
last_name = gets.chomp

puts "What is your age ?"
age = gets.chomp.to_i

puts "Your full name is #{first_name} #{last_name}. It is #{(first_name+last_name).length} letters long. You are #{age} years old.\n Your reversed name is #{(first_name+last_name).reverse}."
