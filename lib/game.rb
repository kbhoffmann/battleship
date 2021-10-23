require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  def initialize
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

end
