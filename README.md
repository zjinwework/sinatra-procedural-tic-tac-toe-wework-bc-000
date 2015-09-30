---
tags:
languages:
resources:
---

# Sinatra Tic Tac Toe

## Objectives

1. Build an MVC Sinatra Application.
2. Use a model without a database.
3. Respond to `get` requests with Sinatra.
4. Render a HTML form with dynamic input values.
5. Response to `post` requests with Sinatra.
6. Pass form data through `params` to a model.
7. Conditionally render different templates.

## Overview

### Congratulations!!! You're amazing.

No matter how long you've been programming the challenge in this lesson is a major milestone. As trivial as building a web-based Tic Tac Toe application might sound, the techniques and concepts you'll implement our the foundations of every modern web application. Sure, being able to build Tic Tac Toe isn't the same as building the next Airbnb or Twitter, but I promise that anyone building applications at that scale at some point had to learn how to build something at this scale. There are not shortcuts.

### Demo

When you're done, your Tic Tac Toe application should function something like this:

<iframe width="853" height="480" src="https://www.youtube.com/embed/P3fojBzzlI8?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>

We're building a 2 player web-based Tic Tac Toe. Every form submission will represent an individual turn by a player. The board during a game should accurately represent the game state. Additionally, the board should automatically lock positions that have already been taken. The game should play until someone wins, after which, the application should congratulate the winning player. In the event of a draw, the application should inform the players of the Cat's Game.

### Project Structure

We've given you a scaffold for your project. This project follows the Model-View-Architecture (MVC) pattern for web applications so we're purposely configuring Sinatra to support MVC structure, so certain files might seem oddly placed, but we're doing it on purpose. Don't let any of that slow you down, just code where you think you should be coding.

```
├── Gemfile
├── Rakefile
├── app.rb
├── config
│   └── environment.rb
├── config.ru
├── models
│   └── game.rb
├── public
│   ├── images
│   ├── javascripts
│   │   └── app.js
│   └── stylesheets
│       ├── app.css
│       └── terminal.css
├── spec
│   ├── sinatra_tic_tac_toe_spec.rb
│   └── spec_helper.rb
└── views
    ├── draw.html.erb
    ├── index.html.erb
    ├── layout.erb
    └── winner.html.erb
```

#### `Gemfile`, `Rakefile`

These files setup some tools and gems for our project and can mostly be ignored. Make sure to run `bundle` before starting this project so that you have all the required gems.

#### `app.rb` - Our Application Controller

`app.rb` is going to defines our main controller, `Application`, inheriting from `Sinatra::Base`. You'll be building your two routes, `get '/'` and `post '/'` here.

#### `config/environment.rb`

Between Sinatra and our tests, this application has a somewhat complex environment. To consolidate the code for loading the requirements of the application, we created an `config/environment.rb` file that gets everything setup and ready to go. You do not ever need to edit this.

#### `config.ru`

`config.ru` is the main entry point for our application. `config.ru` loads our environment and starts our web application. `shotgun`, `rackup`, and our tests use this file to know how to start our application. You'll never need to edit this.

#### 'models/tic_tac_toe.rb'

`models/tic_tac_toe.rb` defines our main model, a `TicTacToe` class that entirely encapsulates all the logic and data required to play a game of tic tac toe in almost any interface, Web or CLI.

#### 'public/'

The `public` directory contains some static assets such as CSS and Javascript that will make our game behave and look decent in a browser. You do not need to ever edit these files but reading them would be fun.

#### `spec/`

Our `spec` directory contains our tests. `01_tic_tac_toe_spec.rb` includes tests for our `TicTacToe` model. `02_tic_tac_toe_integration_spec.rb` contains Capybara Integration Tests for our entire web application. Everything will need to be working to get these to pass.

#### `views`

Our views contain the HTML and ERB templates for our application's HTML interface. You'll have to build and edit 3 of these views, `index.erb`, `winner.erb`, and `draw.erb`. `layout.erb` provides a general layout to wrap all our views and you can mostly ignore this file. However, there are some bonuses and easter-eggs in this lab that will require you to edit this file.

### Development Server

You can startup a local development server for this application by first running `bundle` to install all the gem dependencies for this application and then running `shotgun`.

```
$ bundle
Using rake 10.4.2
etc...
Using bundler 1.10.6
Bundle complete! 10 Gemfile dependencies, 29 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.

$ shotgun
== Shotgun/Thin on http://127.0.0.1:9393/
Thin web server (v1.6.3 codename Protein Powder)
Maximum connections set to 1024
Listening on 127.0.0.1:9393, CTRL+C to stop
```

If you immediately navigate to `http://localhost:9393` you'll see a 404 error from sinatra because your application is not currently programmed to respond to a GET request to '/'. You'll fix that in a bit, move on.

