require 'sinatra'
require 'json'

require './userpool.rb'

$game = nil
$userpool = UserPool.new

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
end

get '/is_it_my_turn/:username' do
    $userpool.current.eql?(params[:username])
end