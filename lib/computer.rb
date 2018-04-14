require_relative './player.rb'

class Computer < Player

#will default to trying the upper left corner, followed by a stupid, random choice
  def choose_location(board)
    location = 0
    until board.valid_move?(location)
      location = rand(1..board.row_length - 1)
    end
    location
  end

  def move(board, location = nil)
    location = choose_location(board)
    super
  end

end