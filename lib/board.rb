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

  def consecutive_numbers(array)
    if array.length == 3
      cruiser_check = array.each_cons(3).any?{ |x,y| x == y - 1}
    else
      sub_check = array.each_cons(2).any?{ |x,y| x == y - 1}
    end
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
    split_array
    # This seperates the two strings into two arrays. One array with letters and one array with numbers
    split_array.each do |letter|
      letter_array << letter.first
      number_array << letter.last.to_i
    end
    letter_array
    number_array
    # This creates a seperate array that converts the letters array into numbers to determine consecutive letters
    letter_array.each do |letter|
      letter_array_ord << letter.ord
    end
    letter_array

    # number_consecutive = number_array.include?()



    ## end of potential helper method
    ## These are tests that can return boolean values to test placement

    # This returns a boolean if the letters or numbers are all the letter_same
    letter_same = letter_array.all?
    number_same = number_array.all?

    ## My thoughts were if we could create tests that return booleans
    ## we could make a very simple if statement that just had all the tests
    # test1 = letter_same
    # test2 = letter_same == false
    # test3 = number_same
    # test4 = number_same == false
    # ship_legnth = ship_type.length == coordinates.count
  end
end