## `models/tic_tac_toe.rb`

The first set of tests you should get passing are located in `01_tic_tac_toe_spec.rb`. They are unit tests for our Tic Tac Toe model and are totally isolated from our Web Application or our Controller. Run `learn spec/01_tic_tac_toe_spec.rb --fail-fast` to focus on just those failing tests one at a time.

Most of the methods required for our `TicTacToe` model will be familiar to you if you've built other version of Tic Tac Toe in Ruby.

We'll go over the requirements for each of the methods we test for in this lab.

### `#initialize`

Initialize just has to setup the default game state by creating an instance variable `@board` set to an array with 9 empty `" "` strings.

### `#board` and `#board=` attribute reader and writers.

Provide a `#board=` and a `#board` method to read and write to the internal instance variable `@board`.

### `#move`

`#move` will accept an index in the board to update along with a token to place in that position.

### `#position_taken?`

This method will accept an index in the board to check if it is occupied. If the position contains anything besides an unoccupied space, the method should return true, otherwise, it should return false to indicate the position in the board is available.

### `#turn_count`

This method returns the number of turns that have been played based on the board in `@board`

### `#current_player`

The `#current_player` method should use the `#turn_count` method to determine if it is `"X"`'s turn or `"O"`'s.

### `WIN_COMBINATIONS`

Define a constant in `models/tic_tac_toe.rb` `WIN_COMBINATIONS` within the `TicTacToe` class and set it equal to a nested array filled with the index values for the various win combinations in tic tac toe.

```ruby
# within the body of TicTacToe

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5]  # Middle row
  # ETC, an array for each win combination
]

# the rest of the TicTacToe class definition
```

### `#won?`

Your `#won?` method should return false/nil if there is no win combination present in the board and return the winning combination indexes as an array if there is a win. Use your `WIN_COMBINATIONS` constant in this method.

### `#draw?`

Build a method `#draw?` that returns true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won.

### `#winner`

The `#winner` method should return the token, "X" or "O" that has won the game given a winning board.

### `#turns`

We'll be initializing a new instance of a `TicTacToe` game upon every form submission from the user. Whether it's the first turn or the last, we'll be starting up a new game and updating it with all the turns that have occurred, basically fast-forwarding a new instance of `TicTacToe` to any given turn or game state using this method.

This method will accept a hash in the form of `{0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => "X", 5 => " ", 6 => " ", 7 => " ", 8 => " "}`, which would represent a game after the first turn where X moved into the middle.

Each key value pair in the hash represents a potential turn and the move that might have occurred. The key value pair `4 => "X"` means that `X` has at some point moved into the middle position. The key value pair of `0` => "" means that a move to the top left has not occurred.

With this hash, the `#turn` method should iterate over the key value pairs of the hash and update the game by sending the `#move` method with the appropriate data from the hash's key value pairs.

For example:
```ruby
game_state = {0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => "X", 5 => " ", 6 => " ", 7 => " ", 8 => " "}

game = TicTacToe.new
game.turns(game_state)

game.turn_count #=> 1, only one valid move has been made.
game.current_player #=> "O", it is O's turn.
game.board #=> [" ", " ", " ", " ", "X", " "," ", " ", " "] X in middle.
```

You'll see why this behavior is required shortly.

## Tic Tac Toe Integration Tests

Once our model is ready to handle the majority of the actual game logic, we need to build controller actions and routes to handle the HTTP requests for our application and the views those controllers will use to generate the appropriate HTML response.

### GET / - New Game

When a user goes to `/` for the first time, the application should initialize new game of Tic Tac Toe for the player and present them an HTML interface with which to interact with that game.

#### Request Basics

The first two tests require your `Application` controller to respond to a `GET` request at `/`. As long as a valid 200 response is sent back, regardless of the HTML returned, the first test will pass.

The second test expects that within your controller action's response to `GET /`, you also instantiate an instance of `TicTacToe`. You should assign this instance to an instance variable in the controller `@game`. Your views are going to use this object.

#### HTML for GET '/' - A Game Board

The third test expects that when a user visits `/` to start a new game, they see "Welcome to Tic Tac Toe!".

The fourth test begins to specify the requirements of the `<form>` that will be responsible for packaging the game data, including the moves a user makes, and submitting the input to the `Application` controller via a `POST` request to the same `/` URL.

2. Renders a welcome message
3. renders a form wrapper
4. renders a table with 9 inputs
5. labels and names inputs correctly
6. submit button
7. submit form

### Processing the Form
hits correct route
calls turn on board
renders view

### Updating the Form
8. input values updated
9. input set to read only



## Hints

### Console

## bonuses

6. Javascript
7. Theme
