class CLI
  def start
    puts "Welcome to Tic Tac Toe!"
    game = set_up_game
    puts game.inspect

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
          Game.new(Player.new("X"), Computer.new("O")),
          Game.new(Computer.new("O"), Player.new("X"))
        ].sample
      when "O", "o"
        [
          Game.new(Player.new("O"), Computer.new("X")),
          Game.new(Computer.new("X"), Player.new("O"))
        ].sample        
      else
        prompt_for_bad_input(token)
        one_player_game
    end

  end

  def two_player_game
  end

  def end_game
  end

  def exit
  end

  def turn
  end

  def greet_user
  end

  def check_for_win
  end

  def congratulate_winner
  end

  def play_another?
  end

  def prompt_for_bad_input(input)
    puts "You gave me #{input} -- I have no idea what to do with that."
  end

end