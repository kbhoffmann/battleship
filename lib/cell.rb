require './lib/ship'

class Cell

  attr_reader :coordinate,
              :occupied

  def initialize(coordinate)
    @coordinate = coordinate
    @occupied = []
    @fired_upon = false
  end

  def ship
    @occupied[0]
  end

  def empty?
    @occupied.empty?
  end

  def place_ship(ship_type)
    @occupied << ship_type
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if empty? == false
      ship.hit
    end
    @fired_upon = true
  end

  def render(contain_ship = false)
    if fired_upon? && empty?
      "M"
    elsif fired_upon? && ship.sunk?
      "X"
    elsif fired_upon? && !empty?
      "H"
    elsif contain_ship == true && !empty?
      "S"
    else
      "."
    end
  end
end
