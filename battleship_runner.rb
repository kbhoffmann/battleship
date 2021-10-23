require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

game = Game.new

puts "Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
answer = gets.chomp
game.starter(answer)
