class Priorite 
    attr_reader :level


    @@levels = {
        low: "Basse",
        mid: "Moyenne",
        high: "Haute"
        }
        



    def initialize(level)
        if !@@levels.has_key?(level)
            raise "Invalid level"
        end
        @level = @@levels[level]
    end

    def to_s()
        @level
    end

end


 
