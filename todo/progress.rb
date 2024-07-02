class Progress 
    attr_reader :state


    @@states = {
        todo: "À faire",
        doing: "En cours",
        done: "Terminé"
        }
        



    def initialize(state)
        if !@@states.has_key?(state)
            raise "Invalid state"
        end
        @state = @@states[state]
    end

    def to_s()
        @state
    end

end


 
