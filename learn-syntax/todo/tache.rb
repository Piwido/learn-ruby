require_relative 'progress'
require_relative 'priorite'

class Tache 
    attr_accessor :progress, :priorite, :description, :titre
    attr_reader :theme, :soustheme, :user, :deadline, :id_tache
  
    @@number_of_taches = 0
    @@taches = []
  
    def initialize(titre, theme, user)
      @titre = titre
      @theme = theme
      @user = user
      @progress = Progress.new(:todo)
      @priorite = Priorite.new(:low)

      @description = ""
      @deadline = nil
      @id_tache = @@number_of_taches
      @@number_of_taches += 1
      @@taches << self # Met l'instance dans le tableau d'instances
    end
  


    def specify(soustheme, description, deadline)
        @soustheme = soustheme
        @description = description
        @deadline = deadline
    end

    def change_progress(new_state)
        @progress = Progress.new(new_state)
    end
    
    def self.delete_task(id_tache)
        @@taches.delete_if { |tache| tache.id_tache == id_tache }
    end

    def self.show_tasks()
        @@taches.each {|tache| puts tache}
    end

    def self.show_tasks_theme(theme1)
        @@taches.each do |tache|
          if tache.theme == theme1
            puts tache
          end
        end
    end


    def to_s() 
        puts    
        puts "-------------------------"
        puts "-------------------------"
        puts "-------------------------"
        puts "Numéro : #{@id_tache}"
        puts "Titre : #{titre}"
        puts "Description : #{description}"
        puts "Avancée : #{progress}"
        puts "Theme : #{theme}"
        puts "Sous-theme : #{soustheme}"
        puts "Assignée à  : #{user}"
        puts "Progrès : #{progress}"
        puts "Priorité : #{priorite}"
        puts "Deadline : #{deadline}"
        puts "-------------------------"
    end 
end





matache = Tache.new("Finir formation", "Professionnel", "Ines")
matache.specify("Code", "Il y a un formation de 40h à faire sur le ruby.", "25/02")

# On crée quelques classes pour tester
tache1 = Tache.new("Manger gouter", "Alimentation", "Ines")
tache2 = Tache.new("Faire les courses", "Alimentation", "Ines")
tache3 = Tache.new("Faire le ménage", "Ménage", "Ines")
tache4 = Tache.new("Faire du sport", "Sport", "Ines")

tache1.change_progress(:doing)
tache4.change_progress(:done)


# puts tache1
# puts tache2
# puts tache3
# puts tache4

Tache.show_tasks_theme("Alimentation")








