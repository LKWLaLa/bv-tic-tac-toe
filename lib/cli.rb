class CLI

  def start
    puts "-" * 25
    puts "Welcome to Tic Tac Toe!"
    @row_size = get_board_size
    @board = Board.new(@row_size)
    @game = set_up_game
    until @game.over?
      turn
    end
    end_game_message
    play_another?
  end

  def set_up_game
    puts "How many players would you like to have?  (1 or 2)"
    input = gets.strip
    case input
      when "1"
        one_player_game
      when "2"
        two_player_game
      else
        prompt_for_bad_input(input)
        set_up_game
    end
  end

  def one_player_game
    puts "Ok, great!  Would you like to play 'X' or 'O'?"
    token = gets.strip
    case token
      when "X","x"
        [
          Game.new(Player.new("X"), Computer.new("O"), @board),
          Game.new(Computer.new("O"), Player.new("X"), @board)
        ].sample
      when "O", "o"
        [
          Game.new(Player.new("O"), Computer.new("X"), @board),
          Game.new(Computer.new("X"), Player.new("O"), @board)
        ].sample        
      else
        prompt_for_bad_input(token)
        one_player_game
    end

  end

  def two_player_game
    puts "Ok, two-player game coming up!"
    [
      Game.new(Player.new("X"), Player.new("O"), @board),
      Game.new(Player.new("O"), Player.new("X"), @board)
    ].sample
  end

  def turn
    @game.increment_turn
    player = @game.current_player
    puts "Player '#{player.token}'s turn!"
    @board.display
    if player.class != Computer
      position = get_position
      player.move(@board, position)
    else
      #player is the computer, and will generate a position
      player.move(@board)
    end
  end

  def get_board_size
    puts "-" * 25
    puts "This tic tac toe game has a flexible board size."
    puts "Please enter the number of boxes you would like to have in one row."
    puts "You can type any integer, 3 or greater."
    puts "Just keep in mind the limitations of your terminal display size!"
    puts "-" * 25
    print "> "
    row_size = gets.strip.to_i
    if row_size_valid?(row_size) 
      row_size
    else
      prompt_for_bad_input(row_size)
      get_board_size
    end
  end

  def row_size_valid?(size)
    size >= 3
  end

  def get_position
    puts "Please type the position number you would like to play. (0 through #{@row_size**2 - 1})"
    print "> "
    position = gets.strip.to_i
    if @board.valid_move?(position) 
      position
    else
      prompt_for_bad_input(position)
      get_position
    end
  end

  def play_another?
    puts "Do you want to play another? (y/n)"
    answer = gets.strip
    case answer
      when "y", "Y"
        start
      when "n", "N"
        exit_cli
      else
        prompt_for_bad_input(answer)
        play_another?
    end
  end

  def end_game_message
    @board.display
    if @board.someone_won
      puts "Congratulations! Player '#{@game.current_player.token}' WINS!!"
      puts "=" * 11
    else
      puts "Hey, it looks like a draw!"
      puts "=" * 11
    end
  end

  def exit_cli
    puts "Ok, goodbye!"
    exit
  end

  def prompt_for_bad_input(input)
    puts "You gave me #{input} -- I have no idea what to do with that."
  end

end