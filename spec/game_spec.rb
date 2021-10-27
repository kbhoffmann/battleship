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
end
