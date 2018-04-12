class Player
  
  attr_reader :token

  def initialize(token)
    @token = token
  end

#Computer and human will provide location in different ways
  def move(board, location = nil)
    board.update(location, token) if board.valid_move?(location)
  end

end