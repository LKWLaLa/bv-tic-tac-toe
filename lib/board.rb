class Board
  attr_accessor :cells, :rows, :columns, :diags

  def initialize
    @cells = Array.new(9, " ")
    @rows = {
              0 => {tokens: 0, positions: [0, 1, 2]},
              1 => {tokens: 0, positions: [3, 4, 5]},
              2 => {tokens: 0, positions: [6, 7, 8]}
            }
    @columns = {
                0 => {tokens: 0, positions: [0, 3, 6]},
                1 => {tokens: 0, positions: [1, 4, 7]},
                2 => {tokens: 0, positions: [2, 5, 8]}
               }
    @diags = {
              :down => {tokens: 0, positions: [0, 4, 8]},
              :up => {tokens: 0, positions: [6, 4, 2]}
             }
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
    rows[row][:tokens] += 1
  end

  def update_columns(location)
    column = location % 3
    columns[column][:tokens] += 1
  end

  def update_diags(location)
    diags[:down][:tokens] += 1 if location/3 == location % 3
    diags[:up][:tokens] += 1 if (location/3 + location % 3) == 2
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
