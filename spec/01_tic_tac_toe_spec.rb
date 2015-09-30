require_relative '../models/tic_tac_toe.rb'

describe './models/tic_tac_toe.rb' do
  describe TicTacToe do
    describe '#initialize' do
      it 'assigns an instance variable @board to an array with 9 blank spaces " "' do
        game = TicTacToe.new
        expect(game.instance_variable_get(:@board)).to eq([" "," "," "," "," "," "," "," "," "])
      end
    end

    describe '#board and #board=' do
      it 'allows you to assign and read the @board instance variable' do
        game = TicTacToe.new
        expect(game.board).to eq(Array.new(9, " "))

        game.board = ["X", "X", "X", "X", "X", "O", "O", "O", "O"]
        expect(game.board).to eq(["X", "X", "X", "X", "X", "O", "O", "O", "O"])
      end
    end

    describe '#move' do
      it 'allows "X" player in the top left and "O" in the middle' do
        game = TicTacToe.new
        game.move(1, "X")
        game.move(5, "O")

        board = game.instance_variable_get(:@board)

        expect(board).to eq(["X", " ", " ", " ", "O", " ", " ", " ", " "])
      end
    end

    describe '#position_taken?' do
      it 'returns true/false based on position in board' do
        game = TicTacToe.new
        board = ["X", " ", " ", " ", " ", " ", " ", " ", "O"]
        game.instance_variable_set(:@board, board)

        position = 0
        expect(game.position_taken?(position)).to be(true)

        position = 8
        expect(game.position_taken?(position)).to be(true)

        position = 1
        expect(game.position_taken?(position)).to be(false)

        position = 7
        expect(game.position_taken?(position)).to be(false)
      end
    end

    describe '#turn_count' do
      it 'counts occupied positions' do
        game = TicTacToe.new
        board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.turn_count).to eq(3)
      end
    end

    describe '#current_player' do
      it 'returns the correct player, X, for the third move' do
        game = TicTacToe.new
        board = ["O", " ", " ", " ", "X", " ", " ", " ", " "]
        game.instance_variable_set(:@board, board)

        expect(game.current_player).to eq("X")
      end
    end

    describe "#won?" do
      it 'returns false for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.won?).to be_falsey
      end

      it 'returns true for a win' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.won?).to be_truthy
      end
    end

    describe '#draw?' do
      it 'returns true for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_truthy
      end

      it 'returns false for a won game' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_falsey
      end

      it 'returns false for an in-progress game' do
        game = TicTacToe.new
        board = ["X", " ", "X", " ", "X", " ", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_falsey
      end
    end

    describe '#winner' do
      it 'return X when X won' do
        game = TicTacToe.new
        board = ["X", " ", " ", " ", "X", " ", " ", " ", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to eq("X")
      end

      it 'returns O when O won' do
        game = TicTacToe.new
        board = ["X", "O", " ", " ", "O", " ", " ", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to eq("O")
      end

      it 'returns nil when no winner' do
        game = TicTacToe.new
        board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to be_nil
      end
    end

    describe '#turns' do

    end
  end
end
