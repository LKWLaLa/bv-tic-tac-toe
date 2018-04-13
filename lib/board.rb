class Board
  attr_accessor :cells, :row_count, :column_count, :diag_count

  def initialize
    @cells = Array.new(9, " ")
    @row_count = {0 => 0, 1 => 0, 2 => 0}
    @column_count = {0 => 0, 1 => 0, 2 => 0}
    @diag_count = {:down => 0, :up => 0}
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
    update_rows(location)
    update_columns(location)
    update_diags(location)
  end

  def update_rows(location)
    row = (location/3).floor
    row_count[row] += 1
  end

  def update_columns(location)
    column = location % 3
    column_count[column] += 1
  end

  def update_diags(location)
    diag_count[:down] += 1 if location/3 == location % 3
    diag_count[:up] += 1 if (location/3 + location % 3) == 2
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
