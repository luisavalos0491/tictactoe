class View

  # The first thing the user sees
  def main_menu
    puts "\e[H\e[2J"
    puts " ...::||| Main Menu |||::..."
    puts ""
    puts "        1) New Game"
    puts "         2) Exit"
    puts ""
    print " Please make your selection:"
  end

  # Main menu error variant
  def invalid_entry
    puts "\e[H\e[2J"
    puts " ...::||| Main Menu |||::..."
    puts ""
    puts "        1) New Game"
    puts "         2) Exit"
    puts ""
    print " Invalid entry, try again! "
  end

  # Assigning symbols and taking names
  def player_info(player)
    puts "\e[H\e[2J"
    puts " ...::||| Player #{player} |||::..."
    puts ""
    if player == 1
      puts "   Your symbol will be X."
    elsif player == 2
      puts "   Your symbol will be O."; end
    puts ""
    puts ""
    print " Enter Player #{player}'s name: "
  end

  # This screen runs briefly after the creation of a new game/players
  def instructions
    puts "\e[H\e[2J"
    puts " ...::||| Instructions |||::..."
    puts " "
    puts "      Place three of your  "
    puts "   symbols in a line to win."
    puts "            "
    puts "    |1|2|3|     Select boxes    "
    puts "    |4|5|6|      using 1-9"
    puts "    |7|8|9|"
    puts ""
  end

  # This is the primary gameplay screen that updates each turn
  def game_state(board, score)
    puts "\e[H\e[2J"
    puts " ...::|||  TicTacToe  |||::..."
    puts " "
    puts "        Round #{score[:rounds_played]}, Turn #{score[:turns]}"
    puts "      Board         Score"
    puts ""
    puts "     #{board.print_row(1)}        P1:  #{score[:p1]}"
    puts "     #{board.print_row(2)}        P2:  #{score[:p2]}"
    puts "     #{board.print_row(3)}      Draw:  #{score[:drawn]}"
    puts ""
  end

  # Once the game is complete, a quick readout of the results
  def final_score(winner, score)
    puts "\e[H\e[2J"
    puts " ...::|||  Game Over  |||::..."
    puts " "
    puts "       Best of #{score[:rounds_played]} Rounds"
    puts "      "
    puts "        P1:  #{score[:p1]}   P2:  #{score[:p2]}"
    puts "         Drawn:  #{score[:drawn]}"
    puts "     "
    puts "     The winner is #{winner}!"
  end
end