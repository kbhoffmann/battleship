require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :board_player,
              :cruiser_player,
              :submarine_player,
              :board_comp,
              :cruiser_comp,
              :submarine_comp,
              :player_shot,
              :computer_guess,
              :shot_log

  def initialize
    @board_comp = Board.new
    @board_player = Board.new
    @cruiser_player = Ship.new("Cruiser", 3)
    @submarine_player = Ship.new("Submarine", 2)
    @cruiser_comp = Ship.new("Cruiser", 3)
    @submarine_comp = Ship.new("Submarine", 2)
    @player_shot = nil
    @computer_guess = nil
    @shot_log = board_comp.coordinates
  end

  def welcome_message
    puts "Welcome to BATTLESHIP!"
    puts "Enter p to play. Enter q to quit."
  end

  def starter
    welcome_message
    answer = gets.chomp.downcase
    if answer == "p"
      play_game

    elsif answer == "q"
      p "Good Bye!"
    else
      p "Invalid Response"
      self.starter
    end
  end

  def play_game
    @board_comp.cruiser_placement(@cruiser_comp)
    @board_comp.sub_placement(@submarine_comp)
    player_place_text
    player_choice(@cruiser_player)
    puts board_player.render(true)
    puts "Enter the squares for the Submarine (2 spaces):"
    player_choice(@submarine_player)
    until game_over?
      display_boards(board_comp.render, board_player.render(true))
      puts "Enter the coordinates for your shot:"
      player_shoot
      computer_shot
      player_results
      comp_results
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

  def player_choice(ship_type)
    player_input = gets.chomp.upcase.split
    if board_player.valid_placement?(ship_type, player_input)
      board_player.place(ship_type, player_input)
    else
      puts "Those are invalid coordinates. Please try again:"
      self.player_choice(ship_type)
    end
  end

  def display_boards(computer_board, player_board)
    puts "=============COMPUTER BOARD============="
    puts "#{computer_board}"
    puts "==============PLAYER BOARD=============="
    puts "#{player_board}"
  end

  def end_game_message
    if comp_lost?
      p "You won!"
    else
      p "I won!"
    end
  end


  def player_shoot
    @player_shot = gets.chomp.upcase
    @player_shot.split
    if @board_comp.valid_coordinate?(@player_shot) && @shot_log.include?(@player_shot)
      @board_comp.cell_hash[@player_shot].fire_upon
      log_player_shots(@player_shot)
    else
      puts "Please enter a valid coordinate:"
      self.player_shoot
    end
  end

  def log_player_shots(shot)
    @shot_log.delete(shot)
  end

  def computer_shot
    computer_guess_array =  board_player.coordinates.shuffle!
    @computer_guess = computer_guess_array.pop
    @board_player.cell_hash[@computer_guess].fire_upon
  end

  def player_results
    if board_comp.cell_hash[@player_shot].render == "M"
      puts "Your shot on #{@player_shot} was a miss."
    elsif board_comp.cell_hash[@player_shot].render == "H"
      puts "Your shot on #{@player_shot} was a hit."
    else
      puts "Your shot on #{@player_shot} sunk a ship!"
    end
  end

  def comp_results
    if board_player.cell_hash[@computer_guess].render == "M"
      puts "My shot on #{@computer_guess} was a miss."
    elsif board_player.cell_hash[@computer_guess].render == "H"
      puts "My shot on #{@computer_guess} was a hit."
    else
      puts "My shot on #{@computer_guess} sunk a ship!"
    end
  end



  def player_lost?
    @cruiser_player.health == 0 && @submarine_player.health == 0
  end

  def comp_lost?
    @cruiser_comp.health == 0 && @submarine_comp.health == 0
  end

  def game_over?
    player_lost? || comp_lost?
  end

end
