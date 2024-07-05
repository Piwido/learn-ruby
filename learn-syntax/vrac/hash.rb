details = {'name' => 'Ines', 'age'=>24, "favcolor"=>"black"}

p details["name"]

another_hash = {a:1, b:2, c:3} #turns a, b, c in symbols  :name

puts another_hash[:a]
puts details.keys
puts details.values

details.each do |key, value|
    puts "The class for the key is #{key.class} and the value is #{value.class}"
end

another_hash.each do |key, value|
    puts "The class for the key is #{key.class} and the value is #{value.class}"
end

details["new info"] = "None" # ajouter une clé

p details

details.each { |key, value| puts "Clé : #{key}, valeur : #{value}"}

p details.select { |key, value| value.is_a?(String)}

20.times {print("-")}
print("\n")
details = {'name' => 'Ines', 'age'=>24, "favcolor"=>"black"}

p details.select { |key, value| !(value.is_a?(String))}