class Game
    def initialize
        @text = ""
        @last_word = nil
    end

    def characters_remaining
        140 - @text.length
    end

    def last_word
        "pizza sticks"
    end

    def can_add_word?(word)
        word.length < characters_remaining
    end

    def add_word(word)
        @text << " " + word

        @last_word = word
    end

    def finish!
        @text += "."
        # post that shit to twitter
    end
end