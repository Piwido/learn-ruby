dial_book = {
    "newyork" => "212",
    "newbrunswick" => "732",
    "edison" => "908",
    "plainsboro" => "609",
    "sanfrancisco" => "301",
    "miami" => "305",
    "paloalto" => "650",
    "evanston" => "847",
    "orlando" => "407",
    "lancaster" => "717"

}

def get_city_names(somehash)
    city_names = somehash.keys
end

def get_area_code(somehash, key)
    somehash[key]
end 

loop do
    puts "Do you want to lookup an area code based on a city name ?"
    input = gets.chomp
    break if input != "y"

    if input.capitalize=="Y"
        print get_city_names (dial_book)
        puts
        puts "Enter your selection"
        city = gets.chomp.downcase
        if !(dial_book.keys.include?(city))
            puts "Impossible de trouver la ville demandée"
        else puts "The area code for #{city} is #{dial_book[city]}"
        end
    end
end




