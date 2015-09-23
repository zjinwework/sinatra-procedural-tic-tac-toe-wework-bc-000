ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'


RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  config.order = 'default'
end

# HELPERS #

def player_x_plays_to_win
  visit '/'
  fill_in('0', :with => 'X') 
  click_button 'Submit Move'
  fill_in('1', :with => 'O') 
  click_button 'Submit Move'
  fill_in('4', :with => 'X') 
  click_button 'Submit Move'
  fill_in('5', :with => 'O') 
  click_button 'Submit Move'
  fill_in('8', :with => 'X') 
  click_button 'Submit Move'
end

def player_o_plays_to_win
  visit '/'
  fill_in('0', :with => 'O') 
  click_button 'Submit Move'
  fill_in('1', :with => 'X') 
  click_button 'Submit Move'
  fill_in('4', :with => 'O') 
  click_button 'Submit Move'
  fill_in('5', :with => 'X') 
  click_button 'Submit Move'
  fill_in('8', :with => 'O') 
  click_button 'Submit Move'
end

def tied_game
  visit '/'
  fill_in('0', :with => 'X') 
  click_button 'Submit Move'
  fill_in('1', :with => 'O') 
  click_button 'Submit Move'
  fill_in('2', :with => 'X') 
  click_button 'Submit Move'
  fill_in('3', :with => 'O') 
  click_button 'Submit Move'
  fill_in('4', :with => 'O') 
  click_button 'Submit Move'
  fill_in('5', :with => 'X')
  click_button 'Submit Move' 
  fill_in('6', :with => 'X')
  click_button 'Submit Move'
  fill_in('7', :with => 'X')
  click_button 'Submit Move'
  fill_in('8', :with => 'O')
  click_button 'Submit Move'
end


def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app