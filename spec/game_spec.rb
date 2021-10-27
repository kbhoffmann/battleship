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

    expect(game.board_player).to be_an_instance_of(Board)
  end

  it 'starts with a player ships' do
    game = Game.new

    expect(game.cruiser_player).to be_an_instance_of(Ship)
    expect(game.submarine_player).to be_an_instance_of(Ship)
  end

  it 'starts with a computer board' do
    game = Game.new

    expect(game.board_comp).to be_an_instance_of(Board)
  end

  it 'starts with computer ships' do
    game = Game.new

    expect(game.cruiser_comp).to be_an_instance_of(Ship)
    expect(game.submarine_comp).to be_an_instance_of(Ship)
  end

  it 'starts with no player or computer shots' do
    game = Game.new

    expect(game.player_shot).to be(nil)
  end

  it 'starts with no player or computer guesses' do
    game = Game.new

    expect(game.computer_guess).to be(nil)
  end

  it 'shows that the player lost' do
    game = Game.new
    game.board_player.place(game.cruiser_player,["A1", "A2","A3"])
    game.board_player.place(game.submarine_player,["B1", "B2"])
    game.board_player.cell_hash["A1"].fire_upon
    game.board_player.cell_hash["A2"].fire_upon
    game.board_player.cell_hash["A3"].fire_upon
    game.board_player.cell_hash["B1"].fire_upon
    game.board_player.cell_hash["B2"].fire_upon

    expect(game.player_lost?).to eq (true)
  end

  it 'shows that the play has not lost' do
    game = Game.new
    game.board_player.place(game.cruiser_player,["A1", "A2","A3"])
    game.board_player.place(game.submarine_player,["B1", "B2"])
    game.board_player.cell_hash["A1"].fire_upon
    game.board_player.cell_hash["A2"].fire_upon
    game.board_player.cell_hash["A3"].fire_upon
    game.board_player.cell_hash["B1"].fire_upon

    expect(game.player_lost?).to eq (false)
  end

  it 'shows that the computer lost' do
    game = Game.new
    game.board_comp.place(game.cruiser_comp,["A1", "A2","A3"])
    game.board_comp.place(game.submarine_comp,["B1", "B2"])
    game.board_comp.cell_hash["A1"].fire_upon
    game.board_comp.cell_hash["A2"].fire_upon
    game.board_comp.cell_hash["A3"].fire_upon
    game.board_comp.cell_hash["B1"].fire_upon
    game.board_comp.cell_hash["B2"].fire_upon

    expect(game.comp_lost?).to eq (true)
  end

  it 'shows that the computer has not lost' do
    game = Game.new
    game.board_comp.place(game.cruiser_comp,["A1", "A2","A3"])
    game.board_comp.place(game.submarine_comp,["B1", "B2"])
    game.board_comp.cell_hash["A1"].fire_upon
    game.board_comp.cell_hash["A2"].fire_upon
    game.board_comp.cell_hash["A3"].fire_upon
    game.board_comp.cell_hash["B1"].fire_upon

    expect(game.comp_lost?).to eq (false)
  end

  it '#removes shots from valid shots' do
    game = Game.new
    game.log_player_shots("B1")
    expect(game.shot_log.include?("B1")).to eq (false)
  end

  it '#game_reset, resets all instance variables' do
    game = Game.new
    game.log_player_shots("B1")

    expect(game.shot_log.include?("B1")).to eq (false)

    game.game_reset

    expect(game.shot_log.include?("B1")).to eq (true)
  end

  # it 'formats player input for cruiser' do
  #   game = Game.new
  #
  #   expect(game.player_cruiser_coords_formatted).to be_an(Array)
  #   expect(game.player_cruiser_coords_formatted.length).to eq(3)
  # end

  #unsure of these tests and what exactly is is we want to do next
  # xit 'checks if formatted cruiser coordinates are valid and gives output' do
  #   game = Game.new
  #   board = Board.new
  #   board.cells
  #
  #   expect(game.check_player_cruiser_placement_coords(["A1", "B1", "C1"])).to eq(true)
  #   expect(game.check_player_cruiser_placement_coords(["B1", "B3", "C1"])).to eq(false)
  # end


  xit '#display_boards shows a computer board with no ships and player board' do
    game = Game.new
    board_comp = Board.new
    board_player = Board.new
    cruiser_comp = Ship.new("Cruiser", 3)
    cruiser_player = Ship.new("Cruiser", 3)
    submarine_comp = Ship.new("Submarine", 2)
    submarine_player = Ship.new("Submarine", 2)
    board_comp.cells
    board_player.cells
    board_comp.cruiser_placement(cruiser_comp)
    board_comp.sub_placement(submarine_comp)
    player_cruiser = ["A1", "A2", "A3"]
    player_sub = ["B1", "B2"]
    board_player.player_ship_placement(cruiser_player,player_cruiser)
    board_player.player_ship_placement(submarine_player,player_sub)
    expected   =
                 "=============COMPUTER BOARD=============
                   1 2 3 4
                 A . . . .
                 B . . . .
                 C . . . .
                 D . . . .
                 ==============PLAYER BOARD==============
                   1 2 3 4
                 A S S S .
                 B S S . .
                 C . . . .
                 D . . . ."
    expect(game.display_boards(board_comp.render,board_player.render(true))).to eq(nil)
  end
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
