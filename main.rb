load "board.rb"
load "view.rb"
load "player.rb"

class Game

  def initialize
    @view = View.new
    @score = { rounds_played: 0, turns: 0, drawn: 0, p1: 0, p2: 0}
    @continue_game = true
    @continue_round = true
    # Clear the screen and start the game
    puts "\e[H\e[2J"
    main_menu
  end

  def main_menu
    @view.main_menu
    selection = gets.chomp

    if selection == "1"
      @view.player_info(1)
      name = gets.chomp
      @player_one = Player.new(:p1, name, "X")
      @view.player_info(2)
      name = gets.chomp
      @player_two = Player.new(:p2, name, "O")
      @view.instructions
      print "Enter how many rounds to play: "
      @max_rounds = gets.chomp
      main_loop
    elsif selection == "2"
      abort(" Thanks for playing!")
    else
      @view.invalid_entry
      sleep 1
      main_menu; end
  end

  def main_loop
    @continue_game = true
    while @continue_game

      @board = GameBoard.new      
      
      @score[:turns] = 0
      @score[:drawn] = 0
      @score[:p1] = 0
      @score[:p2] = 0
      @score[:rounds_played] % 2 != 0 ? @active_player = @player_two : @active_player = @player_one

      @continue_round = true
      while @continue_round

        @score[:turns] += 1

        valid_input = false
        until valid_input
          @view.game_state(@board, @score)
          print " #{@active_player.name}'s turn. Select (1-9): "
          location = gets.chomp
          if location.to_i.between?(1,9)
            valid_input = true
            if @board.place_marker(location.to_i, @active_player.marker) == "occupied"
              puts "That spot is already taken... try again."
              valid_input = false
              sleep 1; end
          else
            puts " Invalid entry, please try again."
            sleep 1; end
        end

        @view.game_state(@board, @score)

        if @score[:turns] > 3
          if @board.check_winner == @player_one.marker || @board.check_winner == @player_two.marker
            @score[@active_player.id] += 1
            @continue_round = false
            puts "         #{@active_player.name} Wins!"
            sleep 1; end
        end

        if @score[:turns] == 9 && @continue_round == true
          @score[:drawn] += 1
          @continue_round = false
          puts "          It's a Draw!"
          sleep 1; end

        @active_player == @player_one ? @active_player = @player_two : @active_player = @player_one
      end

      @score[:rounds_played] += 1
      @continue_game = false if @score[:rounds_played] >= @max_rounds.to_i

    end

    game_winner = ".. no one!"
    game_winner = @player_one.name if @score[:p1] > @score[:p2]
    game_winner = @player_two.name if @score[:p2] > @score[:p1]
    
    @view.final_score(game_winner, @score)  
    
    sleep 5
    main_menu
  end
end

game = Game.new