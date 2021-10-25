require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :board_player,
              :cruiser_player,
              :submarine_player,
              :board_comp,
              :cruiser_comp,
              :submarine_comp

  def initialize
    @board_comp = Board.new
    @board_player = Board.new
    @cruiser_player = Ship.new("Cruiser", 3)
    @submarine_player = Ship.new("Submarine", 2)
    @cruiser_comp = Ship.new("Cruiser", 3)
    @submarine_comp = Ship.new("Submarine", 2)
  end

  def welcome_message
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
  end

  def starter
    welcome_message
    answer = gets.chomp.downcase
    if answer == "p"
      play_game

    elsif answer == "q"
      p "Good Bye"
      exit!
    else
      p "Invalid Response"
      self.starter
    end
  end

  def play_game
    @board_comp.cruiser_placement(@cruiser_comp)
    @board_comp.sub_placement(@submarine_comp)
    require "pry"; binding.pry
    player_place_text
    player_choice(@cruiser_player)
    puts board_player.render(true)
    puts "Enter the squares for the Submarine (2 spaces):"
    player_choice(@submarine_player)
    display_boards(board_comp.render, board_player.render(true))
    until game_over?
      # Game logic

    end
    end_game_message
    self.starter
  end

  def player_place_text
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts board_player.render(true)
    puts "Enter the squares for the Cruiser (3 spaces):"
  end

  def play_choice(ship_type)
    player_input = gets.chomp
    board_player.player_ship_placement(ship_type, player_input.split)
  end

  def display_boards(computer_board, player_board)
    puts "=============COMPUTER BOARD============="
    puts "#{computer_board}"
    puts "==============PLAYER BOARD=============="
    puts "#{player_board}"
  end

  def end_game_message
    if #player wins
      p "You won!"
    else
      p "I won!"
    end
  end


  def game_over?
  end

end
