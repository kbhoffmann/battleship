class Board
  def initialize
    @coordinates = ["A1", "A2", "A3", "A4",
                    "B1", "B2", "B3", "B4",
                    "C1", "C2", "C3", "C4",
                    "D1", "D2", "D3", "D4"]
  end

  def cells
    cells = Hash.new
    @coordinates.each do |coordinate|
     cells[coordinate] = Cell.new(coordinate)
    end
    cells
  end

  def valid_coordinate?(coordinate)
    @coordinates.include?(coordinate)
  end


  def valid_placement?(ship_type, coordinates)
    # This long group of .each and .map breaks up the coordinates into two arrays
    ## one with the letters in the coordinates and one with the numbers
    ### it also has them in order that they were entered
    ### This could be made into a helper method, tried it and got errors
    split_array = []
    letter_array = []
    number_array = []
    letter_array_ord = []
    # This seperates the coordinates into two seperate strings within the array.
    coordinates.each do |coordinate|
      split_array << coordinate.split("")
    end
    # This seperates the two strings into two arrays. One array with letters and one array with numbers
    split_array.map do |letter|
      letter_array << letter.first
      number_array << letter.last.to_i
    end

    # This creates a seperate array that converts the letters array into numbers to determine consecutive letters
    letter_array.map do |letter|
      letter_array_ord << letter.ord
    end

    ## end of potential helper method
    ## These are tests that can return boolean values to test placement

    # If the difference between the max and min is greater then -3 for Cruiser
    # and -2 for subs then the numbers are consecutive
    # I think we can write a better method for checking consecutive

    consecutive_check_num = number_array.min - number_array.max
    consecutive_check_let = letter_array_ord.min - letter_array_ord.max
    # This returns a boolean if the letters or numbers are all the letter_same
    letter_same = letter_array.all?
    number_same = number_array.all?
    # This checks the numbers
    consecutive_cruis_num = consecutive_check_num > -3
    consecutive_cruis_let = consecutive_check_let > -3
    consecutive_sub_num = consecutive_check_num > -2
    consecutive_sub_let = consecutive_check_let > -2
    ## My thoughts were if we could create tests that return booleans
    ## we could make a very simple if statement that just had all the tests
    test1 = letter_same && number_same == false && consecutive_cruis
    test2 = letter_same == false && number_same && consecutive_sub_let

    if ship_type.length == coordinates.count && test1 && test2
    end
  end
end
