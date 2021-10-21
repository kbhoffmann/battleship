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
end
