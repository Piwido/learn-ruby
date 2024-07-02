address = [1, 2, 3, 4, 5, 6, 7, 8, 9]
print address 
print "\n"
address.reverse!

greeting = "Hello, Ruby!"
puts greeting

def greet(name)
    puts "Hello " + name + "!"
    puts "Hello #{name}!"
end

greet "Ines"

print "A string".methods