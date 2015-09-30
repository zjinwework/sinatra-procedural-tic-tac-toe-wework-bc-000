ENV["SINATRA_ENV"] = "test"
ENV['RAKE_ENV'] ||= "development"

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  config.order = 'default'
end


def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
