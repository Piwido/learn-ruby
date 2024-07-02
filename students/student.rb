require_relative 'crud'

class Student
    include Crud
    #provides with setter and getter for each attributes specified
    attr_accessor  :first_name,  :last_name, :email, :password
    attr_reader :username
    @first_name #instance variable
    @last_name
    @email
    @username #= "piwido" doesn't work because then it is part of the class, not the instance
    @password

    def initialize(firstname, lastname, email, password)
        @username = "piwido"
        @first_name = firstname
        @last_name = lastname
        @email = email
        @password = password
    end

    #Override built in to_s
    def to_s 
        "First name : #{@first_name}\nLast name : #{@last_name}\nEmail : #{@email}\nUsername : #{@username}"
    end
    
    # def password(pw)
    #     @password = pw
    # end
    """
    #A proper setter
    def first_name=(name)
        @first_name=name
    end

    #A proper getter
    def first_name
        @first_name
    end
    """

end
# A proper initalistion
oisin = Student.new("Oisin", "Perez", "oisindu33@gmail.com", "nnpmnpo")
ugo = Student.new("Ugo", "Tastet", "deih@gmail.com", "cejpoceôec")

oisin.username
ugo.username

puts oisin
hashed_password = oisin.create_hash_digest(oisin.password)
puts hashed_password


# puts oisin
# oisin.last_name = ugo.last_name
# puts oisin

# oisin.create_hash_pass


# # Instanciation sans initialisation
# ines = Student.new

# # Not a real setter but it works
# ines.password("jiidnpdizn")

# # A proper use of a proper setter
# ines.first_name = "ines"
# ines.last_name = "piwi"
# ines.email = "piwi@chat.fr"
# ines.username
# # Whenver you print an object, it defaults to the to_s method
# puts ines

# puts "First name : #{ines.first_name}"

