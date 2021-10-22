require './lib/ship'
require './lib/cell'

class Board
  attr_reader :cell_hash
  def initialize
    @coordinates = ["A1", "A2", "A3", "A4",
                    "B1", "B2", "B3", "B4",
                    "C1", "C2", "C3", "C4",
                    "D1", "D2", "D3", "D4"]
    @cell_hash = {}
  end

  def cells
    @coordinates.each do |coordinate|
     @cell_hash[coordinate] = Cell.new(coordinate)
    end
    @cell_hash
  end

  def valid_coordinate?(coordinate)
    @coordinates.include?(coordinate)
  end

  def number_range(ship_type)
    x = ship_type.length
    number_range = []
    (1..4).each_cons(x) do |numbers|
      number_range << numbers
    end
    number_range
  end

  def letter_range(ship_type)
    x = ship_type.length
    letter_range = []
    ("A".."D").each_cons(x) do |letters|
      letter_range << letters
    end
    letter_range
  end



  def letters_separate(coordinates)
    coordinates.map do |coordinate|
      coordinate[0]
    end
  end

  def numbers_separate(coordinates)
    coordinates.map do |coordinate|
      coordinate[1].to_i
    end
  end

  def filled_coordinate(coordinate)
    @cell_hash[coordinate]
  end


  def not_occupied?(coordinates)
    checker = []
    coordinates.each do |coordinate|
      if @cell_hash[coordinate].occupied.count == 1
        checker << coordinate
      end
    end
    checker.length == 0
  end


  def valid_placement?(ship_type, coordinates)
    numbers_separate = numbers_separate(coordinates)
    letters_separate = letters_separate(coordinates)
    letter_range = letter_range(ship_type)
    number_range = number_range(ship_type)
    basic_conditions = ship_type.length == coordinates.length

    if basic_conditions  && not_occupied?(coordinates)
      if number_range.include?(numbers_separate) && letter_range.include?(letters_separate) == false
        return true
      elsif number_range.include?(numbers_separate) == false && letter_range.include?(letters_separate)
        return true
      else
        return false
      end
    else
      false
    end
  end


  def place(ship_type, coordinates)
    coordinates.each do |coordinate|
      cell = Cell.new(coordinate)
      cell.place_ship(ship_type)
      @cell_hash[coordinate] = cell
    end
    cell_hash
  end

end
