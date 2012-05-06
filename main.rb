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
    $game.characters_remaining
end

get '/add_word/:word' do
    if (params[:word].length > $game.characters_remaining) then
        403
    end

    200
end

get '/signup/:username' do
    UserPool.add(params[:username])
end

get '/is_it_my_turn/:username' do

end