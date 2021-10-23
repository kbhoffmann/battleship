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
  # end

  it 'computer places randomized ships' do
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board_comp = Board.new
    board_comp.cells
    game.computer_placement
    expect(game.valid_combo_cruiser.count).to eq (1)
  end


end
