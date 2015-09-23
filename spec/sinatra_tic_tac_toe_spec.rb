require 'spec_helper'

describe "controller in app.rb" do
  describe "index page: GET /" do
    it "responds with a 200 status code" do
      get '/'
      expect(last_response).to be_ok
    end

    it "renders the index template" do
      get '/'
      expect(last_response.body).to include("Welcome to Learn.co TicTacToe")
    end
  end

  describe "POST / when player X has submitted a final, winning move" do
    it "renders the winner tempalte" do 
      params = {"0"=>"X", "1"=>"O", "2"=>"", "3"=>"", "4"=>"X", "5"=>"O", "6"=>"", "7"=>"", "8"=>"X"}
      post '/', params
      expect(last_response.body).to include("Congratulations X, you have won the game!")
    end
  end

  describe "POST / when player O has submitted a final, winning move" do
    it "renders the winner tempalte" do 
      params = {"0"=>"O", "1"=>"X", "2"=>"", "3"=>"", "4"=>"O", "5"=>"X", "6"=>"", "7"=>"", "8"=>"O"}
      post '/', params
      expect(last_response.body).to include("Congratulations O, you have won the game!")
    end
  end

  describe "POST / when there is a draw" do
    it "renders the draw template" do 
      params = {"0"=>"X", "1"=>"O", "2"=>"X", "3"=>"O", "4"=>"O", "5"=>"X", "6"=>"X", "7"=>"X", "8"=>"O"}
      post '/', params
      expect(last_response.body).to include("Cats Game!")
    end 
  end
end


describe "game play" do 
  describe "Player X wins the game" do 
    it "plays the game and shows the winner page, congratulating X" do 
      player_x_plays_to_win
      expect(page.body).to include("Congratulations X, you have won the game!")
    end
  end

  describe "Player O wings the game" do
    it "plays the game and shows the winner page, congratulating O" do
      player_o_plays_to_win
      expect(page.body).to include("Congratulations O, you have won the game!")       
    end 
  end

  describe "There is a tie" do 
    it "plays the game and shows the draw page if there is a tie" do 
      tied_game
      expect(page.body).to include("Cats Game!")
    end
  end
end



























