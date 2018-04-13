require_relative './player.rb'

class Computer < Player

#will default to trying the center first, followed by a stupid, random choice
  def choose_location(board)
    location = 4
    until board.valid_move?(location)
      location = rand(0..8)
    end
    location
  end

  def move(board, location = nil)
    location = choose_location(board)
    super
  end

end