require_relative 'config/environment'

class Application < Sinatra::Base
  get '/' do
    @game = TicTacToe.new
    erb :index
  end

  post '/' do
    @game = TicTacToe.new
    @game.turns(params)
    if @game.won?
      erb :winner
    elsif @game.draw?
      erb :draw
    else
      erb :index
    end
  end
end
