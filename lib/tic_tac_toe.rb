class TicTacToe
  attr_reader :board
  
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
    ]
  
  def initialize
    @board = Array.new(9, " ")
  end
  
  
  #prints the current board representation based on @board:
   def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  #lets us pass in user input 1-9 that corresponds an index on @board array
  def input_to_index(input)
    input.to_i - 1
  end
  
  #takes in index that the player has chosen and their token (X/O) and changes the @board array at that element to the token
  def move(index, token="X")
    @board[index] = token
  end
  
  #returns false if the position on the board is not taken, and true if it is
  def position_taken?(index)
    if @board[index] == "X" || @board[index] == "O"
      true
    elsif @board[index] == " "
      false
    end
  end
  
  #accepts a position to chec, and returns true if the move is valid (is at an index that exists on the board and is not currently taken) and false/nil if not
  def valid_move?(position)
    position.between?(0, 8) && @board[position] == " " ? true : false
  end
  
  #returns the number of turns that have been played based on the @board
  def turn_count
    count = 0
    @board.each do |space|
      if space != " "
        count += 1
      end
    end
    count
  end
  
  #uses the turn_count method to determine if it's X's or O's turn 
  def current_player
    turn_count.even? ? "X" : "O"
  end
  
  #won? returns false or nil if there is no win combination present, and returns the winning combination indices if there is a win
  def won?
    WIN_COMBINATIONS.detect do |combo|
      if ((@board[combo[0]] == @board[combo[1]]) && (@board[combo[1]] == @board[combo[2]]) && (@board[combo[2]] == @board[combo[0]]))
          combo
      else
        false
      end
    end
  end
  
  #full? returns true if every element in board contains X or O:
  def full?
    !@board.any? {|space| space == " "}
  end
  
  
  #draw returns true if the board is full and has not been won, else returns false
  def draw?
    full? && !won? ? true : false
  end
  
  #over? returns true if the board was been won or is full(is a draw)
  def over?
    draw? || won? ? true : false
  end
  
  # #winner returns token "X" or "O" that has won the game when given a winning board
  def winner
    WIN_COMBINATIONS.detect do |combo|
      if ((@board[combo[0]] == "X") && (@board[combo[1]] == "X") && (@board[combo[2]] == "X"))
        return "X"
      elsif ((@board[combo[0]] == "O") && (@board[combo[1]] == "O") && (@board[combo[2]] == "O"))
        return "O"
      else
        nil
      end
    end
  end
  
  
  #defines the routine of a complete turn in the game
  def turn
    puts "Please input a number between 1 and 9 to choose a space."
    user_input = gets.strip
    index = input_to_index(user_input)
    player = current_player
    
    if valid_move?(index)
      move(index, player)
      display_board
    else
      turn
    end
  end
  
  #play method runs the game loop:
  def play
    while !over?
      turn
    end
  
    if won? 
        puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end



end