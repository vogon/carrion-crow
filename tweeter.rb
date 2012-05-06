require 'twitter'
require 'yaml'

class Tweeter
    def initialize
        secrets = YAML.load_file("./production.yml")

        Twitter.configure do |config|
            config.consumer_key = secrets[:consumer_key]
            config.consumer_secret = secrets[:consumer_secret]
            config.oauth_token = secrets[:oauth_token]
            config.oauth_token_secret = secrets[:oauth_token_secret]
        end
    end

    def tweet_game_over(text)
        Twitter.update(text)
    end

    def tweet_your_turn(username, last_word)
        Twitter.update("@#{username} Hey, it's your turn.  The last word was: '#{last_word}'.  http://192.168.2.29:4567/submit")
    end
end