class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end  

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-" * 11
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-" * 11
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  def update(location, token)
    cells[location] = token
  end

  def taken?(location)
    cells[location] != " "    
  end

  def valid_move?(location)
    location.between?(0,8) && !taken?(location)
  end

  def full?
    !cells.include?(" ")
  end

end
