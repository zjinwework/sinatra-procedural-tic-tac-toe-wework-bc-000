require 'spec_helper'

describe './app.rb - Tic Tac Toe Sinatra' do
  describe 'GET / - New Game' do
    it 'responds with a 200 status code' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'initializes a new instance of TicTacToe' do
      expect(TicTacToe).to receive(:new)

      get '/'
    end

    it 'shows a welcome message' do
      visit '/'

      expect(page).to have_text("Welcome to Tic Tac Toe!")
    end

    it 'has a form configured to submit to POST /' do
      visit '/'

      expect(page).to have_selector("form")
      expect(page).to have_selector("form[action='/']")
      expect(page).to have_selector("form[method='POST']")
    end
  end

#   describe "index page: GET /" do
#     it "responds with a 200 status code" do
#       get '/'
#       expect(last_response).to be_ok
#     end
#
#     it "renders the index template" do
#       get '/'
#       expect(last_response.body).to include("Welcome to Learn.co TicTacToe")
#     end
#   end
#
#   describe "POST / when player X has submitted a final, winning move" do
#     it "renders the winner tempalte" do
#       params = {"0"=>"X", "1"=>"O", "2"=>"", "3"=>"", "4"=>"X", "5"=>"O", "6"=>"", "7"=>"", "8"=>"X"}
#       post '/', params
#       expect(last_response.body).to include("Congratulations X, you have won the game!")
#     end
#   end
#
#   describe "POST / when player O has submitted a final, winning move" do
#     it "renders the winner tempalte" do
#       params = {"0"=>"O", "1"=>"X", "2"=>"", "3"=>"", "4"=>"O", "5"=>"X", "6"=>"", "7"=>"", "8"=>"O"}
#       post '/', params
#       expect(last_response.body).to include("Congratulations O, you have won the game!")
#     end
#   end
#
#   describe "POST / when there is a draw" do
#     it "renders the draw template" do
#       params = {"0"=>"X", "1"=>"O", "2"=>"X", "3"=>"O", "4"=>"O", "5"=>"X", "6"=>"X", "7"=>"X", "8"=>"O"}
#       post '/', params
#       expect(last_response.body).to include("Cats Game!")
#     end
#   end
# end
#
#
# describe "game play" do
#   describe "Player X wins the game" do
#     it "plays the game and shows the winner page, congratulating X" do
#       visit '/'
#       fill_in('0', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('1', :with => 'O')
#       click_button 'Submit Move'
#       fill_in('4', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('5', :with => 'O')
#       click_button 'Submit Move'
#       fill_in('8', :with => 'X')
#       click_button 'Submit Move'
#       expect(page.body).to include("Congratulations X, you have won the game!")
#     end
#   end
#
#   describe "Player O wings the game" do
#     it "plays the game and shows the winner page, congratulating O" do
#       visit '/'
#       fill_in('0', :with => 'O')
#       click_button 'Submit Move'
#       fill_in('1', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('4', :with => 'O')
#       click_button 'Submit Move'
#       fill_in('5', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('8', :with => 'O')
#       click_button 'Submit Move'
#       expect(page.body).to include("Congratulations O, you have won the game!")
#     end
#   end
#
#   describe "There is a tie" do
#     it "plays the game and shows the draw page if there is a tie" do
#       visit '/'
#       fill_in('0', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('1', :with => 'O')
#       click_button 'Submit Move'
#       fill_in('2', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('3', :with => 'O')
#       click_button 'Submit Move'
#       fill_in('4', :with => 'O')
#       click_button 'Submit Move'
#       fill_in('5', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('6', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('7', :with => 'X')
#       click_button 'Submit Move'
#       fill_in('8', :with => 'O')
#       click_button 'Submit Move'
#       expect(page.body).to include("Cats Game!")
#     end
#   end
end
