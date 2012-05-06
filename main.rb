require 'sinatra'
require 'json'

require './userpool.rb'
require './game.rb'

$game = nil
$userpool = UserPool.new

# magic endpoint: http://192.168.2.29:4567

def ensure_game
    if ($game == nil) then
        $game = Game.new
    end
end

get '/characters_left' do
    ensure_game
    $game.characters_remaining
end

get '/last_word' do
    ensure_game
    $game.last_word
end

post '/add_word/:word' do
    ensure_game

    if (params[:word].length > $game.characters_remaining) then
        403
    end

    200
end

post '/signup/:username' do
    $userpool.add(params[:username])

    200
end

get '/is_it_my_turn/:username' do
    $userpool.current.eql?(params[:username])
end