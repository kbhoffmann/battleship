require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'

describe Game do
  it 'exists' do
    game = Game.new


    expect(game).to be_a Game
  end

  it 'starts with a player board' do
    game = Game.new

    expect(game.player_board).to be_an_instance_of(Board)
  end

  it 'starts with a player ships' do
    game = Game.new

    expect(game.player_cruiser).to be_an_instance_of(Ship)
    expect(game.player_sub).to be_an_instance_of(Ship)
  end

end
