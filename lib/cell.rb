require './lib/ship'

class Cell

  attr_reader :coordinate,
              :occupied

  def initialize(coordinate)
    @coordinate = coordinate
    @occupied = []
  end

  def ship
    @occupied = []
    @occupied[0]
  end

  def empty?
    if ship == nil
      true
    end
  end

  def place_ship (ship_type)
    @occupied << ship_type
  end
end
