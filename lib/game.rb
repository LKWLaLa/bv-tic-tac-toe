class Game
  attr_accessor :player_1, :player_2, :turn_count 
  attr_reader :board

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @board = Board.new
    @turn_count = 0
  end

  def current_player
    turn_count % 2 == 0 ? player_1 : player_2
  end

  def over?
    draw? || won? 
  end
      
  def draw?
   board.full? && !won?
  end

  def won?(line) 
    line.all?{|i| line[i] == "X"}  || line.all?{|i| line[i] == "O"} 
  end

  def increment_turn
    turn_count += 1
  end

end  