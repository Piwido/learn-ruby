database = [
    {username: "James", password: "password1"},
    {username: "Mike", password: "password2"},
    {username: "John", password: "password3"},
    {username: "Jane", password: "1"}
]


puts ("Welcome to the authenticator")
25.times {print("-")}
puts
test = false
numAttempts = 0
puts ("This programm will take input and compare password")

while numAttempts <= 3 && test == false
    print("Username : ")
    name = gets.chomp
    print("Password : ")
    pw = gets.chomp
    s_entries = database.select {|entry|  entry[:username]== name && entry[:password]==pw}
    numAttempts = numAttempts+1
    if !(s_entries.empty?) 
        puts s_entries
        puts 
        25.times {print("-")}
        puts
    else 
        puts "Wrong credentials"
        puts
    end
    puts "Remaining attemps : #{3 - numAttempts}"

        puts ("Press n to quit or any other key to continue")
    exit = gets.chomp
    break if exit == "n"



end
    
    
    


