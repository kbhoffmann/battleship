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

  it 'formats player input for cruiser' do
    game = Game.new

    expect(game.player_cruiser_coords_formatted).to be_an(Array)
    expect(game.player_cruiser_coords_formatted.length).to eq(3)
  end

  #unsure of these tests and what exactly is is we want to do next
  xit 'checks if formatted cruiser coordinates are valid and gives output' do
    game = Game.new
    board = Board.new
    board.cells

    expect(game.check_player_cruiser_placement_coords(["A1", "B1", "C1"])).to eq(true)
    expect(game.check_player_cruiser_placement_coords(["B1", "B3", "C1"])).to eq(false)
  end

    xit '' do

    expect(game.display_boards).to eq(expected)
end

#   xit 'can let the player place a cruiser ship' do
#     game = Game.new
#     board = Board.new
#     cruiser = Ship.new("Cruiser", 3)
#     submarine = Ship.new("Submarine", 2)
#     board.cells
#     board.place(cruiser, ["B2", "B3", "B4"])
#
#     expected_1 = "  1 2 3 4 \nA . . . . \nB . S S S \nC . . . . \nD . . . . \n"
#
#     expected_2 = "  1 2 3 4 \n" +
#                  "A . . . . \n" +
#                  "B . S S S \n" +
#                  "C . . . . \n" +
#                  "D . . . . \n"
#
#     expect(game.place_player_cruiser(cruiser).length).to eq(3)
#     # expect(game.board.render(true)).to eq(expected_1)
#     # expect(game.board.render(true)).to eq(expected_2)
#   end
#
#   xit 'can let the player place a submarine' do
#     game = Game.new
#     board = Board.new
#     cruiser = Ship.new("Cruiser", 3)
#     submarine = Ship.new("Submarine", 2)
#     board.cells
#
#     board.place(cruiser, ["B2", "B3", "B4"])
#     board.place(submarine, ["C1", "D1"] )
#
#     expected_1 = "  1 2 3 4 \nA . . . . \nB . S S S \nC S . . . \nD S . . . \n"
#
#     expected_2 = "  1 2 3 4 \n" +
#                  "A . . . . \n" +
#                  "B . S S S \n" +
#                  "C S . . . \n" +
#                  "D S . . . \n"
#
#     expect(game.sub_placement.length).to eq(3)
#     expect(game.board.render(true)).to eq(expected_1)
#     expect(game.board.render(true)).to eq(expected_2)
#   end
# end
