require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

describe Game do
  it 'exists' do
    game = Game.new

    expect(game).to be_a Game
  end

  # it 'takes user input and starts game' do
  #   game = Game.new
  #   answer = "p"
  #
  #   expect(game.starter(answer)).to eq("Game will start")
  #
  #   answer = "q"
  #   expect(game.starter(answer)).to eq("Good Bye")
  #

end
