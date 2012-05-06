require 'yaml'

$words = YAML.load_file("./wordz.yml").shuffle

class Game
    def initialize
        @text = ""
        @last_word = nil
        add_word($words.pop)
    end

    def characters_remaining
        140 - @text.length
    end

    def last_word
        @last_word
    end

    def can_add_word?(word)
        word.length < characters_remaining
    end

    def add_word(word)
        @text << word + " "

        @last_word = word
    end

    def finish!
        @text = @text.strip + "."
        # post that shit to twitter
        $tweeter.tweet_game_over(@text)
    end
end