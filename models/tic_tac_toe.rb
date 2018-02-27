class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9," ")
  end 
  
  def board=(board)
    @board = board
  end 
  
  def board
    @board
  end 
  
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end 
  
  def input_to_index(input)
    input.to_i - 1
  end 
  
  def move(index,player)
    @board[index] = player
  end
  
  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end 
  
  def valid_move?(index)
    index >= 0 && index <= 8 && @board[index] == " "
  end
  
  def turn
    puts "Please input 1-9:"
    
    index = input_to_index(gets)
    
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end
  
  def turn_count
    @board.count do |value| 
      value == "X" or value == "O"
    end
  end
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end 
  
  def won?
    WIN_COMBINATIONS.each do |combo|
      all_x = combo.all? do |index|
        @board[index] == "X"
      end
      all_o = combo.all? do |index|
        @board[index] == "O"
      end 
      
      if all_x || all_o
        return combo
      end
    end
    return false
  end  
  
  def full?
    @board.all? do |value| 
      value == "X" || value == "O"
    end 
  end 
  
  def draw?
    full? && !won?
  end 
  
  def over?
    won? || full? || draw?
  end 
  
  def winner
    combo = won?
    if combo
      @board[combo[0]]
    end
  end
  
  # def play
  #   while !over?
  #     turn
  #   end
    
  #   if won?
  #     puts "Congratulations #{winner}!"
  #   elsif draw?
  #     puts "Cat's Game!"
  #   end 
  # end 
  
  def turns(game_state)
    display_board
    game_state.each do |key, value|
      puts value
      @board[key.to_i] = value
    end
  end
end