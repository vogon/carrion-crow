class Game
    def initialize
        @text = ""
    end

    def characters_remaining
        140 - @text.length
    end
end