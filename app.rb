require_relative 'config/environment'

class Application < Sinatra::Base
  get '/' do
    @game = Game.new
    erb :"index.html"
  end

  post '/' do
    @game = Game.new(params)
    if @game.won?
      erb :"winner.html"
    elsif @game.draw?
      erb :"draw.html"
    else
      erb :"index.html"
    end
  end
end
