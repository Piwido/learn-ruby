require_relative 'progress'

class Sous_tache 
    attr_accessor :progress, :description, :titre
    attr_reader :deadline, #:number_of_taches 
    #@@number_of_taches = 0
    #@id_tache
    @titre
    @description
    @deadline
    @progress


    def initialize (titre, theme, user)
        @titre = titre
        @progress = Progress.new(:todo)
        @description = ""
        @deadline = nil
        # @id_tache = @@number_of_taches
        # @@number_of_taches +=1
    end



    def specify(description, deadline)
        @description = description
        @deadline = deadline
    end

    def change_progress(new_state)
        @progress = Progress.new(new_state)
      end
    
    def delete_task() {
        
    } 


    def to_s() 
        puts "-------------------------"
        puts "Numéro : #{@id_tache}"
        puts "Titre : #{titre}"
        puts "Description : #{description}"
        puts "Avancée : #{progress}"
        puts "Theme : #{theme}"
        puts "Sous-theme : #{theme}"
        puts "Assignée à  : #{user}"
        puts "Progrès : #{progress}"
        puts "Sous-theme : #{theme}"
        puts "Deadline : #{deadline}"
        puts
        puts "-------------------------"
        puts "-------------------------"
    end 
end


matache = Tache.new("Finir formation", "Professionnel", "Ines")
puts matache
matache.specify("Code", "Il y a un formation de 40h à faire sur le ruby.", "25/02")
puts matache

# On crée quelques classes pour tester
tache1 = Tache.new("Manger gouter", "Alimentation", "Ines")
tache2 = Tache.new("Faire les courses", "Alimentation", "Ines")
tache3 = Tache.new("Faire le ménage", "Ménage", "Ines")
tache4 = Tache.new("Faire du sport", "Sport", "Ines")

tache1.change_progress(:doing)
tache4.change_progress(:done)


puts tache1
puts tache2
puts tache3
puts tache4








