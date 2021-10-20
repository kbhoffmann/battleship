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

  def place_ship (ship_type)
    @occupied << ship_type
  end

  #is false by default, think a cell should start not fired upon when initialized
  #need to account for cells empty and not empty???
  def fired_upon?
    @fired_upon
  end

#changes fired_upon to true
#if !empty? ship is hit
#what to do if empty?
  def fire_upon
    if empty? == false
      ship.hit
    end
    @fired_upon = true
  end

  # #so far method does NOT contain the optional boolean argument described at the end of the iteration.
  # def render
  ## Added optional argument, will register as false unless argument true is placed in.
  def render(contain_ship = false)

    #"Register an S even if a ship hasn't been fired upon"
    if contain_ship == true
      "S"

    #"M" if the cell has been fired upon and it does NOT contain a ship(IS A MISS)
    #"." if the cell has NOT been fired upon.
    elsif fired_upon? == false && empty? || fired_upon? == false && !empty?
      "."
    #"M" if the cell has been fired upon and it does NOT contain a ship(IS A MISS)
    #elsif fired_upon? && empty?
    elsif fired_upon? && empty?
      "M"

    elsif fired_upon? && !empty?
      if ship.sunk?
        "X"
      else
        "H"
      end
    end
    ##"H" if the cell has been fired upon AND it DOES contain a ship(IS A HIT)
    #elsif fired_upon? && !empty?
    # "H"
    ##"X" if the cell has been fired upon AND its ship has been sunk.
    #elsif fired_upon? && ship.sunk?
    # "X"
    #end
  end
end
