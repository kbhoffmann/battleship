require './lib/board'
require './lib/cell'
require './lib/ship'

class Game

  attr_reader :valid_combo_cruiser,
              :valid_combo_sub

  def initialize
    @valid_combo_cruiser = []
    @valid_combo_sub = []
  end

  def starter(answer)
    if answer == "p"
      p "Game will start"
    elsif answer == "q"
      p "Good Bye"
      exit!
    else
      p "Invalid Response"
      puts "Enter p to play. Enter q to quit."
      new_answer = gets.chomp
      self.starter(new_answer)
    end
  end
  require "pry"; binding.pry
  def computer_placement

    all_combos = board.coordinates.combination(3).to_a

    all_combos.each do |combo|
      if board.valid_placement?(cruiser, combo)
        @valid_combo_cruiser << combo
      end
    end
    @valid_combo_cruiser
    cruiser_placement = valid_combo_cruiser.shuffle.first
    board.place(cruiser, cruiser_placement)
    ####
    all_combos = board.coordinates.combination(2).to_a


    all_combos.each do |combo|
      if board.valid_placement?(submarine, combo)
        @valid_combo_sub << combo
      end
    end
    @valid_combo_sub

    sub_placement = valid_combo_sub.shuffle.first
    board.place(submarine, sub_placement)
  end


end
