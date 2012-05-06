require 'sinatra'
require 'json'
require 'haml'

require './userpool.rb'
require './game.rb'
require './tweeter.rb'

$game = nil
$userpool = UserPool.new
$tweeter = Tweeter.new

# magic endpoint: http://192.168.2.29:4567

def ensure_game
    if ($game == nil) then
        $game = Game.new
    end
end

get '/characters_left' do
    ensure_game
    $game.characters_remaining.to_json
end

get '/last_word' do
    ensure_game
    $game.last_word.to_json
end

get '/submit' do
    ensure_game
    @last_word = $game.last_word
    @characters_left = $game.characters_remaining
    haml :get_submit
end

post '/submit' do
    ensure_game

    if (params[:word].length == nil) then
        return 400
    end

    if (params[:word].length > $game.characters_remaining) then
        return 403
    end

    $game.add_word(params[:word])

    if ($game.characters_remaining < 10) then
        $game.finish!
        $game = Game.new
    end

    $userpool.next!
    $tweeter.tweet_your_turn($userpool.current, $game.last_word)

    haml :post_submit
end

get '/signup' do
    haml :signup
end

post '/signup/:username' do
    $userpool.add(params[:username])
    200
end

get '/is_it_my_turn/:username' do
    $userpool.current.eql?(params[:username]).to_json
end