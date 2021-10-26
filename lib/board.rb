require './lib/ship'
require './lib/cell'
require './lib/game'
require 'pry'

class Board
  attr_reader :cell_hash,
              :coordinates,
              :cruiser_loc,
              :sub_loc

  def initialize
    @coordinates = ["A1", "A2", "A3", "A4",
                    "B1", "B2", "B3", "B4",
                    "C1", "C2", "C3", "C4",
                    "D1", "D2", "D3", "D4"]
    @cell_hash = cells
    @cruiser_loc = []
    @sub_loc = []
  end

  def cells
    cell_container = {}
    @coordinates.each do |coordinate|
     cell_container[coordinate] = Cell.new(coordinate)
    end
    cell_container
  end

  def valid_coordinate?(coord)
    @coordinates.include?(coord)
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
      if @cell_hash[coordinate] == !nil
         if @cell_hash[coordinate].occupied.count == 1
          checker << coordinate
         end
      end
    end
    checker.length == 0
  end

  def unique_val_test?(coord)
    coord.tally(&:uniq).count == 1
  end

  def check_all_coords_valid(coords_array)
    truth_container = []
    coords_array.each do |coord|
      truth_container << valid_coordinate?(coord)
    end
    truth_container
    unique_val_test?(truth_container) && truth_container.first == true
  end

  def valid_placement?(ship_type, ship_coords_array)
    coord = ship_coords_array
    numbers_separate = numbers_separate(coord)
    numbers_separate_reversed = numbers_separate(coord).reverse

    valid_coordinate = check_all_coords_valid(coord)
    letters_separate = letters_separate(coord)
    letters_separate_reversed = letters_separate(coord).reverse

    letter_range = letter_range(ship_type)
    number_range = number_range(ship_type)

    letters_unique = unique_val_test?(letters_separate)
    numbers_unique = unique_val_test?(numbers_separate)

    basic_conditions = ship_type.length == coord.length

    if basic_conditions && not_occupied?(coord) && valid_coordinate
      if (number_range.include?(numbers_separate) || number_range.include?(numbers_separate_reversed)) && letters_unique
        return true
      elsif (letter_range.include?(letters_separate) || letter_range.include?(letters_separate_reversed)) && numbers_unique
        return true
      else
        return false
      end
    else
      false
    end
  end

  def place(ship_type, coords)
    coords.each do |coordinate|
      @cell_hash[coordinate].place_ship(ship_type)
    end
  end

  def render(contain_ship = false)
    if contain_ship == true
      "  1 2 3 4 \n" +
        "A #{@cell_hash["A1"].render(true)} #{@cell_hash["A2"].render(true)} #{@cell_hash["A3"].render(true)} #{@cell_hash["A4"].render(true)} \n" +
        "B #{@cell_hash["B1"].render(true)} #{@cell_hash["B2"].render(true)} #{@cell_hash["B3"].render(true)} #{@cell_hash["B4"].render(true)} \n" +
        "C #{@cell_hash["C1"].render(true)} #{@cell_hash["C2"].render(true)} #{@cell_hash["C3"].render(true)} #{@cell_hash["C4"].render(true)} \n" +
        "D #{@cell_hash["D1"].render(true)} #{@cell_hash["D2"].render(true)} #{@cell_hash["D3"].render(true)} #{@cell_hash["D4"].render(true)} \n"
    else
      "  1 2 3 4 \n" +
        "A #{@cell_hash["A1"].render} #{@cell_hash["A2"].render} #{@cell_hash["A3"].render} #{@cell_hash["A4"].render} \n" +
        "B #{@cell_hash["B1"].render} #{@cell_hash["B2"].render} #{@cell_hash["B3"].render} #{@cell_hash["B4"].render} \n" +
        "C #{@cell_hash["C1"].render} #{@cell_hash["C2"].render} #{@cell_hash["C3"].render} #{@cell_hash["C4"].render} \n" +
        "D #{@cell_hash["D1"].render} #{@cell_hash["D2"].render} #{@cell_hash["D3"].render} #{@cell_hash["D4"].render} \n"
    end
  end

  def cruiser_placement(ship_type)
    valid_combo_cruiser = []
    all_combos = coordinates.combination(3).to_a
    all_combos.each do |combo|
      if valid_placement?(ship_type, combo)
        valid_combo_cruiser << combo
      end
    end
    valid_combo_cruiser
    @cruiser_loc = valid_combo_cruiser.shuffle.first
    place(ship_type, @cruiser_loc)
  end

  def sub_placement(ship_type)
    valid_combo_sub = []
    all_combos = coordinates.combination(2).to_a
    all_combos.each do |combo|
      if valid_placement?(ship_type, combo)
        valid_combo_sub << combo
      end
    end
    valid_combo_sub

    @sub_loc = valid_combo_sub.shuffle.first
    place(ship_type, @sub_loc)
  end

end
