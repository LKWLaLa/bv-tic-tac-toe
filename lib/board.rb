class Board
  attr_accessor :cells, :rows, :columns, :diags, :someone_won

  def initialize
    @cells = Array.new(9, " ")
    @someone_won = false
    @rows = {
              0 => {positions_taken: []},
              1 => {positions_taken: []},
              2 => {positions_taken: []}
            }
    @columns = {
                0 => {positions_taken: []},
                1 => {positions_taken: []},
                2 => {positions_taken: []}
               }
    @diags = {
              :down => {positions_taken: []},
              :up => {positions_taken: []}
             }
  end  

  def display
    puts "=" * 11
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-" * 11
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-" * 11
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
    puts "=" * 11
  end

  def update(position, token)
    cells[position] = token
    update_rows_and_check_win(position) if someone_won == false
    update_columns_and_check_win(position) if someone_won == false
    update_diags_and_check_win(position) if someone_won == false
  end

  def update_rows_and_check_win(position)
    row = (position/3).floor
    rows[row][:positions_taken] << position
    handle_potential_win(rows[row][:positions_taken])
  end

  def update_columns_and_check_win(position)
    column = position % 3
    columns[column][:positions_taken] << position
    handle_potential_win(columns[column][:positions_taken])
  end

#needs refactoring
  def update_diags_and_check_win(position)
    diags[:down][:positions_taken] << position if position/3 == position % 3
    handle_potential_win(diags[:down][:positions_taken])
    diags[:up][:positions_taken] << position if (position/3 + position % 3) == 2   
    handle_potential_win(diags[:up][:positions_taken])
  end

  def handle_potential_win(positions)
    if positions.length == 3 
      if winner?(positions)
        @someone_won = true
      end
    end
  end

  def winner?(positions) 
    positions.all?{|i| cells[i] == "X"}  || positions.all?{|i| cells[i] == "O"} 
  end

  def taken?(position)
    cells[position] != " "    
  end

  def valid_move?(position)
    position.between?(0,8) && !taken?(position)
  end

  def full?
    !cells.include?(" ")
  end

end
