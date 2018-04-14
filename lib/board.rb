class Board
  attr_reader :cells, :rows, :columns, :diags, :someone_won, :row_length
  
  def initialize(row_length)
    @row_length = row_length
    @cells = Array.new(row_length**2, " ")
    @someone_won = false
    @rows = {}
    @columns = {}
    (0..row_length-1).each do |i|
      @rows[i] = {positions_taken: []}
      @columns[i] = {positions_taken: []}
    end
    @diags = {:down => {positions_taken: []}, :up => {positions_taken: []} }
  end  

  def display
    border_length = row_length * 4
    puts "=" * border_length
    cells.each_with_index do |value, index|
      if (index + 1) % row_length == 0 && index != 0
        puts "  #{value}  "
        puts "-" * border_length
      else
        print " #{value} |"
      end
    end
    puts "=" * border_length
  end

  def update(position, token)
    cells[position] = token
    update_rows_and_check_win(position) if someone_won == false
    update_columns_and_check_win(position) if someone_won == false
    update_diag_down_and_check_win(position) if someone_won == false
    update_diag_up_and_check_win(position) if someone_won == false
  end

  def update_rows_and_check_win(position)
    row = (position/row_length).floor
    rows[row][:positions_taken] << position
    handle_potential_win(rows[row][:positions_taken])
  end

  def update_columns_and_check_win(position)
    column = position % row_length
    columns[column][:positions_taken] << position
    handle_potential_win(columns[column][:positions_taken])
  end

  def update_diag_down_and_check_win(position)
    diags[:down][:positions_taken] << position if position/row_length == position % row_length
    handle_potential_win(diags[:down][:positions_taken])
  end

  def update_diag_up_and_check_win(position)
    diags[:up][:positions_taken] << position if (position/row_length + position % row_length) == (row_length-1)   
    handle_potential_win(diags[:up][:positions_taken])
  end

  def handle_potential_win(positions)
    if positions.length == row_length 
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
    position.between?(0,(row_length**2 - 1)) && !taken?(position)
  end

  def full?
    !cells.include?(" ")
  end

end
