class Game
  attr_accessor :board
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize(params = {})
    @board = []
    update_board(params)
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def update_board(params)
    params.each do |location, token|
      move(location.to_i, token)
    end
  end

  def move(location, token)
    if location.between?(0,8) && !position_taken?(location)
      @board[location] = token
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      position(combo[0]) == position(combo[1]) &&
      position(combo[1]) == position(combo[2]) &&
      position_taken?(combo[0])
    end
  end

  def draw?
    !won? && @board.all?{|token| token == "X" || token == "O"}
  end

  def winner
    if winning_combo = won?
      @winner = position(winning_combo.first)
    end
  end

  def position(location)
    @board[location.to_i]
  end
  
  def position_taken?(location)
    !(position(location).nil? || position(location) == "")
  end
end